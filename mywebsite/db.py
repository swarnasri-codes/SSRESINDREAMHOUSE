import mysql.connector

# Database connection setup
def get_db_connection():
    return mysql.connector.connect(
        host='localhost',
        user='root',
        password='07062002',
        database='SSRESINS'    
    )
