FROM ubuntu:16.04

WORKDIR /app
COPY Gemfile* /app/
RUN apt-get update -qq \
    && apt-get install -y --no-install-recommends ruby-full ruby-dev build-essential \
    && gem install bundler --no-ri --no-rdoc \
    && bundle install
COPY . /app

ENV POST_SERVICE_HOST post
ENV POST_SERVICE_PORT 5000
ENV COMMENT_SERVICE_HOST comment
ENV COMMENT_SERVICE_PORT 9292

CMD ["puma"]
