require 'cinch'
require 'yaml'
require 'gamebot/includes'

module GameBot
  class GameBot
    @bot

    def initialize
      configure
    end

    def configure
      @bot = Cinch::Bot.new do
        configure do |c|
          args = Utilities::ArgParser.parse(ARGV)
          yaml_path = './conf/config.'

          if args[:env]
            info 'Detected environment: ' + args[:env]
            yaml_path += args[:env] + '.yaml'

            unless File.exists?(yaml_path)
              raise RuntimeError "Specified configuration file '#{yaml_path}' not found. The environment #{:env} does not exist."
            end
          else
            yaml_path += 'yaml'
          end
          info 'Loading configuration from ' + yaml_path
          config = YAML.load_file(yaml_path)

          c.server = config['irc']['server']
          if config['irc']['server_password']
            c.password = config['irc']['server_password']
          end

          c.port = config['irc']['port'] || 6667
          c.ssl.use = config['irc']['ssl']
          c.ssl.verify = config['irc']['ssl_verify']

          if config['irc']['umodes']
            c.modes = config['irc']['umodes'].chars
          end

          if config['irc']['nick']
            c.nick = config['irc']['nick']
          elsif config['irc']['nicks']
            c.nicks = config['irc']['nicks']
          else
            c.nick = 'GameBot'
          end

          c.user = config['irc']['username'] || 'gamebot'
          c.realname = config['irc']['realname'] || config['source_url'] || c.user

          if config['irc']['bind']
            c.local_host = config['irc']['bind']
          end

          if config['irc']['auth']['cert']['client_cert']
            c.ssl.client_cert = config['irc']['auth']['cert']['client_cert']
          elsif config['irc']['auth']['sasl']['account'] and config['irc']['auth']['sasl']['password']
            c.sasl.username = config['irc']['auth']['sasl']['account']
            c.sasl.password = config['irc']['auth']['sasl']['password']
          end

          c.channels = config['irc']['channels']
          c.games = config['irc']['game_channel']

          c.plugins.prefix = /^#{Regexp.escape(config['prefix'])}/

          ploader = PluginLoader.new(config['app_root'])
          info 'Loading plugins: ' + ploader.list.to_s
          c.plugins.plugins = ploader.get

          if config['source_url']
            c.source_url = config['source_url']
          end
        end
      end
    end

    def start
      @bot.start
    end
  end
end