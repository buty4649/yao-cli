require 'yaml'

module Yao::Cli::Formatter
  class YAML
    def self.dump(obj)
      ::YAML.dump(obj)
    end
  end
end

