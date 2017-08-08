module Yao::Resources::Dumper
  class Subnet < Base

    self.fields = %w(
      id name cidr gateway_ip network_id tenant_id ip_version
      dns_nameservers host_routes allocation_pools dhcp_enabled?
    
    )

  end
end
