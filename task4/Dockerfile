FROM python:3.9-slim

WORKDIR /app

# FIX 1: Update OS packages to fix Low/Medium Linux vulnerabilities
# We also clean up the apt list afterwards to keep the image small
RUN apt-get update && apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

# FIX 2: Upgrade pip to fix the known Python vulnerabilities (CVE-2023-5752)
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

# Best Practice: Don't run as root (Optional but recommended for security)
# We will stick to root for now to keep it simple, but remember this for later!
CMD ["python", "app.py"]
