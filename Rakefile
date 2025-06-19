require "sinatra/activerecord/rake"

namespace :db do
  task :load_config do
    require "./server"
  end
end


desc "Reinicia la base de test y corre los tests"
task :test => [:restore_test_db, :migrate_test_db, :run_rspec]

task :restore_test_db do
  puts "Restaurando db/test.sqlite3 desde git..."
  system("git restore db/test.sqlite3")
end

task :migrate_test_db do
  puts "Ejecutando migraciones en entorno test..."
  system("RACK_ENV=test bundle exec rake db:migrate")
end

task :run_rspec do
  puts "Corriendo tests RSpec..."
  system("bundle exec rspec spec/models/transaction_spec.rb")
end
