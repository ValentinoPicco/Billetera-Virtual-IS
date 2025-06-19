require "sinatra/activerecord/rake"

namespace :db do
  task :load_config do
    require "./server"
  end
end

require 'rake'

desc "Reinicia la base de test y corre los tests"
task :test => [:reset_test_db, :migrate_test_db, :run_rspec]

task :reset_test_db do
  if File.exist?('db/test.sqlite3')
    puts "Eliminando db/test.sqlite3..."
    File.delete('db/test.sqlite3')
  else
    puts "db/test.sqlite3 no existe, nada que eliminar."
  end
end

task :migrate_test_db do
  puts "Ejecutando migraciones en entorno test..."
  system("RACK_ENV=test bundle exec rake db:create db:migrate")
end

task :run_rspec do
  puts "Corriendo tests RSpec..."
  system("bundle exec rspec")
end
