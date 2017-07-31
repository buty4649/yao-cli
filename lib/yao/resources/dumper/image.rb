module Yao::Resources::Dumper
  class Image < Base
    self.fields = %w(id name name status progress metadata
                     min_disk min_ram size)
  end
end
