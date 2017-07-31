require "thor"
require "json"

module Yao::Cli
  class Server < Base
    desc "list", "list servers"
    def list
      server = Yao::Server.list_detail

      pretty_output(Yao::Resources::Dumper::Server.dump(server))
    end

    desc "show", "show server details"
    def show(id_or_name)
      if is_uuid?(id_or_name)
        result = Yao::Resources::Server.find id_or_name
      else
        result = Yao::Server.list_detail.select{|s| s.name == id_or_name}
      end
      pretty_output(Yao::Resources::Dumper::Server.dump(result))
    end

    desc "create <name>", "create server"
    option :flavor, :required => true, :type => :string
    option :image,  :required => true, :type => :string
    option :network, :type => :string
    option :port,    :type => :string
    def create(name)
      flavor = options[:flavor]
      image = options[:image]
      network = options[:network]
      port = options[:port]

      if network.nil? && port.nil?
        puts "Error: network or port is must be set."
        exit 1
      end

      flavor = if is_uuid?(flavor)
                 flavor
               else
                 f = Yao::Resources::Flavor.list.select{|f| f.name == flavor}
                 if f.size > 1
                   puts "Error: flavor is not uniq. please use uuid."
                   exit 1
                 end
                 f[0].id
               end

      image = if is_uuid?(image)
                image
              else
                i = Yao::Resources::Image.list.select{|i| i.name == image}
                if i.size > 1
                  puts "Error: image is not uniq. please use uuid."
                  exit 1
                end
                i[0].id
              end

      params = {
        "name" => name,
        "flavorRef" => flavor,
        "imageRef" => image,
      }

      params.merge!({"networks" => [{"uuid" => network}]}) unless network.nil?
      params.merge!({"networks" => [{"port" => port}]})    unless port.nil?

      p Yao::Resources::Server.create(params)
    end

    desc "destroy <name>", "destroy server"
    def destroy(id_or_name)
      p Yao::Resources::Server.destroy(id_or_name)
    end
  end
end
