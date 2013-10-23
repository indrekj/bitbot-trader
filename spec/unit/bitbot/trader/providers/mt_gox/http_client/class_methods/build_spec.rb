require "spec_helper"

describe Providers::MtGox::HttpClient, ".build" do
  subject { described_class.build(options) }

  let(:options) { {key: "double", secret: "double"} }

  before do
    described_class.should_receive(:make_connection).with("double", "double").
      and_return(double("connection"))
  end

  it { should be_a(described_class) }
end
