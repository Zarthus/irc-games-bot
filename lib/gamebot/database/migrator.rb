module GameBot
  module Database
    class Migrator
      def self.schedule(arg)
        Sequel.extension :migration
        @schedule = arg
      end

      def self.scheduled
        @schedule
      end

      def self.execute(db)
        if @schedule
          if @schedule == :down
            Sequel::Migrator.run(db, File.join(__dir__, 'migrations'), target: 0)
            info 'Successfully migrated down.'
            exit
          else
            Sequel::Migrator.run(db, File.join(__dir__, 'migrations'))
            info 'Successfully migrated up.'
          end
        end
      end
    end
  end
end
