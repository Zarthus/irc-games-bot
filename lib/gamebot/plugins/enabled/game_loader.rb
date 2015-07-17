module GameBot
  module Plugin
    class GameLoader
      include Cinch::Plugin

      def intialize
        super
        @manager = Manager.new
      end

      match '/start ([^ ]+)?(?: (.+))?/', method: :cmd_start
      def cmd_start(m, name, params)
        cmd_game m, 'start', name, params
      end

      match '/stop$/', method: :cmd_stop
      def cmd_stop(m)
        cmd_game m, 'stop', '', ''
      end

      match '/game ([^ ]+)?(?: ([^ ]+)?(?: (.+)))?/', method: :cmd_game
      def cmd_game(m, keyword, name, params)
        return false unless game_channel?(m.channel.to_s.downcase)

        unless name
          return m.reply 'Usage: GAME <keyword: start, stop> <gamename> [options ..]'
        end

        options = nil
        if params
          # TODO
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
  end
end
