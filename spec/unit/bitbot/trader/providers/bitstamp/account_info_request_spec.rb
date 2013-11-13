require "spec_helper"

describe Providers::Bitstamp::AccountInfoRequest do
  describe "#call" do
    subject { request.call }

    let(:request)  { described_class.new(client) }
    let(:client)   { HttpRequestMock.new }

    let(:raw_account) { double }

    before do
      client.stub(:post).with("balance").and_return(raw_account)
    end

    it "parses open orders" do
      Providers::Bitstamp::AccountInfoParser.should_receive(:new).
        with(raw_account).
        and_return(double(parse: "result"))
      expect(subject).to eq("result")
    end
  end
end
