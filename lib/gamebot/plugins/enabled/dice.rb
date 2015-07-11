require 'cinch'

module BotPlugin
  class Dice
    include Cinch::Plugin

    # [<rolls>]d<sides>[<+/-><offset>]
    match(/(?:roll|dice) (?:(\d+))?d(\d+)(?:([+-])(\d+))?/)
    def execute(m, rolls, sides, offset_op, offset)
      rolls   = rolls.to_i
      rolls   = 1 if (rolls < 1 || rolls > 100)

      results = []
      total = 0

      rolls.times do
        result = rand(sides.to_i) + 1

        if results.length <= 10
          if results.length < 10
            results << result
          else
            results << '...'
          end
        end

        total += result
      end

      if offset_op
        total = total.send(offset_op, offset.to_i)
      end

      clean_results = results.join(', ')
      res = "You rolled a #{sides} sided die #{rolls} time" + (rolls == 1 ? '' : 's') + " with the result of #{total} (#{clean_results})"
      m.reply res, true
    end
  end
end