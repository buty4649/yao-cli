module Yao::Resources::Dumper
  class Port < Base

    self.fields = %w(
      id name mac_address status allowed_address_pairs device_owner
      fixed_ips security_groups device_id network_id tenant_id admin_state_up
      host_id
    )

  end
end
