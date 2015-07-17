module GameBot
  module Game
    class Replay
      def initialize(timestamp_format = false)
        @timestamp_format = timestamp_format ? timestamp_format : '%F %T%z'
        @timeline = []
      end

      def track(action, tag = :PLAYER_ACTION)
        @timeline << { timestamp => [action, tag] }
      end

      def store(tag = :STORE_LOG) # TODO: Get extension to store in and place in storage folder/replay folder.
        file = File.open(path, 'w+')
        file.write(parse tag)
        file.close
      end

      def count
        @timeline.count
      end

      def to_s(tag = :STORE_LOG)
        parse tag
      end

      def parse(save_as = :STORE_LOG)
        fmt = format save_as
        return '' unless fmt

        messages = ''

        @timeline.each do |event|
          event.each do |ts, data|
            action = data[0]
            tag = data[1]

            messages += fmt % { ts: ts, action: action.gsub(/(["'])/, '\\\1'), tag: tag }
          end
        end

        messages
      end

      def format(tag)
        case tag
          when :STORE_LOG
            "%{ts} [%{tag}]: %{action}\n"
          when :STORE_CSV
            "%{ts},%{tag},%{action}\n"
          else
            error "Unknown tag #{tag} for replay formatting."
            false
        end
      end

      def timestamp
        DateTime.now.strftime(@timestamp_format)
      end
    end
  end
end
