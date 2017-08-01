require 'yao/cli/formatter/json'
require 'yao/cli/formatter/yaml'

module Yao::Cli
  module Formatter
    def self.formats
      constants.map{|c| c.to_s.downcase}.sort
    end

    def self.get(format)
      const_get(format.upcase)
    end
  end
end
