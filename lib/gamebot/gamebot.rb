require 'cinch'
require 'yaml'
require 'gamebot/includes'

module GameBot
  class GameBot
    def initialize
      configure
    end

    def configure
      @bot = Cinch::Bot.new do
        configure do |c|
          c.root = __dir__

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
          c.games = config['irc']['game_channel'].to_a

          c.plugins.prefix = /^#{Regexp.escape(config['prefix'])}/

          ploader = PluginLoader.new(c.root)
          info 'Loading plugins: ' + ploader.list_rel.to_s
          c.plugins.plugins = ploader.get

          if config['source_url']
            c.source_url = config['source_url']
          end

          alt_storage = File.join(Dir.back(c.root, 2), 'storage')
          c.storage = File.join(config['storage_path'] || alt_storage)
          c.logging = config['logging']

          info "Storage path: #{c.storage}"
        end
      end
      logging
    end

    def start
      @bot.start
    end

    def storage(path = nil)
      if path
        return File.join(@bot.config.storage, path)
      end

      @bot.config.storage
    end

    def logging
      if @bot.config.logging
        logfile = storage(File.join('irc', 'main.log'))
        @bot.loggers << Cinch::Logger::FormattedLogger.new(File.open(logfile, 'w+'))

        case @bot.config.logging
          when 'debug'
            @bot.loggers.level = :debug
          when 'log'
            @bot.loggers.level = :log
          when 'info'
            @bot.loggers.level = :info
          when 'warn'
            @bot.loggers.level = :warn
          when 'error'
            @bot.loggers.level = :error
          when 'fatal'
            @bot.loggers.level = :fatal
          else
            @bot.loggers.level = :debug
        end
      end
    end
  end
end