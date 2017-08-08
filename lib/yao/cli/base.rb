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

    def generate_params
      command = caller.first.split(' ')[1].delete('`').delete("'")
      command_options = self.class.commands[command].options.map do |opt|
        opt.first.to_s
      end

      command_options.map do |name|
        if opt = options[name]
          [name, opt]
        end
      end.compact.to_h
    end

    class << self
      def banner(command, namespace = nil, subcommand = false)
        if namespace.nil? && !subcommand
          # yao lbaas lb help <command> のときにUsageがおかしくなるので対処
          super(command, false, true)
        else
          super
        end
      end
    end
  end
end
