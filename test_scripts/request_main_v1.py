"""
Send a request to flask application
"""
import requests

url = "https://prod-flask-app-cloud-run-service-jrek4srhha-ew.a.run.app"

# Method 1
resp = requests.get(f"{url}/hello", verify=False)
print(resp.content.decode())

# Method 2
resp = requests.get(f"{url}/hello/Foo bar", verify=False)
print(resp.content.decode())

# Method 3
resp = requests.post(f"{url}/hello_body", json={"my_name": "Foo bar"}, verify=False)
print(resp.content.decode())
