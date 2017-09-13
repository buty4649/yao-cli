require 'thor'
require 'yao/cli/formatter'

module Yao::Cli
  class Base < Thor
    class_option :format, :type => :string, :aliases => :f,
      :enum => Yao::Cli::Formatter.formats, :desc => "Output format (default: json)"
    class_option :debug, :type => :boolean, :aliases => :d,
      :default => false, :desc => "Enable debug mode"

    no_commands do
      def invoke_command(commands, *args)
        if commands.name != "help"
          debug_flag = options[:debug]
          Yao.configure do
            auth_url    ENV['OS_AUTH_URL']
            tenant_name ENV['OS_TENANT_NAME']
            username    ENV['OS_USERNAME']
            password    ENV['OS_PASSWORD']
            client_cert ENV['OS_CERT']
            client_key  ENV['OS_KEY']
            region_name ENV['OS_REGION_NAME']
            debug       debug_flag
          end
        end

        super
      end
    end

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
