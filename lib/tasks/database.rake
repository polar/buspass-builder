
  namespace :buspass do

    desc "Creates the MySQL Database and user on the local host"
    task :createdb => :environment do
       require "tempfile"
       config = ActiveRecord::Base.configurations[RAILS_ENV]
       host = config["socket"].split(":").first
       cmd = "mysql --no-defaults --force -u root -p mysql -h #{host} "
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

    desc "Loads Route Definitions in #{RAILS_ROOT}/db/routes/*/Route_*Uris View Path"
    task :rebuild => [ :environment, :seed ] do
      require "service_table"
      routesdir = "#{RAILS_ROOT}/db/routes"
      ::Dir.foreach(routesdir) do |dir|
        if (dir =~ /^Network_.*/)
          path = ::File.expand_path(dir, routesdir);
          puts "Rebuilding #{dir}"
          ServiceTable.rebuildRoutes(path)
        end
      end
    end

    desc "Dumps GoogleUriViewPaths into a CSV File in #{RAILS_ROOT}/db/google_view_paths-write.csv"
    task :dump_uris => :environment do
      GoogleUriViewPath.write("#{RAILS_ROOT}/db/google_view_paths-write.csv")
    end

    desc "Clears GoogleUriViewPaths"
    task :clear_uris => :environment do
      GoogleUriViewPath.delete_all
    end

    desc "Loads GoogleUriViewPaths from a CSV File in #{RAILS_ROOT}/db/google_view_paths.csv"
    task :load_uris => :environment do
      GoogleUriViewPath.read("#{RAILS_ROOT}/db/google_view_paths.csv")
    end

  end
