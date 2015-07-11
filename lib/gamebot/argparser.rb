require 'optparse'

class ArgParser
  def self.parse(args)
    options = {}
    opt_parser = OptionParser.new do |opts|
      opts.banner = 'Usage: bot.rb [options]'

      opts.on('--env=ENV', 'Specify the environment to load.') do |env|
        if env == 'example'
          raise SecurityError "The environment '#{env}' may not be used."
        end

        options[:env] = env
      end

      opts.on_tail('-h', '--help', 'Show this help message') do
        puts opts
        exit
      end

      opts.on_tail('--version', 'Show version') do
        puts 'GameBot version ' + GameBot::VERSION + ' using Cinch version ' + Cinch::VERSION
        puts 'Ruby version: ' + RUBY_VERSION
        exit
      end
    end

    opt_parser.parse!(args)
    options
  end
end