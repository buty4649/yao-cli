require 'thor'

module Yao::Cli
  class Main < Thor

    desc "version", "show version"
    def version(*args)
      puts Yao::Cli::VERSION
    end
  end
end
