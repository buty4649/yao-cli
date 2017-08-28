module Yao::Resources::Dumper
  class LoadBalancerPool < Base

    self.fields = %w(
      id lb_algorithm protocol description admin_state_up provisioning_status
      session_persistence operating_status name
    )

    self.bug_fields = %w(
      project
    )

  end
end
