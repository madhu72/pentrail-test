FROM python:3.9

WORKDIR /app
COPY . /app
RUN pip install -r requirements.txt

# Runs as root, no healthcheck, secret baked into the image env.
ENV API_TOKEN="b7f3d9a1c4e28650fa1d3b7c9e05482da6f1c3b8"
EXPOSE 5000
CMD ["python", "app.py"]
