require 'yao/cli/base'

module Yao::Cli::LBaaS
    class Listener < Yao::Cli::Base
      namespace "lbaas listener"

      desc "list", "list listeners"
      def list
        result = Yao::Resources::LoadBalancerListener.list

        pretty_output(Yao::Resources::Dumper::LoadBalancerListener.dump(result))
      end

      desc "show <uuid or name>", "show loadbalancer details"
      def show(id_or_name)
        if is_uuid?(id_or_name)
          result = Yao::Resources::LoadBalancerListener.find id_or_name
        else
          result = Yao::Resources::LoadBalancerListener.list.select do |lb|
            lb.name == id_or_name
          end
        end
        pretty_output(Yao::Resources::Dumper::LoadBalancerListener.dump(result))
      end

      desc "create", "create loadbalancer"
      option :name,           :type => :string
      option :description,    :type => :string
      option :loadbalancer_id,:type => :string, :required => true
      option :protocol,       :type => :string, :required => true, :enum => %w(HTTP HTTPS TCP TERMINATED_HTTPS)
      option :protocol_port,  :type => :numeric,:required => true
      def create
        params = generate_params
        result = Yao::Resources::LoadBalancerListener.create params

        # fix: すぐに出力するとcreate_atがnullでエラーになる。直るまでコメントアウト
        #pretty_output(Yao::Resources::Dumper::LoadBalancerListener.dump(result))
      end

      desc "update <uuid>", "update loadbalancer"
      option :admin_state_up, :type => :boolean
      option :description,    :type => :string
      option :name,           :type => :string
      def update(uuid)
        params = generate_params
        result = Yao::Resources::LoadBalancerListener.update(uuid, params)
        pretty_output(Yao::Resources::Dumper::LoadBalancerListener.dump(result))
      end

      desc "remove <uuid>", "remove loadbalancer"
      option :cascade, :type => :boolean
      def remove(uuid)
        Yao::Resources::LoadBalancerListener.destroy(uuid)
      end
    end
end
