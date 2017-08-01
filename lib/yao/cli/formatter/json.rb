require 'json'

module Yao::Cli::Formatter
  class JSON
    def self.dump(obj)
      ::JSON.dump(obj)
    end
  end
end
