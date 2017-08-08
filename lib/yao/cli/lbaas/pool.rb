require 'yao/cli/base'
require 'yao/cli/lbaas/pool_member'

module Yao::Cli::LBaaS
    class Pool < Yao::Cli::Base
      namespace "lbaas pool"

      desc "list", "list pools"
      def list
        result = Yao::Resources::LoadBalancerPool.list

        pretty_output(Yao::Resources::Dumper::LoadBalancerPool.dump(result))
      end

      desc "show <uuid or name>", "show pool details"
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

      desc "create", "create pool"
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

        params = generate_params
        result = Yao::Resources::LoadBalancerPool.create params

        # fix: すぐに出力するとvip_port_idがnullなのでエラーになる
        #pretty_output(Yao::Resources::Dumper::LoadBalancerPool.dump(result))
      end

      desc "update <uuid>", "update pool "
      option :admin_state_up, :type => :boolean
      option :description,    :type => :string
      option :name,           :type => :string
      option :lb_algorithm,   :type => :string, :enum => %w(LEAST_CONNECTIONS ROUND_ROBIN SOURCE_IP)
      def update(uuid)
        params = generate_params
        result = Yao::Resources::LoadBalancerPool.update(uuid, params)
        pretty_output(Yao::Resources::Dumper::LoadBalancerPool.dump(result))
      end

      desc "remove <uuid>", "remove pool"
      def remove(uuid)
        Yao::Resources::LoadBalancerPool.destroy(uuid)
      end

      desc "member", "pool member subcommands"
      subcommand("member", Yao::Cli::LBaaS::PoolMember)
    end
end
