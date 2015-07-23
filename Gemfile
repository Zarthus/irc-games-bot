source 'https://rubygems.org'

gem 'cinch'
gem 'gist'
gem 'googl'
gem 'sequel'
gem 'rake'

group :test do
  gem 'rspec'
  gem 'rubocop'
end

group :db do
  platforms :ruby do
    gem 'sqlite3'
    gem 'pg'
    gem 'mysql'
    gem 'mysql2'
  end

  platforms :jruby do
    gem 'jdbc-sqlite3'
    gem 'jdbc-mysql'
    gem 'jdbc-postgres'
  end
end
