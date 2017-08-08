require 'yao/cli/base'

module Yao::Cli::LBaaS
    class HealthMonitor < Yao::Cli::Base
      namespace "lbaas healthmonitor"

      desc "list", "list health monitors"
      def list
        result = Yao::Resources::LoadBalancerHealthMonitor.list

        pretty_output(Yao::Resources::Dumper::LoadBalancerHealthMonitor.dump(result))
      end

      desc "show <uuid or name>", "show health monitor details"
      def show(id_or_name)
        if is_uuid?(id_or_name)
          result = Yao::Resources::LoadBalancerHealthMonitor.find id_or_name
        else
          result = Yao::Resources::LoadBalancerHealthMonitor.list.select do |lb|
            lb.name == id_or_name
          end
        end
        pretty_output(Yao::Resources::Dumper::LoadBalancerHealthMonitor.dump(result))
      end

      desc "create", "create health monitor"
      option :name,             :type => :string
      option :delay,            :type => :numeric, :required => true
      option :expected_codes,   :type => :string
      option :http_method,      :type => :string, :default => "GET", :enum => %w(CONNECT DELETE GET HEAD OPTIONS PATCH POST PUT TRACE)
      option :max_retries,      :type => :numeric, :required => true, :enum => (1..10).to_a
      option :max_retries_down, :type => :numeric, :default => 3, :enum => (1..10).to_a
      option :pool_id,          :type => :string, :required => true
      option :timeout,          :type => :numeric, :required => true
      option :type,             :type => :string, :required => true, :enum => %w(HTTP HTTPS PING TCP TLS-HELLO)
      option :url_path,         :type => :string
      def create
        params = generate_params
        result = Yao::Resources::LoadBalancerHealthMonitor.create params

        # fix: すぐに出力するとvip_port_idがnullなのでエラーになる
        #pretty_output(Yao::Resources::Dumper::LoadBalancerHealthMonitor.dump(result))
      end

      desc "update <uuid>", "update health monitor"
      option :admin_state_up, :type => :boolean
      option :delay,            :type => :numeric, :required => true
      option :expected_codes,   :type => :string
      option :http_method,      :type => :string, :default => "GET", :enum => %w(CONNECT DELETE GET HEAD OPTIONS PATCH POST PUT TRACE)
      option :max_retries,      :type => :numeric, :required => true, :enum => (1..10).to_a
      option :max_retries_down, :type => :numeric, :default => 3, :enum => (1..10).to_a
      option :name,             :type => :string
      option :timeout,          :type => :numeric, :required => true
      option :url_path,         :type => :string
      def update(uuid)
        params = generate_params
        result = Yao::Resources::LoadBalancerHealthMonitor.update(uuid, params)
        pretty_output(Yao::Resources::Dumper::LoadBalancerHealthMonitor.dump(result))
      end

      desc "remove <uuid>", "remove loadbalancer"
      def remove(uuid)
        Yao::Resources::LoadBalancerHealthMonitor.destroy(uuid)
      end
    end
end
