require "spec_helper"

describe Providers::Bitstamp::HttpClient, ".build" do
  subject { described_class.build(options) }

  let(:options) { {username: "double", password: "double"} }

  before do
    described_class.should_receive(:make_connection).
      and_return(double("connection"))
  end

  it { should be_a(described_class) }
  its(:username) { should eq("double") }
  its(:password) { should eq("double") }
end
