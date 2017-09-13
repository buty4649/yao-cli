require 'thor'

module Yao::Cli
  class Main < Thor
    desc "version", "show version"
    def version(*args)
      puts Yao::Cli::VERSION
    end

    desc "lbaas", "lbaas subcommands"
    subcommand("lbaas", Yao::Cli::LBaaS::Main)

    desc "server", "server subcommands"
    subcommand("server", Yao::Cli::Server)
  end
end
