FROM ruby:2.6.5

WORKDIR /code

ADD . /code

RUN bundle install

CMD bundle exec bin/trivia-crack bot -e $EMAIL -p $PASSWORD -n -f
