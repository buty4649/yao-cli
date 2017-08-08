module Yao::Resources::Dumper
  class LoadBalancerHealthMonitor < Base

    self.fields = %w(
      id name admin_state_up provisioning_status delay expected_codes max_retries
      http_method timeout max_retries_down url_path type operating_status
      pools
    )

  end
end
