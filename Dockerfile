FROM python:3.8.2-alpine
WORKDIR /app
COPY ./app /app
RUN pip install -r requirements.txt
EXPOSE 5000
CMD["Python","app.py"]
