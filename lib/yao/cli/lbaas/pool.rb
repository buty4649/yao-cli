require 'yao/cli/base'

module Yao::Cli::LBaaS
    class Pool < Yao::Cli::Base
      namespace "lbaas pool"

      desc "list", "list pools"
      def list
        result = Yao::Resources::LoadBalancerPool.list

        pretty_output(Yao::Resources::Dumper::LoadBalancerPool.dump(result))
      end

      desc "show <uuid or name>", "show loadbalancer details"
      def show(id_or_name)
        if is_uuid?(id_or_name)
          result = Yao::Resources::LoadBalancerPool.find id_or_name
        else
          result = Yao::Resources::LoadBalancerPool.list.select do |lb|
            lb.name == id_or_name
          end
        end
        pretty_output(Yao::Resources::Dumper::LoadBalancerPool.dump(result))
      end

      desc "create", "create loadbalancer"
      option :name,            :type => :string
      option :description,     :type => :string
      option :lb_algorithm,    :type => :string, :required => true, :enum => %w(LEAST_CONNECTIONS ROUND_ROBIN SOURCE_IP)
      option :listener_id,     :type => :string
      option :loadbalancer_id, :type => :string
      option :protocol,        :type => :string, :required => true, :enum => %w(HTTP HTTPS PROXY TCP)
      def create
        unless [options[:listener_id], options[:loadbalancer_id]].one?
          puts "Error: Either listener_id or loadbalancer_id must be specified."
          exit 1
        end

        params = {}
        %w(
          name description lb_algorithm listener_id
          loadbalancer_id protocol
        ).each do |key|
          if options.key?(key)
            params.merge!({key.to_s => options[key]})
          end
        end

        result = Yao::Resources::LoadBalancerPool.create params

        # fix: すぐに出力するとvip_port_idがnullなのでエラーになる
        #pretty_output(Yao::Resources::Dumper::LoadBalancerPool.dump(result))
      end

      desc "update <uuid>", "update loadbalancer"
      option :admin_state_up, :type => :boolean
      option :description,    :type => :string
      option :name,           :type => :string
      option :lb_algorithm,   :type => :string, :enum => %w(LEAST_CONNECTIONS ROUND_ROBIN SOURCE_IP)
      def update(uuid)
        params = {}

        %w(admin_state_up description name lb_algorithm).each do |key|
          value = options[key]
          if value
            params.merge!(key => value)
          end
        end

        result = Yao::Resources::LoadBalancerPool.update(uuid, params)
        pretty_output(Yao::Resources::Dumper::LoadBalancerPool.dump(result))
      end

      desc "remove <uuid>", "remove loadbalancer"
      def remove(uuid)
        Yao::Resources::LoadBalancerPool.destroy(uuid)
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
