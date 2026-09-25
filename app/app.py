from flask import Flask
import os

app = Flask(__name__)

@app.route("/")
def hello():
    return {"message": "hello", "user": os.getuid() if hasattr(os, 'getuid') else "n/a"}

@app.route("/healthz")
def health():
    return {"status": "ok"}

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
