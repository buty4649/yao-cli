module Yao::Resources::Dumper
  class Server < Base

    self.fields = %w(
      id addresses metadata name progress status tenant_id user_id key_name
      host_id flavor image security_groups availability_zone dcf_disk_config
      ext_srv_attr_host ext_srv_attr_hypervisor_hostname ext_srv_attr_instance_name
      ext_sts_power_state ext_sts_task_state ext_sts_vm_state
    )

  end
end
