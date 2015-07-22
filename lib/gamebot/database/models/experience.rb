module GameBot
  module Database
    class Experience
      def initialize
        @table = @db[:experience]
      end

      def level(user_id, game_id)
        calclevel(@table.where(user_id: user_id, game_id: game_id).first)
      end

      def calclevel(exp)
        Math.floor(exp / 100)
      end
    end
  end
end
