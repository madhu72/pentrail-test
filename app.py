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
    cur.execute("SELECT * FROM users WHERE id = ?", (user_id,))
    return str(cur.fetchall())


@app.route("/ping")
def ping():
    # Command injection: user input reaches the shell.
    host = request.args.get("host")
    if not host or not host.replace(".", "").replace("-", "").isalnum():
        return "invalid host", 400
    return subprocess.check_output(["ping", "-c", "1", host])


@app.route("/hash")
def hash_password():
    # v1.3: PBKDF2 with a per-call salt instead of bare MD5.
    pw = request.args.get("pw", "")
    salt = os.urandom(16)
    return hashlib.pbkdf2_hmac("sha256", pw.encode(), salt, 200_000).hex()


@app.route("/calc")
def calc():
    # v1.3: literal evaluation only — no arbitrary code execution.
    import ast

    try:
        return str(ast.literal_eval(request.args.get("expr", "0")))
    except (ValueError, SyntaxError):
        return "invalid expression", 400


if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=config.DEBUG)
