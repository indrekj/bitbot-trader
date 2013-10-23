require "spec_helper"

describe Providers::Bitstamp::OpenOrdersRequest do
  describe "#call" do
    subject { request.call }

    let(:request)  { described_class.new(client) }
    let(:client)   { HttpRequestMock.new }

    let(:raw_open_orders) { [raw_open_order] }
    let(:raw_open_order)  { double("raw open order") }

    before do
      client.stub(:post).with("open_orders").and_return(raw_open_orders)
    end

    it "parses open orders" do
      Providers::Bitstamp::OpenOrderParser.should_receive(:new).
        with(raw_open_order).
        and_return(double(parse: "result"))
      expect(subject).to eq(["result"])
    end
  end
end
