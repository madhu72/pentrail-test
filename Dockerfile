FROM python:3.9

WORKDIR /app
COPY . /app
RUN pip install -r requirements.txt

# v1.1: secret no longer baked into the image. Still runs as root.
EXPOSE 5000
CMD ["python", "app.py"]
