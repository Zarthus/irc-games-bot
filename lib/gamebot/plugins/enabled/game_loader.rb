module GameBot
  module Plugin
    class GameLoader
      include Cinch::Plugin

      def intialize
        super
        @manager = Game::Manager.new
      end

      match Regexp.new('start(?: ([^ ]+)?)(?: (.+))?'), method: :cmd_start

      def cmd_start(m, name, params)
        cmd_game m, 'start', name, params
      end

      match Regexp.new('stop$'), method: :cmd_stop

      def cmd_stop(m)
        cmd_game m, 'stop', '', ''
      end

      match Regexp.new('game(?: ([^ ]+)?(?: ([^ ]+)?)(?: (.+))?)?'), method: :cmd_game

      def cmd_game(m, keyword, name, params)
        return false unless game_channel?(m.channel.to_s.downcase)

        unless name
          return m.reply 'Usage: GAME <keyword: start, stop> <gamename> [options ..]'
        end

        options = nil
        if params
          result = parse_params(m, params)
          return true if result[1]  # Do not continue if we have sent a message

          options = result[0]
        end

        case keyword.downcase
          when 'start'
            game_start m, name, options
          when 'stop'
            game_stop m
          else
            m.reply 'Usage: GAME <keyword: start, end> <gamename> [options ..]'
        end
      end

      def game_start(m, name, _options)
        @game = name
        m.reply "A game of #{name} has been started by #{m.user}!"
      end

      def started
        @game
      end

      def game_stop(m)
        m.reply "A game of #{@game} has been stopped by #{m.user}!"
        @game = nil
      end

      def parse_params(m, params)
        options = Game::GameOptionParser.parse(params.split)

        if options[:message]
          display_errors(m, options[:errors]) if options[:errors].count != 0

          if options[:gist]
            gist = options[:gist].to_s.to_gist
            m.reply options[:message] + gist
            return [options, true]
          end

          m.reply options[:message]
          return [options, true]
        end

        [options, false]
      end

      def display_errors(m, errors)
        if errors
          if errors.count > 2
            message = 'The following errors occurred while parsing parameters: ' + "\n\n"

            errors.each do |err|
              message += "- #{err}\n"
            end

            m.reply 'Several errors have occured while parsing the parameters: ' + message.to_gist
          else
            errors.each do |err|
              m.reply '[warning] ' + err
            end
          end
        end
      end
    end
  end
end
