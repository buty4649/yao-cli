require "spec_helper"

RSpec.describe Yao::Cli do
  it "has a version number" do
    expect(Yao::Cli::VERSION).not_to be nil
  end
end
