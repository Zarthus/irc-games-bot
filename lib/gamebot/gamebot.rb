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

            unless File.exist?(yaml_path)
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

          c.modes = config['irc']['umodes'].chars if config['irc']['umodes']

          if config['irc']['nick']
            c.nick = config['irc']['nick']
          elsif config['irc']['nicks']
            c.nicks = config['irc']['nicks']
          else
            c.nick = 'GameBot'
          end

          c.user = config['irc']['username'] || 'gamebot'
          c.realname = config['irc']['realname'] || config['source_url'] || c.user

          c.local_host = config['irc']['bind'] if config['irc']['bind']

          if config['irc']['auth']['cert']['client_cert']
            c.ssl.client_cert = config['irc']['auth']['cert']['client_cert']
          elsif config['irc']['auth']['sasl']['account'] && config['irc']['auth']['sasl']['password']
            c.sasl.username = config['irc']['auth']['sasl']['account']
            c.sasl.password = config['irc']['auth']['sasl']['password']
          end

          c.channels = config['irc']['channels']
          c.games = config['irc']['game_channel'].to_a

          c.plugins.prefix = /^#{Regexp.escape(config['prefix'])}/

          ploader = PluginLoader.new(c.root)
          info 'Loading plugins: ' + ploader.list_rel.to_s
          c.plugins.plugins = ploader.get

          c.source_url = config['source_url'] if config['source_url']

          alt_storage = File.join(Dir.back(c.root, 2), 'storage')
          c.storage = File.join(config['storage_path'] || alt_storage)
          info "Storage path: #{c.storage}"

          c.logging = config['logging']
          c.database = config['database']

          Paste.default config['paste_service'] if config['paste_service']
          ShortUrl.default config['shorten_service'] if config['shorten_service']

          c.api_keys = config['api_keys']
        end
      end
      logging
      database
    end

    def start
      @bot.start
    end

    def storage(path = nil)
      return File.join(@bot.config.storage, path) if path

      @bot.config.storage
    end

    def logging
      if @bot.config.logging
        logfile = storage(File.join('logs', 'irc.log'))
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

    def database
      if @bot.config.database['database'] == '__storage__'
        @bot.config.database['database'] = storage(File.join('db', 'gamesbot.db'))
      end

      db_logs = (@bot.config.logging ? storage(File.join('logs', 'db.log')) : nil)
      Database.connect(@bot.config.database, db_logs)
    end
  end
end
