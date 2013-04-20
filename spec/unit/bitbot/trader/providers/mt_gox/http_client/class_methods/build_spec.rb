require "spec_helper"

describe Providers::MtGox::HttpClient, ".build" do
  subject { described_class.build(options) }

  let(:options) { {key: "mock", secret: "mock"} }

  before do
    described_class.should_receive(:make_connection).with("mock", "mock").
      and_return(mock("connection"))
  end

  it { should be_a(described_class) }
end
