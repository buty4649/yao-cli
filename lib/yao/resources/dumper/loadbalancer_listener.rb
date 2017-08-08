module Yao::Resources::Dumper
  class LoadBalancerListener < Base

    self.fields = %w(
      id description admin_state_up protocol protocol_port provisioning_status
      default_tls_container_ref insert_headers operating_status sni_container_refs
      l7policies name created_at updated_at
    
    )

  end
end
