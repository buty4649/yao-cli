require 'thor'
require 'yao/cli/base'
require 'yao/cli/lbaas/lb'
require 'yao/cli/lbaas/listener'

module Yao::Cli::LBaaS
  class Main < Thor
    namespace :lbaas

    desc "lb", "loadbalancer subcommands"
    subcommand("lb", Yao::Cli::LBaaS::LB)

    desc "listener", "listener subcommands"
    subcommand("listener", Yao::Cli::LBaaS::Listener)
  end
end
