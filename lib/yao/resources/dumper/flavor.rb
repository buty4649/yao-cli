module Yao::Resources::Dumper
  class Flavor < Base
    self.fields = %w(id name vcpus disk memory public? disabled?)
  end
end
