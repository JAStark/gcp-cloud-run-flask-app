"""
A sample flask application on Cloud Run. From How to Deploy a Flask App on Cloud Run with Cloud Endpoints
`https://medium.com/fullstackai/how-to-deploy-a-simple-flask-app-on-cloud-run-with-cloud-endpoint-e10088170eb7`
"""

from flask import Flask
from flask_cors import CORS
from flask_sslify import SSLify

from webargs import fields
from webargs.flaskparser import use_args

# initialise the flask app
app = Flask(__name__)
CORS(app, supports_credentials=True)
sslify = SSLify(app)


@app.route("/hello", methods=["GET"])
def hello():
    """Method 1: Return a simple hello"""
    return "Hello, you!", 200


@app.route("/hello/<my_name>", methods=["GET"])
def hello_name(my_name):
    """Method 2: Return hello with name, given in url"""
    return f"Hello from url, {my_name}", 200


@app.route("/hello_body", methods=["POST"])
@use_args(argmap={"my_name": fields.Str(required=True)})
def hello_from_body(args):
    """Methods 3: Return hello with name, given in body"""
    my_name = args.get("my_name", "")
    return f"Hello from body, {my_name}", 200


@app.route("/")
def top_page():
    """top_page"""
    return "Welcome to my app, version 1"


if __name__ == "__main__":
    app.run(ssl_context="adhoc", host="0.0.0.0", port=5000)
