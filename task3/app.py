from flask import Flask
from redis import Redis

app = Flask(__name__)
# Connect to the Redis container named 'redis'
redis = Redis(host='redis', port=6379)

@app.route('/')
def hello():
    count = redis.incr('hits')
    return f"Hello! You have viewed this page {count} times."

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
