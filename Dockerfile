# Use the official Python image
FROM python:3.9-slim

# Install system dependencies needed for PostgreSQL and Python
RUN apt-get update && apt-get install -y \
    libpq-dev gcc \
    && apt-get clean

# Set the working directory inside the container
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Copy the Django project files to the container
COPY . /app/

# Expose port 8000 (for the Django development server)
EXPOSE 8000

# Set the default command to run Django migrations and start the server
CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]
