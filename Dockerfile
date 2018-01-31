FROM ruby:2.4.1

WORKDIR /code

ADD . /code

RUN bundle install

CMD bundle exec bin/trivia-crack bot -e $EMAIL -p $PASSWORD -n -f
