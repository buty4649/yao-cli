require 'thor'
require 'json'

module Yao::Cli
  class Base < Thor
    private
    def pretty_output(obj)
      puts JSON.dump(obj)
    end

    def is_uuid?(str)
      /^[\da-f]{32}$/ === str or
      /^[\da-f]{8}-([\da-f]{4}-){3}[\da-f]{12}$/ === str
    end
  end
end
