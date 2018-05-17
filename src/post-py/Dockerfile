FROM alpine:latest

WORKDIR /app
COPY requirements.txt /app

RUN \
    apk update \
    && apk upgrade \
    && apk add --no-cache --virtual build-dependencies python-dev build-base \
    && apk add --no-cache python3 \
    && pip3 install flask pymongo \
    && pip3 install -r requirements.txt \
    && apk del build-dependencies

COPY . /app

ENV POST_DATABASE_HOST post_db
ENV POST_DATABASE posts

CMD [ "python3", "post_app.py" ]
