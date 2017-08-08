require 'thor'
require 'yao/cli/formatter'

module Yao::Cli
  class Base < Thor
    class_option :format, :type => :string, :aliases => :f,
      :enum => Yao::Cli::Formatter.formats, :desc => "Output format (default: json)"

    private
    def pretty_output(obj)
      format = options[:format] || "json"
      puts Yao::Cli::Formatter.get(format).dump(obj)
    end

    def is_uuid?(str)
      /^[\da-f]{32}$/ === str or
      /^[\da-f]{8}-([\da-f]{4}-){3}[\da-f]{12}$/ === str
    end


  end
end
