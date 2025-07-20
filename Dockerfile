FROM python:3.10-slim

WORKDIR /app

COPY app/ ./app/
COPY prompts/ ./prompts/

RUN pip install flask requests

EXPOSE 5000

CMD ["python", "app/main.py"]
