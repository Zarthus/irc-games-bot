module GameBot
  module Plugin
    class GameLoader
      include Cinch::Plugin

      match /game ([^ ]+)?(?: ([^ ]+)?(?: (.+)))?/

      def execute(m, keyword, name, params)
        unless is_game_channel(m.channel.to_s.downcase)
          return false
        end

        unless name
          return m.reply 'Usage: GAME <keyword: start, end> <gamename> [options ..]'
        end

        options = nil
        if params
          # TODO
        end

        case keyword.downcase
          when 'start'
            game_start m name options
          when 'end'
            game_end m
          else
            m.reply 'Usage: GAME <keyword: start, end> <gamename> [options ..]'
        end
      end
    end

    def game_start(m, name, options)
      @game = name
      m.reply "A game of #{name} has been started by #{m.user}!"
    end

    def started
      @game
    end

    def game_end(m)
      m.reply "A game of #{@game} has been stopped by #{m.user}!"
      @game = nil
    end
  end
end

