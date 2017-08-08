module Yao::Resources::Dumper
  class LoadBalancerPoolMember < Base

    # fix: subnetがnilのときに落ちる。直るまで含めない
    self.fields = %w(
      id monitor_port name weight admin_state_up provisioning_status
      monitor_address address protocol_port operating_status
      project
    )

  end
end
