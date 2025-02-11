import os
from dotenv import load_dotenv
load_dotenv()

class Config:
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'Swarna_Vinay'
    DB_HOST = os.environ.get('DB_HOST') or 'localhost'
    DB_USER = os.environ.get('DB_USER') or 'root'
    DB_PASSWORD = os.environ.get('DB_PASSWORD') or '07062002'
    DB_NAME = os.environ.get('DB_NAME') or 'ssresins'
    MAIL_SERVER = os.environ.get('MAIL_SERVER') or 'smtp.gmail.com'
    MAIL_PORT = int(os.environ.get('MAIL_PORT', 587))
    MAIL_USE_TLS = bool(os.environ.get('MAIL_USE_TLS', True))
    MAIL_USE_SSL = bool(os.environ.get('MAIL_USE_SSL', False))
    MAIL_USERNAME = os.environ.get('MAIL_USERNAME') or 'ssresindreamhouse@gmail.com'
    MAIL_PASSWORD = os.environ.get('MAIL_PASSWORD') or 'hafralvhoqigkgsd'
    MAIL_DEFAULT_SENDER = ('SSRESINS', 'ssresindreamhouse@gmail.com')
    MAIL_ASCII_ATTACHMENTS = False  # Ensure attachments are not ASCII encoded




