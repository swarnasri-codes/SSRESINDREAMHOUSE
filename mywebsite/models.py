from flask import current_app
from .db import get_db_connection  # Import your MySQL connection function

class Pendant:
    @staticmethod
    def get_all():
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)  # Fetch results as dictionaries
        cursor.execute("SELECT * FROM pendants")
        pendants = cursor.fetchall()
        cursor.close()
        conn.close()
        return pendants

class Earring:
    @staticmethod
    def get_all():
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM earrings")
        earrings = cursor.fetchall()
        cursor.close()
        conn.close()
        return earrings
    
class Bracelet:
    @staticmethod
    def get_all():
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM bracelets")
        bracelets = cursor.fetchall()
        cursor.close()
        conn.close()
        return bracelets
    
class Users:
    @staticmethod
    def get_user_by_email(email):
        """Fetch a user from the database using their email."""
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM users WHERE email = %s", (email,))
        user = cursor.fetchone()  # Fetch a single user
        cursor.close()
        conn.close()
        return user 
    
class Orders:
    @staticmethod
    def get_orders_by_user_email(email):
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)  # Ensure it returns dictionaries

        cursor.execute("""
            SELECT o.*, 
                   oi.product_id, oi.product_type, oi.name, oi.price, oi.quantity, oi.image
            FROM SSRESINS.orders o
            LEFT JOIN SSRESINS.order_items oi ON o.id = oi.order_id
            WHERE o.email = %s
        """, (email,))

        rows = cursor.fetchall()  
        cursor.close()
        conn.close()

        # Debugging - Print fetched rows
        print("Fetched Orders:", rows)

        # Process fetched rows into structured orders
        orders = {}
        for row in rows:
            order_id = row["id"]
            if order_id not in orders:
                orders[order_id] = {
                    "id": row["id"],
                    "email": row["email"],
                    "country": row["country"],
                    "first_name": row["first_name"],
                    "total_price": 0,  # Initialize total price
                    "items": []
                }
            if row["product_id"]:  # Ensure there's an item
                item_total = row["price"] * row["quantity"]  # ✅ Calculate item total
                orders[order_id]["total_price"] += item_total  # ✅ Add to order total
                orders[order_id]["items"].append({
                    "product_id": row["product_id"],
                    "product_type": row["product_type"],
                    "name": row["name"],
                    "price": row["price"],
                    "quantity": row["quantity"],
                    "image": row["image"]
                })

        return list(orders.values())  # Convert dict to list before returning
