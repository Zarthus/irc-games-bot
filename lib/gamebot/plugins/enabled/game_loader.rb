module GameBot
  module Plugin
    class GameLoader
      include Cinch::Plugin

      match /^start ([^ ]+)? (.+)?/
      def execute(m, name, params)
        unless m.

        unless name
          m.reply
        end
      end

      def is_game_channel(chan)
        @bot.game_channel.find(chan.downcase)
      end
    end
  end
end