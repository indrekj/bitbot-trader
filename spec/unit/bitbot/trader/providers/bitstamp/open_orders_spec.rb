require "spec_helper"

describe Providers::Bitstamp, "#open_orders" do
  subject { provider.open_orders }

  let(:provider) { described_class.new(options, client) }
  let(:options)  { { username: "mock", password: "mock" } }
  let(:client)   { mock.as_null_object }

  let(:request)     { stub("request", call: open_orders) }
  let(:open_orders) { stub("open orders") }

  before do
    described_class::OpenOrdersRequest.stub(:new).with(client) { request }
  end

  it { should be(open_orders) }
end
