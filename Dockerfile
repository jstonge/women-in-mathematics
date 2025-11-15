# Dockerfile
FROM python:3.11-slim

# Install system dependencies if needed
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /pipeline

# Copy the entire project
COPY . .

# Install uv (fast Python package manager - since they're using uv.lock)
RUN pip install uv

# Install project dependencies from pyproject.toml
RUN uv sync

# Set environment variables for Dagster
ENV DAGSTER_HOME=/pipeline/.dagster

# The entrypoint runs their Dagster pipeline
# This executes all assets in dependency order
ENTRYPOINT ["uv", "run", "dagster", "asset", "materialize", "--select", "*"]
