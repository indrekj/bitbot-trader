require "spec_helper"

describe Providers::Bitstamp, "#open_orders" do
  subject { provider.open_orders }

  let(:provider)    { described_class.new(username: "mock", password: "mock") }
  let(:request)     { stub("request", call: open_orders) }
  let(:open_orders) { stub("open orders") }

  before do
    described_class::OpenOrdersRequest.stub(:new).with(provider) { request }
  end

  it { should be(open_orders) }
end
