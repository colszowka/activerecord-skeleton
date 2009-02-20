task :environment do
  require 'init'
end

desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"
task :migrate => :environment do
  ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
end

namespace :generate do
  desc "Generate a migration with given name. Specify migration name with NAME=my_migration_name"
  task :migration => :environment do
    raise "Please specify desired migration name with NAME=my_migration_name" unless ENV['NAME']
    
    # Find migration name from env
    migration_name = ENV['NAME'].strip.chomp
    
    # Define migrations path (needed later)
    migrations_path = File.join(File.dirname(__FILE__), 'db', 'migrate')
    
    # Find the highest existing migration version or set to 1
    if (existing_migrations = Dir[File.join(migrations_path, '*.rb')]).length > 0
      version = File.basename(existing_migrations.sort.reverse.first)[/^(\d+)_/,1].to_i + 1
    else
      version = 1
    end
    
    # Read the contents of the migration template into string
    migrations_template = File.read(File.join(migrations_path, 'migration.template') )
    
    # Replace the migration name in template with the acutal one
    migration_content = migrations_template.gsub('__migration_name__', migration_name.camelize)
    
    # Generate migration filename
    migration_filename = "#{"%03d" % version}_#{migration_name}.rb"
    
    # Write the migration
    File.open(File.join(migrations_path, migration_filename), "w+") do |migration|
      migration.puts migration_content
    end
    
    # Done!
    puts "Successfully created migration #{migration_filename}"
  end
end
