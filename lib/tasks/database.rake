
  namespace :buspass do

    desc "Seeds the Database"

    task :seed => "db:seed" do
       # reads db/seeds.rb. Should be idempotent
    end

    desc "Clears the Database of Persistent Route Data"
    task :clear => :environment do
      require "service_table"
      ServiceTable.clear
    end

    desc "Loads Route Definitions in #{RAILS_ROOT}/db/routes/*/Route_*Uris View Path"
    task :rebuild_routes => [ :environment, :seed ] do
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

    desc "Loads Route Definitions in #{RAILS_ROOT}/db/routes/*/Route_*Uris View Path"
    task :create_routes => [ :environment, :seed ] do
      require "service_table"
      routesdir = "#{RAILS_ROOT}/db/routes"
      ::Dir.foreach(routesdir) do |dir|
        if (dir =~ /^Network_.*/)
          path = ::File.expand_path(dir, routesdir);
          puts "Rebuilding #{dir}"
          ServiceTable.createRoutes(path)
        end
      end
    end

    desc "Loads Route Definitions in #{RAILS_ROOT}/db/routes/*/Route_*Uris View Path"
    task :fix_routes => [ :environment, :seed ] do
      require "service_table"
      routesdir = "#{RAILS_ROOT}/db/routes"
      ::Dir.foreach(routesdir) do |dir|
        if (dir =~ /^Network_.*/)
          path = ::File.expand_path(dir, routesdir);
          puts "Rebuilding #{dir}"
          ServiceTable.fixRoutes(path)
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

    desc "Builds the API for the local host"
    task :create_api => :environment do
      CONTROLLER_IP = UDPSocket.open {|s| s.connect("64.233.187.99", 1); s.addr.last}
      CONTROLLER_URL = "http://#{CONTROLLER_IP}:3000"
      api = Api.new
      api.major_version = 1
      api.minor_version = 1

      text = "<API\n"
      text += "majorVersion= '#{api.major_version}'\n"
      text += "minorVersion= '#{api.minor_version}'\n"
      text += "getRouteJourneyIds = '#{CONTROLLER_URL}/pass/route_journeys.text'\n"
      text += "getRouteDefinition = '#{CONTROLLER_URL}/pass/route_journey/'\n"
      text += "getJourneyLocation = '#{CONTROLLER_URL}/pass/curloc/'\n"
      text += "/>"
      api.definition = text
      Api.transaction do
        Api.delete_all
        api.save!
      end
   end

  end
