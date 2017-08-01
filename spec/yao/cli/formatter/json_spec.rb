require 'spec_helper.rb'

RSpec.describe Yao::Cli::Formatter::JSON do
  it "dump" do
    expect(
      Yao::Cli::Formatter::JSON.dump({"foo" => "bar"})
    ).to eq '{"foo":"bar"}'
  end
end
