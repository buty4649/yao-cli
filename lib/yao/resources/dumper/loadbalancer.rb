module Yao::Resources::Dumper
  class LoadBalancer < Base

    # fix: updated_atがnilのときに落ちる。直るまで含めない
    self.fields = %w(
      id provider description admin_state_up provisioning_status
      vip_address operationg_status name created_at
      project vip_network vip_port vip_subnet listeners pools
    )

    self.bug_fields = %w(
      project vip_network vip_port vip_subnet
    )
    
  end
end
