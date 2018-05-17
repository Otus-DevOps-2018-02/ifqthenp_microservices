FROM python:3.6.0-alpine

WORKDIR /app
COPY requirements.txt /app
RUN pip install flask pymongo && pip install -r /app/requirements.txt
COPY . /app

ENV POST_DATABASE_HOST post_db
ENV POST_DATABASE posts

CMD [ "python3", "post_app.py" ]
