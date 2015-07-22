require 'yaml'

root_path = __dir__
app_path = File.join(root_path, 'lib', 'gamebot')
migration_path = File.join(app_path, 'database', 'migrations')
conf_path = File.join(root_path, 'conf')
storage_path = File.join(root_path, 'storage')

conf = YAML.load_file(File.join(conf_path, 'config.yaml')) # TODO: Account for --env <env> in ./bot.rb
if conf['database']['database'] == '__storage__'
  conf['database']['database'] = File.join(storage_path, 'db', 'gamesbot.db')
end

namespace :db do
  require 'sequel'
  Sequel.extension :migration

  db = Sequel.connect(conf['database'])

  desc 'Test if the database connection is responsive.'
  task :test do
    puts 'Database connection: ' + (db.test_connection ? 'All appears functional.' : 'Connection errored.')
  end

  desc 'Run migrations'
  task :migrate, [:version] do |_t, args|
    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(db, migration_path, target: args[:version].to_i)
    else
      puts 'Migrating to latest'
      Sequel::Migrator.run(db, migration_path)
    end
  end

  task :rollback do
    puts 'Rolling back migrations'
    Sequel::Migrator.run(db, migration_path, target: 0)
  end

  namespace :make do
    desc 'Generate a timestamped, empty Sequel migration.'
    task :migration, :name do |_, args|
      if args[:name].nil?
        puts 'You must specify a migration name (e.g. rake db:make:migration[create_events])!'
        exit false
      end

      content = <<-content
Sequel.migration do
  up do
    # TODO auto-generated migration
  end

  down do
    # TODO auto-generated migration
  end
end
content

      timestamp = Time.now.to_i
      filename = File.join(migration_path, "#{timestamp}_#{args[:name]}.rb")

      File.open(filename, 'w') do |f|
        f.puts content
      end

      puts "Created the migration #{filename}"
    end
  end
end
