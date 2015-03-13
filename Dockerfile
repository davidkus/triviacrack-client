FROM ruby:2.2.1

WORKDIR /code

ADD . /code

RUN bundle install

ENTRYPOINT ["bundle", "exec"]

CMD bin/trivia-crack bot -e $EMAIL -p $PASSWORD
