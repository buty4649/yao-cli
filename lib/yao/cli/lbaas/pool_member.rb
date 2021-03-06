require 'yao/cli/base'

module Yao::Cli::LBaaS
    class PoolMember < Yao::Cli::Base
      namespace "lbaas pool member"

      desc "list <pool>", "list members"
      def list(pool)
        result = Yao::Resources::LoadBalancerPoolMember.list(Yao::Resources::LoadBalancerPool.find pool)

        pretty_output(Yao::Resources::Dumper::LoadBalancerPoolMember.dump(result))
      end

      desc "show <pool> <uuid or name>", "show member details"
      def show(pool, id_or_name)
        if is_uuid?(id_or_name)
          result = Yao::Resources::LoadBalancerPoolMember.find(Yao::Resources::LoadBalancerPool.new({"id" => pool}), id_or_name)
        else
          result = Yao::Resources::LoadBalancerPoolMember.list(Yao::Resources::LoadBalancerPool.new({"id" => pool})).select do |lb|
            lb.name == id_or_name
          end
        end
        pretty_output(Yao::Resources::Dumper::LoadBalancerPoolMember.dump(result))
      end

      desc "add <pool>", "add member to pool"
      option :name,            :type => :string
      option :address,         :type => :string, :required => true
      option :monitor_address, :type => :string
      option :monitor_port,    :type => :numeric
      option :protocol_port,   :type => :numeric, :required => true
      option :subnet_id,       :type => :string
      option :weight,          :type => :numeric
      def add(pool)
        params = generate_params
        result = Yao::Resources::LoadBalancerPoolMember.create(Yao::Resources::LoadBalancerPool.new({"id" => pool}), params)

        # fix: すぐに出力するとvip_port_idがnullなのでエラーになる
        #pretty_output(Yao::Resources::Dumper::LoadBalancerPoolMember.dump(result))
      end

      desc "update <pool> <uuid>", "update member"
      option :admin_state_up,  :type => :boolean
      option :name,            :type => :string
      option :monitor_address, :type => :string
      option :monitor_port,    :type => :numeric
      option :weight,          :type => :numeric
      def update(pool, uuid)
        params = generate_params
        result = Yao::Resources::LoadBalancerPoolMember.update(Yao::Resources::LoadBalancerPool.new({"id" => pool}), uuid, params)
        pretty_output(Yao::Resources::Dumper::LoadBalancerPoolMember.dump(result))
      end

      desc "remove <pool> <uuid>", "remove member"
      def remove(pool, uuid)
        Yao::Resources::LoadBalancerPoolMember.destroy(Yao::Resources::LoadBalancerPool.new({"id" => pool}), uuid)
      end
    end
end
