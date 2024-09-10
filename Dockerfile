# Stage 1: Build stage (used for installing dependencies)
FROM python:3.9-slim as builder

# Set environment variables for non-root user
ENV USER=appuser
ENV UID=1001
ENV GID=1001

# Create non-root user and group
RUN groupadd --gid $GID $USER && \
    useradd --uid $UID --gid $GID --create-home $USER

# Set working directory
WORKDIR /app

# Copy only the dependencies file to avoid cache busting
COPY requirements.txt /app/

# Install dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Stage 2: Final image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy the necessary files from the build stage
COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
COPY . /app

# Change ownership of /app directory
RUN chown -R $USER:$USER /app

# Switch to the non-root user
USER $USER

# Expose port 5000
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]

