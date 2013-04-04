require "spec_helper"

describe Providers::Bitstamp::OpenOrdersRequest, "#call" do
  subject { request.call }

  let(:request)  { described_class.new(provider, client) }
  let(:provider) { Providers::Bitstamp.new(username: "", password: "") }
  let(:client)   { HttpRequestMock.new }

  let(:raw_open_orders) { [raw_open_order] }
  let(:raw_open_order)  { stub("raw open order") }

  before do
    client.stub(:post).
      with("https://www.bitstamp.net/api/open_orders/", {user: "", password: ""}).
      and_return(raw_open_orders)
  end

  it "parses open orders" do
    Providers::Bitstamp::OpenOrderParser.should_receive(:new).
      with(raw_open_order).
      and_return(stub(parse: "result"))
    expect(subject).to eq(["result"])
  end
end
