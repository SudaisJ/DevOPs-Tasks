# Week 9: Centralized Logging with ELK Stack

##  Overview
In this task, I deployed the industry-standard **ELK Stack** (Elasticsearch, Logstash, Kibana) using Docker Compose. The goal was to create a centralized logging system where applications can send logs over the network, and I can visualize them in real-time.

##  Tech Stack
* **Elasticsearch:** The distributed search engine (Database) that stores the logs.
* **Logstash:** The server-side data processing pipeline that ingests data from TCP port 5000.
* **Kibana:** The web interface for visualizing and searching the logs.
* **Netcat (nc):** Used to simulate application logs sending data to the stack.

##  Configuration
* **`docker-compose.yml`**: Orchestrates the 3 containers.
* **`logstash.conf`**: Configures the pipeline to:
    * **Input:** Listen on TCP port 5000 (JSON format).
    * **Output:** Forward processed logs to Elasticsearch:9200.

##  How to Run
1. **Start the Stack:**
   ```bash
   docker compose up -d

## 2. Send a Test Log:
echo '{"message": "Hello from the app!", "status": "OK"}' | nc localhost 5000

## 3. View in Kibana:

    Open http://localhost:5601

    Go to Stack Management > Index Patterns to define app-logs-*.

    Go to Discover to see the logs appear in real-time.
