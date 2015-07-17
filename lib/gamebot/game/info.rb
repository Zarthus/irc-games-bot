require 'gamebot/game/status'

module GameBot
  module Game
    class Info
      @channel = nil
      @players = nil
      @status = Status::NONE

      def initialize(channel)
        @channel = channel
        @players = Players.new(channel)
      end
    end
  end
end
