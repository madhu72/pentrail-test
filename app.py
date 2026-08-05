import hashlib
import os
import sqlite3
import subprocess

from flask import Flask, request

import config

app = Flask(__name__)


@app.route("/user")
def get_user():
    # SQL injection: request data concatenated into the query.
    user_id = request.args.get("id")
    conn = sqlite3.connect("app.db")
    cur = conn.cursor()
    cur.execute("SELECT * FROM users WHERE id = '" + user_id + "'")
    return str(cur.fetchall())


@app.route("/ping")
def ping():
    # Command injection: user input reaches the shell.
    host = request.args.get("host")
    return subprocess.check_output("ping -c 1 " + host, shell=True)


@app.route("/hash")
def hash_password():
    # Weak hashing for credentials.
    pw = request.args.get("pw", "")
    return hashlib.md5(pw.encode()).hexdigest()


@app.route("/calc")
def calc():
    # Arbitrary code execution.
    return str(eval(request.args.get("expr", "0")))


if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=config.DEBUG)
