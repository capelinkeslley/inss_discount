FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y postgresql-client shared-mime-info dos2unix

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

ARG USER
ARG UID

WORKDIR /usr/app

COPY Gemfile /api/Gemfile
COPY Gemfile.lock /api/Gemfile.lock

COPY . .

COPY entrypoint.sh /usr/bin
ENTRYPOINT ["entrypoint.sh"]

USER "$USER"

CMD ["rails", "server", "-b", "0.0.0.0"]
