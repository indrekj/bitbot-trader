require "spec_helper"

describe Providers::Bitstamp::HttpClient, ".build" do
  subject { described_class.build(options) }

  let(:options) { {username: "mock", password: "mock"} }

  before do
    described_class.should_receive(:make_connection).
      and_return(mock("connection"))
  end

  it { should be_a(described_class) }
  its(:username) { should eq("mock") }
  its(:password) { should eq("mock") }
end
