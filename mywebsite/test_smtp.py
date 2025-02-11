import smtplib

sender = "ssresindreamhouse@gmail.com"
password = "Swarnasimla"  # Replace with your App Password or actual password
recipient = "swarnasri20870@gmail.com"

try:
    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.starttls()
    server.login(sender, password)
    server.sendmail(sender, recipient, "Subject: Test Email\n\nThis is a test email.")
    print("Email sent successfully!")
    server.quit()
except Exception as e:
    print(f"Error sending email: {e}")
