module Yao::Resources::Dumper
  class Network < Base

    self.fields = %w(
      id name status shared tenant_id subnets admin_state_up
      physical_network type segmentation_id shared?
    )

  end
end
