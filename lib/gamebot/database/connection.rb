module GameBot
  module Database
    def self.connect(conf, storage)
      @db = Sequel.connect(conf)
      @db.loggers << Logger.new(storage) if storage

      Migrator.execute(@db) if Migrator.scheduled
    end

    def self.disconnect
      @db.disconnect
    end
  end
end
