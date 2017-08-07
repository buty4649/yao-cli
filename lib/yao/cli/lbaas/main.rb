require 'thor'
require 'yao/cli/base'
require 'yao/cli/lbaas/lb'

module Yao::Cli::LBaaS
  class Main < Thor
    namespace :lbaas

    desc "lb", "loadbalancer subcommands"
    subcommand("lb", Yao::Cli::LBaaS::LB)
  end
end
