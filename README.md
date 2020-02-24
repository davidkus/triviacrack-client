# TriviaCrack Client ![CI](https://github.com/davidkus/triviacrack-client/workflows/CI/badge.svg) [![Code Climate](https://codeclimate.com/github/davidkus/triviacrack-client/badges/gpa.svg)](https://codeclimate.com/github/davidkus/triviacrack-client) [![Test Coverage](https://codeclimate.com/github/davidkus/triviacrack-client/badges/coverage.svg)](https://codeclimate.com/github/davidkus/triviacrack-client)

A bot that plays the popular social game Trivia Crack. Running the bot will go
through all games which are currently on your turn and play them to completion.

## Installation

Using docker-compose:

```
$ docker-compose build
$ docker-compose run triviacrack
```

To build using docker:

```
$ docker build -t image-name .
```

## Usage

### Bot

To run the bot, execute:

```
$ bin/trivia-crack bot -e email -p password
```

- email is the e-mail you use to sign in to Trivia Crack (e.g. user@example.com).
- password is your Trivia Crack account password.

To deploy with docker:

```
$ docker run -d -e EMAIL=email -e PASSWORD=password image-name
```

### Manual Play

Included is a CLI client that lets you manually input the answers to questions.
To run this client, execute:

```
$ bin/trivia-crack play -e email -p password
```

Note: Currently, images are not display (for questions which include images).


## Contributing

1. Fork it ( https://github.com/davidkus/triviacrack-client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
