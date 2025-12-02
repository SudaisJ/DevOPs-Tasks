from flask import Flask
import os

app = Flask(__name__)

@app.route('/')
def hello():
    # We can even grab the container ID to prove we are inside Docker
    container_id = os.environ.get('HOSTNAME', 'localhost')
    return f"""
    <div style="text-align: center; margin-top: 50px; font-family: sans-serif;">
        <h1>🐳 Hello World!</h1>
        <p>This app is running inside a Docker container.</p>
        <p>Container ID: <strong>{container_id}</strong></p>
    </div>
    """

if __name__ == '__main__':
    # host='0.0.0.0' is CRITICAL for Docker
    # It allows the container to accept connections from outside itself
    app.run(host='0.0.0.0', port=5000)
