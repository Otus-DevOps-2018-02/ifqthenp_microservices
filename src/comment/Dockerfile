FROM ruby:2.2

WORKDIR /app
COPY Gemfile* /app/
RUN apt-get update -qq && apt-get install -y --no-install-recommends build-essential \
    && bundle install
COPY . /app

ENV COMMENT_DATABASE_HOST comment_db
ENV COMMENT_DATABASE comments

CMD ["puma"]
