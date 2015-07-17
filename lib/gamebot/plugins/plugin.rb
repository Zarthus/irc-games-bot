module Cinch
  module Plugin
    def is_game_channel(chan)
      @bot.config.games.find(chan.downcase)
    end
  end
end
