from flask import Blueprint, render_template, request, session, redirect, url_for, flash, current_app
from flask_mail import Mail, Message
import random
import string
import traceback
from mysql.connector import Error
from datetime import datetime
from .db import get_db_connection


# Blueprint setup
auth = Blueprint('auth', __name__)

def generate_login_code():
    return ''.join(random.choices(string.ascii_uppercase + string.digits, k=6))

# Route: Login
@auth.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form.get('email')
        print(f"Email: {email}")
        if not email:
            flash('Please provide an email address', 'error')
            return redirect(url_for('auth.login'))

        connection = get_db_connection()
        if connection:
            try:
                cursor = connection.cursor()
                
                cursor.execute("SELECT email FROM users WHERE email = %s", (email,))
                existing_user = cursor.fetchone()
                
                if not existing_user:
                    cursor.execute("""
                        INSERT INTO users (email, created_at) 
                        VALUES (%s, %s)
                    """, (email, datetime.now()))
                    connection.commit()
                
                cursor.close()

            except Error as e:
                flash('Error registering user. Please try again.', 'error')
                print(f"MySQL Error: {e}")
                return redirect(url_for('auth.login'))
            finally:
                if connection:
                    connection.close()

        login_code = generate_login_code()

        connection = get_db_connection()  
        if connection:
            try:
                cursor = connection.cursor()

                cursor.execute("DELETE FROM login_codes WHERE email = %s", (email,))
                connection.commit()
                
                cursor.execute("""
                    INSERT INTO login_codes (email, code, created_at, expires_at)
                    VALUES (%s, %s, %s, DATE_ADD(NOW(), INTERVAL 10 MINUTE))
                """, (email, login_code, datetime.now()))

                print("Login code inserted")
                connection.commit()
                cursor.close()
            except Error as e:
                flash('Error saving the login code. Please try again.', 'error')
                print(f"MySQL Error: {e}")
                return redirect(url_for('auth.login'))
            finally:
                if connection:
                    connection.close()

        try:
            msg = Message(
                subject="Your SSRESINDREAMHOUSE login code",
                sender='ssresindreamhouse@gmail.com',
                recipients=[email],
                body = (
                    f"Dear Customer,\n\n"
                    f"Your login code is {login_code}.\n\n"
                    "For security reasons, this code will expire in 10 minutes.\n"
                    "Please do not share this code with anyone.\n\n"
                    "If you did not request this login code, please ignore this email or contact our support team.\n\n"
                    "Thank you,\nSSResinDreamHouse Team"
                ).encode('ascii', 'ignore').decode('ascii')

            )
            current_app.mail.send(msg)
            flash('A login code has been sent to your email.', 'success')
            session['email'] = email
            return render_template('login.html', step="code", email=email)
        except Exception as e:
            flash('Error sending email. Please try again.', 'error')
            print(f"Email Error: {e}")
            print(traceback.format_exc())
            return redirect(url_for('auth.login'))

    return render_template('login.html', step="email")

# @auth.route('/test-smtp')
# def test_email():
#     try:
#         msg = Message(
#             subject="Test Email",
#             sender=current_app.config['MAIL_USERNAME'],
#             recipients=['swarnasri20870@gmail.com'],
#             body="This is a test email from SSResinDreamHouse."
#         )
#         current_app.mail.send(msg)
#         return "Test email sent successfully!"
#     except Exception as e:
#         return f"Error: {e}"


@auth.route('/verify-code', methods=['POST'])
def verify_code():
    email = session.get('email')
    if not email:
        return redirect(url_for('auth.login'))

    entered_code = request.form.get('code')

    connection = get_db_connection()
    if connection:
        try:
            cursor = connection.cursor(dictionary=True)
            cursor.execute("SELECT code FROM login_codes WHERE email = %s", (email,))
            record = cursor.fetchone()
            cursor.close()

            if record and str(record['code']) == entered_code:
                cursor = connection.cursor()
                cursor.execute("DELETE FROM login_codes WHERE email = %s", (email,))
                connection.commit()
                cursor.close()

                session['logged_in'] = True
                flash('Login successful!', 'success')
                return redirect(url_for('views.home'))
            else:
                flash('Invalid code. Please try again.', 'danger')
        except Error as e:
            flash('Error verifying the login code. Please try again.', 'error')
            print(f"MySQL Error: {e}")
        finally:
            connection.close()

    return render_template('login.html', step="code", email=email)

@auth.route('/profile')
def profile():
    if 'email' not in session:
        flash('You need to log in to view your profile.', 'warning')
        return redirect(url_for('auth.login'))

    return render_template('profile.html', email=session['email'])

@auth.route('/logout')
def logout():
    session.pop('user_id', None)  # Remove user ID from session
    session.pop('email', None) # Remove email from session
    session.pop('cart', None)  # Remove cart from session
    flash('You have been logged out.', 'info')
    return redirect(url_for('views.home'))

