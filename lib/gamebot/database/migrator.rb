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

            return { message: 'Successfully migrated down.', code: 1 }
          else
            Sequel::Migrator.run(db, File.join(__dir__, 'migrations'))

            return { message: 'Successfully migrated up.', code: 0 }
          end
        end
        { message: 'Nothing to execute.', code: 0 }
      end
    end
  end
end
