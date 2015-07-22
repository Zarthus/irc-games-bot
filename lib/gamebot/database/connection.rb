module GameBot
  module Database
    def self.connect(conf, storage)
      @db = Sequel.connect(conf)
      @db.loggers << Logger.new(storage) if storage

      if Migrator.scheduled
        status = Migrator.execute(@db)
        @db.log_info status[:message]
        exit if status[:code] == 1
      end
    end

    def self.disconnect
      @db.disconnect
    end
  end
end
