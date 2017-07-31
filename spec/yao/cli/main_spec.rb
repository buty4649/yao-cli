require "spec_helper"

RSpec.describe Yao::Cli::Main do
  it "show version" do
    expect{ Yao::Cli::Main.new.invoke(:version) }.to output("#{Yao::Cli::VERSION}\n").to_stdout
  end
end
