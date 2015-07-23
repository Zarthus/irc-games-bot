module GameBot
  module Game
    class GameOptionParser
      def self.parse(args)
        options = {}
        opt_parser = OptionParser.new do |opts|
          opts.banner = 'Some parameters rely on the game to parse them.' + "\n" \
            'Refer to the game documentation for a list of supported options.' + "\n\n"

          opts.on('-w', '--wait', 'Duration to wait for players to join. Supported: short, medium, long') do |dur|
            options[:wait] = dur if [:long, :medium, :short].find(dur)
          end

          opts.on('-d', '--duration', 'Specify game length. Supported: short, medium, long') do |dur|
            options[:duration] = dur if [:long, :medium, :short].find(dur)
          end

          opts.on('-r', '--roles', 'Comma separated list of roles.') do |roles|
            r = roles.split(',')

            options[:roles] = r
          end

          opts.on_tail('-h', '--help', 'Respond to the command with this message.') do
            options[:help] = opts
          end
        end

        opt_parser.parse!(args)
        options
      end
    end
  end
end
