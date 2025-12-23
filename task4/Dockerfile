FROM python:3.9-slim

WORKDIR /app

# Copy dependency definition first (better caching)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the app code
COPY . .

EXPOSE 5000

CMD ["python", "app.py"]
