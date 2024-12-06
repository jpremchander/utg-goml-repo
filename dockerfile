# Use a specific Python slim image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /mainapp

# Pre-install system packages and clean up afterward
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       gcc \
       libpq-dev \
       build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements.txt to leverage Docker's caching
COPY requirements.txt .

# Preinstall dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the remaining application code into the container
COPY . .

# Expose the port for the FastAPI app
EXPOSE 9000

# Command to run the FastAPI app using Uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "9000", "--reload"]
