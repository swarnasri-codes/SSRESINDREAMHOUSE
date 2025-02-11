import mysql.connector
from mysql.connector import Error

def get_db_connection(config):
    try:
        connection = mysql.connector.connect(
            host=config['DB_HOST'],
            user=config['DB_USER'],
            password=config['DB_PASSWORD'],
            database=config['DB_NAME']
        )
        print('DB Connection successful')
        return connection
    except Error as e:
        print(f"Error connecting to MySQL: {e}")
        return None
