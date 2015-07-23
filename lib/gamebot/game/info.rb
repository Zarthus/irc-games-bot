require 'gamebot/game/status'

module GameBot
  module Game
    class Info
      using StringRefinement

      @channel = nil
      @players = nil
      @status = Status::NONE

      def initialize(channel)
        @channel = channel
        @players = Players.new(channel)
      end

      def self.list
        game_path_all = Dir.glob(File.join('lib', 'gamebot', 'game', 'games', '*.rb'))

        game_all = []
        game_path_all.each do |path|
          game_all << File.basename(path).split('.')[0]
        end

        gamehash = {}
        game_all.each do |game|
          gamename = game.camelize

          nm = eval("Game::#{gamename}::NAME")
          desc = eval("Game::#{gamename}::DESCRIPTION")
          gamehash[game] = { name: nm, description: desc }
        end

        puts gamehash.to_s
        gamehash
      end
    end
  end
end
