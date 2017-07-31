require 'thor'

module Yao::Cli
  class Main < Thor

    def initialize(*args)
      super

      Yao.configure do
        auth_url    ENV['OS_AUTH_URL']
        tenant_name ENV['OS_TENANT_NAME']
        username    ENV['OS_USERNAME']
        password    ENV['OS_PASSWORD']
        client_cert ENV['OS_CERT']
        client_key  ENV['OS_KEY']
        region_name ENV['OS_REGION_NAME']
      end
    end

    desc "version", "show version"
    def version(*args)
      puts Yao::Cli::VERSION
    end

    desc "server", "server subcommands"
    subcommand("server", Yao::Cli::Server)
  end
end
