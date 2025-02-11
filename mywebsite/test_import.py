# test_import.py
try:
    from config import Config
    print("config.py imported successfully!")
except ModuleNotFoundError as e:
    print(f"Error: {e}")
