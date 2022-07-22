FROM ruby:3.1.2

WORKDIR /code

ADD . /code

RUN gem install bundler

RUN bundle install

CMD bundle exec bin/trivia-crack bot -e $EMAIL -p $PASSWORD -n -f
