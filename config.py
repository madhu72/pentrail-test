# v1.1: credentials now come from the environment, not the source tree.
import os

DB_PASSWORD = os.environ.get("DB_PASSWORD")
API_TOKEN = os.environ.get("API_TOKEN")
SESSION_SECRET = os.environ.get("SESSION_SECRET")
DEBUG = True
