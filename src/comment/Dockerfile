FROM alpine:latest

WORKDIR /app
COPY Gemfile* /app/

RUN \
    apk update \
    && apk upgrade \
    && apk add --no-cache --virtual build-dependencies ruby-dev build-base \
    && apk add --no-cache ruby ruby-bundler \
    && bundle config --global silence_root_warning 1 \
    && bundle install \
    && apk del build-dependencies

COPY . /app

ENV COMMENT_DATABASE_HOST comment_db
ENV COMMENT_DATABASE comments

CMD ["puma"]
