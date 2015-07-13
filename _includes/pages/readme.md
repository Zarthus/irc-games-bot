IRC Games bot
=============

[![Build Status](https://travis-ci.org/Zarthus/irc-games-bot.svg)](https://travis-ci.org/Zarthus/irc-games-bot)
[![Security](https://hakiri.io/github/Zarthus/irc-games-bot/master.svg)](https://hakiri.io/github/Zarthus/irc-games-bot/master)

GamesBot is a modular IRC bot written on the Cinch IRC framework. GamesBot strives to host a large variety of enjoyable
irc games together with your friends. It offers many helper functions to easily design new games, and is easily set up and installed.

## Installation

To install you must first install the appropriate gems.

The easiest way to do this is by running `bundle install` from the root of the directory.

Once the command has completed, copy `conf/config.example.yaml` to `conf/config.yaml` and start editing the file with your favourite text editor.
Most of the options will be straightforward if you have experience with IRC. If an option confuses you, refer to [the docs](docs/configuration.md).

## Running tests

Once installed and configured, execute `bundle exec rspec` to run the tests

## Environments

Different configuration files can be loaded by executing the file and passing the `env` argument.

For example:
```
./bot.rb --env dev
```

Would attempt to load `conf/config.dev.yaml` rather than `conf/config.yaml`

Make additional copies of your configuration if you plan to use different environments.

## Running the bot

That's all that is necessary to set up the bot. You can now run it using `./bot.rb` or `ruby bot.rb`.

## Documentation

Please refer to [the documentation](docs) for more elaboration on certain functions.

If you need extra support, see [docs/support](docs/support.md).

## License

The bot is licensed under the MIT license. Refer to the [LICENSE](LICENSE)