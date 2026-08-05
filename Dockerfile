FROM python:3.9-slim

WORKDIR /app
COPY . /app
RUN pip install --no-cache-dir -r requirements.txt

# v1.1: secret no longer baked into the image. Still runs as root.
EXPOSE 5000
RUN useradd --create-home --uid 10001 appuser
USER appuser

HEALTHCHECK --interval=30s --timeout=3s CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/hash?pw=x')"

CMD ["python", "app.py"]
