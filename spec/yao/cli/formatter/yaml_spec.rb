require 'spec_helper.rb'

RSpec.describe Yao::Cli::Formatter::YAML do
  it "dump" do
    expect(
      Yao::Cli::Formatter::YAML.dump({"foo" => "bar"})
    ).to eq "---\nfoo: bar\n"
  end
end
