from flask import Flask
import mysql.connector
from flask_mail import Mail
from mywebsite.config import Config



# Initialize Flask-Mail
mail = Mail()
 
def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    # Initialize Flask-Mail with app config
    mail.init_app(app)
    
    # Attach mail object to app instance
    app.mail = mail

    # Database connection setup
    def get_db_connection():
        return mysql.connector.connect(
            host='localhost',
            user='root',
            password='07062002',
            database='SSRESINS'    
        )

    # Open a database connection before each request
    @app.before_request
    def before_request():
        connection = get_db_connection()
        setattr(app, 'db_connection', connection)
        
    # Close the database connection after each request
    @app.teardown_request
    def teardown_request(exception):
        connection = getattr(app, 'db_connection', None)
        if connection:
            connection.close()

    # Register Blueprints
    from .auth import auth
    from .views import views
    app.register_blueprint(auth, url_prefix='/auth')
    app.register_blueprint(views, url_prefix='/')
    
    return app
