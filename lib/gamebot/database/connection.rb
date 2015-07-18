require 'sequel'
require 'logger'

module GameBot
  module Database
    def self.connect(conf, storage)
      @db = Sequel.connect(conf)

      if storage
        @db.loggers << Logger.new(storage)
      end

    end

    def self.disconnect
      @db.disconnect
    end
  end
end
