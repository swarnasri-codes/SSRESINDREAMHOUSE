from flask import Blueprint, current_app, flash, jsonify, redirect, render_template, request, abort, session, url_for
from flask_mail import Message
from mywebsite.models import Pendant, Earring, Bracelet, Users, Orders
from .db import get_db_connection
from flask_paginate import Pagination, get_page_args


views = Blueprint('views', __name__)

def send_order_email(email, order_id, formatted_items, total_price):
    msg = Message(
        subject="Your SSResinDreamHouse Order Confirmation",
        sender="ssresindreamhouse@gmail.com",
        recipients=[email],
    )

    email_body = f"""
    <html>
    <body style="font-family: Arial, sans-serif; padding: 20px;">
        <p style="color: #800080; font-size: 18px;"><strong>Dear Customer,</strong></p>
        <p>Thank you for your order! 🎉</p>
        <p><strong>Order ID:</strong> {order_id}</p>

        <h3>Items:</h3>
        <table style="width: 100%; border-collapse: collapse; text-align: left;">
            <tbody>
                {formatted_items}
            </tbody>
        </table>

        <p><strong>Total Price:</strong> ₹{total_price:.2f}</p>
        <p>We will process your order soon. Stay tuned!</p>

        <p style="font-size: 14px; color: #888;">- SSResinDreamHouse Team</p>
    </body>
    </html>
    """

    msg.html = email_body
    try:
        current_app.mail.send(msg)
        print("✅ Order confirmation email sent successfully!")
    except Exception as e:
        print(f"❌ Failed to send email: {e}")

def get_cart_count():
    cart = session.get('cart', [])
    return sum(item['quantity'] for item in cart)

def get_user_by_email(email):
    """Fetch a user from the database using their email."""
    return Users.query.filter_by(email=email).first()


@views.app_context_processor
def inject_cart_count():
    return dict(cart_count=get_cart_count())

@views.route('/')
def home():
    cart_count = get_cart_count() 
    return render_template("home.html", cart_count=cart_count)

@views.route('/pendants')
def pendants():
    all_pendants = Pendant.get_all()  
    return render_template('pendants.html', pendants=all_pendants)

@views.route('/earrings')
def earrings():
    all_earrings = Earring.get_all() 
    return render_template('earrings.html', earrings=all_earrings)

@views.route('/bracelets')
def bracelets():
    all_bracelets = Bracelet.get_all() 
    return render_template('bracelets.html', bracelets=all_bracelets)

@views.route('/contact-us')
def contact_us():
    return render_template('contact_us.html')

@views.route('/privacy-policy')
def privacy_policy():
    return render_template('privacy_policy.html')

@views.route('/terms-of-service')
def terms_of_service():
    return render_template('terms_of_service.html')

@views.route('/product-details/<product_type>/<int:product_id>')
def product_details(product_type, product_id):
    
    table_map = {
        "pendants": "pendants",
        "earrings": "earrings",
        "bracelets": "bracelets"
    }

    if product_type not in table_map:
        return abort(400, "Invalid product type")

    table_name = table_map[product_type]

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    try:
        query = f"SELECT * FROM {table_name} WHERE id = %s"
        print(f"Query: SELECT * FROM {table_name} WHERE id = {product_id}")
        print(f"Product Type: {product_type}, Product ID: {product_id}")
        cursor.execute(query, (product_id,))
        product = cursor.fetchone()
    except Exception as e:
        print(f"Error fetching product details: {e}")
        return abort(500, "Internal Server Error")
    finally:
        cursor.close()
        conn.close()

    if not product:
        return abort(404, "Product not found")

    return render_template('product_details.html', product=product, product_type=product_type)

@views.route('/search', methods=['GET'])
def search():
    query = request.args.get('query', '').strip()
    if not query:
        return render_template('search.html', products=[], query=query)

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        tables = ['pendants', 'earrings', 'bracelets']
        search_results = []

        for table in tables:
            sql_query = f"""
                SELECT *, '{table}' AS product_type 
                FROM {table} 
                WHERE name LIKE %s OR description LIKE %s
            """
            cursor.execute(sql_query, (f"%{query}%", f"%{query}%"))
            search_results.extend(cursor.fetchall())
    finally:
        cursor.close()
        conn.close()

    # Pagination
    page, per_page, offset = get_page_args(page_parameter='page', per_page_parameter='per_page')
    total = len(search_results)
    paginated_results = search_results[offset: offset + per_page]
    pagination = Pagination(page=page, per_page=per_page, total=total, record_name='products')

    return render_template('search.html', 
                           products=paginated_results, 
                           query=query, 
                           pagination=pagination)
    
@views.route('/autocomplete', methods=['GET'])
def autocomplete():
    query = request.args.get('query', '').strip()
    if not query:
        return jsonify([])

    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        tables = ['pendants', 'earrings', 'bracelets']
        suggestions = []

        for table in tables:
            sql_query = f"SELECT name FROM {table} WHERE name LIKE %s LIMIT 5"
            cursor.execute(sql_query, (f"%{query}%",))
            suggestions.extend([row[0] for row in cursor.fetchall()])
    finally:
        cursor.close()
        conn.close()

    return jsonify(suggestions)

@views.route('/cart')
def cart():
    cart_items = session.get('cart', [])
    total_price = sum(item['price'] * item['quantity'] for item in cart_items)
    cart_count = get_cart_count()
    session.modified = True 
    return render_template("cart.html", cart_items=cart_items, total_price=total_price, cart_count=cart_count)

@views.route('/cart-data')
def cart_data():
    cart_items = session.get('cart', [])
    total_price = sum(item['price'] * item['quantity'] for item in cart_items)

    return jsonify({
        "success": True,
        "cart_items": cart_items,
        "total_price": total_price
    })


@views.route('/add-to-cart', methods=['POST'])
def add_to_cart():
    product_data = request.get_json()

    if 'cart' not in session:
        session['cart'] = []

    cart = session['cart']

    # Check if product already exists in cart
    for item in cart:
        if item['id'] == product_data['product_id'] and item['product_type'] == product_data['product_type']:
            item['quantity'] += int(product_data['quantity'])  
            break
    else:
        # If not in cart, add new item
        cart.append({
            'id': product_data['product_id'],
            'name': product_data['name'],
            'price': float(product_data['price']),
            'image': product_data['image'],
            'quantity': int(product_data['quantity']),
            'product_type': product_data['product_type']
        })

    session['cart'] = cart
    session.modified = True

    # Update the cart table in the database
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        # Check if the product already exists in the cart table
        cursor.execute(
            "SELECT * FROM SSRESINS.cart WHERE product_id = %s AND product_type = %s",
            (product_data['product_id'], product_data['product_type'])
        )
        existing_item = cursor.fetchone()

        if existing_item:
            # Update the quantity if the product already exists in the cart table
            cursor.execute(
                "UPDATE SSRESINS.cart SET quantity = quantity + %s WHERE product_id = %s AND product_type = %s",
                (product_data['quantity'], product_data['product_id'], product_data['product_type'])
            )
        else:
            # Insert a new item if it does not exist in the cart table
            cursor.execute(
                "INSERT INTO SSRESINS.cart (product_id, name, price, image, quantity, product_type) VALUES (%s, %s, %s, %s, %s, %s)",
                (product_data['product_id'], product_data['name'], product_data['price'], product_data['image'], product_data['quantity'], product_data['product_type'])
            )

        conn.commit()
        cursor.close()
        conn.close()

    except Exception as e:
        print(f"Error updating cart in database: {e}")
        return jsonify({'success': False, 'message': 'Failed to update cart in database.'}), 500

    return jsonify({'success': True, 'cart_count': get_cart_count()})

@views.route('/remove-from-cart', methods=['POST'])
def remove_from_cart():
    data = request.json
    product_id = str(data.get('product_id'))
    product_type = data.get('product_type')

    cart = session.get('cart', [])

    # Print cart before removing item
    print("Cart before removal:", cart)

    # Remove the selected item from the cart
    updated_cart = [item for item in cart if not (str(item['id']) == product_id and item['product_type'] == product_type)]

    session['cart'] = updated_cart  # Update session with modified cart
    session.modified = True  # Ensure session changes are saved

    # Print cart after removing item
    print("Cart after removal:", session['cart'])

    return jsonify({'success': True, 'cart_count': get_cart_count()})

@views.route('/update-cart', methods=['POST'])
def update_cart():
    data = request.json
    product_id = str(data.get('product_id'))  # Convert to string to ensure consistency
    product_type = data.get('product_type')
    new_quantity = int(data.get('quantity'))

    cart = session.get('cart', [])

    print(f"🔹 Received update request: ID={product_id}, Type={product_type}, Quantity={new_quantity}")
    print(f"🔹 Current Cart: {cart}")
    
    updated_subtotal = 0
    found = False

    for item in cart:
        print(f"🔎 Checking item in cart: ID={item['id']} Type={item['product_type']}")  # Debugging output

        # Ensure both ID and Type match correctly
        if str(item['id']) == product_id and item['product_type'] == product_type:
            print(f"✅ Found! Updating {item['name']} from {item['quantity']} to {new_quantity}")
            item['quantity'] = new_quantity
            updated_subtotal = item['price'] * item['quantity']
            found = True
            break  # No need to continue checking once found

    if not found:
        print(f"⚠️ Product {product_id} of type {product_type} not found in cart!")
        return jsonify({"success": False, "message": "Product not found in cart!"})

    session['cart'] = cart
    session.modified = True

    # Calculate new total price
    total_price = sum(item['price'] * item['quantity'] for item in cart)

    return jsonify({
        "success": True,
        "cart_count": get_cart_count(),
        "total_price": total_price,
        "updated_subtotal": updated_subtotal
    })

# @views.route('/update-cart', methods=['POST'])
# def update_cart():
#     data = request.json
#     product_id = str(data.get('product_id'))  # Ensure product_id is a string
#     product_type = data.get('product_type')
#     new_quantity = int(data.get('quantity'))

#     cart = session.get('cart', [])

#     print("Checking cart items...")  # Debugging
#     for item in cart:
#         print(f"Cart Item ID Type: {type(item['id'])}, Value: {item['id']}")  # Debugging
#         print(f"Incoming Product ID Type: {type(product_id)}, Value: {product_id}")  # Debugging

#         if str(item['id']) == product_id and item['product_type'] == product_type:
#             print(f"Match found for product {product_id}!")  # Debugging
#             item['quantity'] = new_quantity  # Update quantity
#             updated_subtotal = item['price'] * item['quantity']  # Calculate updated subtotal
#             break
#     else:
#         print(f"Product {product_id} not found in cart!")  # Debugging

#     session['cart'] = cart
#     session.modified = True  # Save session

#     # Recalculate total price
#     total_price = sum(item['price'] * item['quantity'] for item in cart)

#     return jsonify({
#         "success": True,
#         "cart_count": get_cart_count(),
#         "total_price": total_price,
#         "updated_subtotal": updated_subtotal  # Return updated subtotal for the item
#     })

@views.route("/checkout", methods=["GET", "POST"])
def checkout():
    cart_items = session.get("cart", [])
    if not cart_items:
        flash("Your cart is empty!", "error")
        return redirect(url_for("views.home"))

    total_price = sum(item["price"] * item["quantity"] for item in cart_items)
    sub_total = total_price
    tax_rate = 0.1  # 10% tax, adjust as needed
    tax = total_price * tax_rate
    shipping_fee = 40.00  # Static shipping fee, adjust if necessary
    grand_total = total_price + tax + shipping_fee

    return render_template("checkout.html", cart_items=cart_items,  subtotal=sub_total, total_price=total_price, tax=tax, shipping_fee=shipping_fee, grand_total=grand_total)

@views.route("/process_checkout", methods=["POST"])
def process_checkout():
    if request.method == "POST":
        email = request.form.get("email")
        country = request.form.get("country")
        first_name = request.form.get("first_name")
        last_name = request.form.get("last_name")
        address = request.form.get("address")
        apartment = request.form.get("apartment")
        city = request.form.get("city")
        state = request.form.get("state")
        pincode = request.form.get("pincode")
        phone = request.form.get("phone")
        payment_method = "cod"
    
        if not all([email, country, first_name, last_name, address, city, state, pincode, phone, payment_method]):
            flash("Please fill out all the fields.", "error")
            return redirect(url_for("views.checkout"))

        cart_items = session.get("cart", [])
        if not cart_items:
            flash("Your cart is empty!", "error")
            return redirect(url_for("views.checkout"))

        try:
            conn = get_db_connection()
            cursor = conn.cursor()

            cursor.execute(
                "INSERT INTO SSRESINS.orders (email, country, first_name, last_name, address, apartment, city, state, pincode, phone, payment_method) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
                (email, country, first_name, last_name, address, apartment, city, state, pincode, phone, payment_method)
            )
            order_id = cursor.lastrowid

            for item in cart_items:
                cursor.execute(
                    "INSERT INTO SSRESINS.order_items (order_id, product_id, product_type, quantity, name, price, image) VALUES (%s, %s, %s, %s, %s, %s, %s)",
                    (order_id, item.get('id'), item.get('product_type'), item.get('quantity'), item.get('name'), item.get('price'), item.get('image'))
                )

            conn.commit()
            cursor.close()
            conn.close()

            formatted_items = "".join(
                f"{item['quantity']}x {item['name']} - ₹{item['price'] * item['quantity']:.2f}<br>"
                for item in cart_items
            )
            # Prepare order details for email
            # order_details = "\n".join([f"{item['quantity']}x {item['name']} - ${item['price']}" for item in cart_items])
            total_price = sum(item.get('price', 0) * item.get('quantity', 1) for item in cart_items)

            # Send order confirmation email
            send_order_email(email, order_id, formatted_items, total_price)

            session['cart'] = []
            session.modified = True

            flash("Order placed successfully!", "success")
            return redirect(url_for("views.order_confirmation", order_id=order_id))

        except Exception as e:
            print(f"Error inserting order: {e}")
            flash("Failed to place order. Please try again.", "error")
            return redirect(url_for("views.checkout"))
        
@views.route('/orders')
def orders():
    if 'email' not in session:
        return redirect(url_for('auth.login'))  # Redirect if not logged in

    user = Users.get_user_by_email(session['email'])  # Fetch user data

    if not user:
        return redirect(url_for('auth.login'))  # Redirect if user not found

    user_orders = Orders.get_orders_by_user_email(user['email'])  # Fetch orders for user

    print("Fetched Orders:", user_orders)  # Debugging output

    return render_template('orders.html', orders=user_orders)
# @views.route('/orders')
# def orders():
#     user_id = session.get('user_id')
#     if not user_id:
#         return redirect(url_for('auth.login'))

#     connection = get_db_connection()
#     orders = []

#     if connection:
#         try:
#             cursor = connection.cursor(dictionary=True)
#             cursor.execute("""
#                 SELECT o.id AS order_id, o.total_price, o.created_at, 
#                        oi.product_name, oi.product_image, oi.price, oi.quantity
#                 FROM orders o
#                 JOIN order_items oi ON o.id = oi.order_id
#                 WHERE o.user_id = %s
#                 ORDER BY o.created_at DESC
#             """, (user_id,))
            
#             orders = cursor.fetchall()
#             cursor.close()
#         finally:
#             connection.close()

#     return render_template('orders.html', orders=orders)

@views.route("/order_confirmation/<int:order_id>")
def order_confirmation(order_id):
    # Display the order confirmation details
    return render_template("order_confirmation.html", order_id=order_id)

@views.route('/profile')
def profile():
    user_email = session.get('email')
    if not user_email:
        return redirect(url_for('auth.login'))
    
    return render_template('profile.html', email=user_email)


