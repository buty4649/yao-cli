module Yao::Resources::Dumper
  class SecurityGroup < Base
    self.fields = %w(id name description tenant_id)
  end
end
