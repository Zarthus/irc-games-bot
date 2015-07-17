module Cinch
  module Plugin
    def game_channel(chan)
      @bot.config.games.find(chan.downcase)
    end
  end
end
