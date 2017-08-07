require 'yao/cli/base'

module Yao::Cli::LBaaS
    class LB < Yao::Cli::Base
      namespace "lbaas lb"

      desc "list", "list loadbalancers"
      def list
        result = Yao::Resources::LoadBalancer.list

        pretty_output(Yao::Resources::Dumper::LoadBalancer.dump(result))
      end

      desc "show <uuid or name>", "show loadbalancer details"
      def show(id_or_name)
        if is_uuid?(id_or_name)
          result = Yao::Resources::LoadBalancer.find id_or_name
        else
          result = Yao::Resources::LoadBalancer.list.select do |lb|
            lb.name == id_or_name
          end
        end
        pretty_output(Yao::Resources::Dumper::LoadBalancer.dump(result))
      end

      desc "create", "create loadbalancer"
      option :name,           :type => :string
      option :description,    :type => :string
      option :vip_network_id, :type => :string
      option :vip_port_id,    :type => :string
      option :vip_subnet_id,  :type => :string
      def create
        vip_options = %w(vip_network_id vip_port_id vip_subnet_id)
        unless vip_options.map{|s| options[s]}.one?
          puts "Error: One of vip_network_id, vip_port_id, or vip_subnet_id must be specified."
          exit 1
        end

        params = {}
        (%w(name description) + vip_options).each do |key|
          if options.key?(key)
            params.merge!({key.to_s => options[key]})
          end
        end

        result = Yao::Resources::LoadBalancer.create params

        # fix: すぐに出力するとvip_port_idがnullなのでエラーになる
        #pretty_output(Yao::Resources::Dumper::LoadBalancer.dump(result))
      end

      desc "update <uuid>", "update loadbalancer"
      option :admin_state_up, :type => :boolean
      option :description,    :type => :string
      option :name,           :type => :string
      def update(uuid)
        params = {}

        %w(admin_state_up description name).each do |key|
          value = options[key]
          if value
            params.merge!(key => value)
          end
        end

        result = Yao::Resources::LoadBalancer.update(uuid, params)
        pretty_output(Yao::Resources::Dumper::LoadBalancer.dump(result))
      end

      desc "remove <uuid>", "remove loadbalancer"
      option :cascade, :type => :boolean
      def remove(uuid)
        Yao::Resources::LoadBalancer.delete(uuid)
      end

      class << self
        def banner(command, namespace = nil, subcommand = false)
          if namespace.nil? && !subcommand
            # yao lbaas lb help <command> のときにUsageがおかしくなるので対処
            super(command, false, true)
          else
            super
          end
        end
      end
    end
end
