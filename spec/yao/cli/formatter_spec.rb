require 'spec_helper'

RSpec.describe Yao::Cli::Formatter do
  it "list formats" do
    expect(Yao::Cli::Formatter.formats).to eq %w(json yaml)
  end

  it "get method" do
    expect(Yao::Cli::Formatter.get("json").to_s).to eq "Yao::Cli::Formatter::JSON"
    expect(Yao::Cli::Formatter.get("yaml").to_s).to eq "Yao::Cli::Formatter::YAML"
  end
end
