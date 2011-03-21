
  namespace :buspass do
    desc "Creates the MySQL Database and user on the local host"
    task :createdb do
       require "tempfile"
       cmd = "mysql --no-defaults --force -u root -p mysql "
       dcmd = "create database buspass_#{RAILS_ENV};\n"
       ucmd = "create user 'buspass'@'localhost' identified by 'buspass';\n"
       gcmd = "grant all on buspass_#{RAILS_ENV}.* to 'buspass'@'localhost';\n"
       tmpfile = Tempfile.new('db-buspass')
       tmpfile.write(dcmd)
       tmpfile.write(ucmd)
       tmpfile.write(gcmd)
       tmpfile.close
       puts "Create on localhost the database 'buspass_#{RAILS_ENV}'"
       puts " user 'buspass', and grant permissons"
       puts " Errors usually means this has been done before."
       puts "May have to enter password for MySQL user 'root'"
       exec "#{cmd} < #{tmpfile.path}"
       tmpfile.unlink
    end

    desc "Seeds the Database"
    task :seed => "db:seed" do
       # reads db/seeds.rb. Should be idempotent
    end

    desc "Clears the Database of Persistent Route Data"
    task :clear do
      require "service_table"
      ServiceTable.clear
    end

    desc "Loads Route Definitions in #{RAILS_ROOT}/db/routes/*/Route_*"
    task :rebuild => :seed do
      require "service_table"
      Dir.foreach("#{RAILS_ROOT}/db/routes") do |dir|
        if (dir =~ /^Route_.*/)
          puts "Rebuilding #{dir}"
          ServiceTable.rebuildRoutes(dir)
        end
      end
    end
  end
