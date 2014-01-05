require "spec_helper"

describe Providers::Bitstamp do
  let(:provider) { described_class.new({}, client) }
  let(:client)   { double.as_null_object }

  describe "#initialize" do
    let(:options) { double("options") }

    context "when with custom http client" do
      subject { described_class.new(options, http_client) }

      let(:http_client) { double("HttpClient") }

      it { should be_a(described_class) }
      its(:client) { should be(http_client) }
    end

    context "when with default http client class" do
      subject { described_class.new(options) }

      before do
        described_class::HttpClient.should_receive(:build).with(options)
      end

      it { should be_a(described_class) }
    end
  end

  describe "#open_orders" do
    subject { provider.open_orders }

    let(:raw_orders) { [double] }
    let(:parsed_orders) { double }

    before do
      allow(client).to receive(:post).with("open_orders", {}) { raw_orders }
      allow(described_class::OpenOrderParser).
        to receive(:parse_collection).
        with(raw_orders) { parsed_orders }
    end

    it "parses requested orders" do
      should be(parsed_orders)
    end
  end

  describe "#account" do
    subject { provider.account }

    let(:raw_account) { double }
    let(:parsed_account) { double }

    before do
      allow(client).to receive(:post).with("balance", {}) { raw_account }
      allow(described_class::AccountInfoParser).
        to receive(:parse).
        with(raw_account) { parsed_account }
    end

    it "parses requested account" do
      should be(parsed_account)
    end
  end

  describe "#buy" do
    subject { provider.buy(amount: amount, price: price) }

    let(:amount) { 0.1 }
    let(:price)  { 344.5 }
    let(:raw_open_order) { double }
    let(:parsed_open_order) { double }

    before do
      allow(client).to receive(:post).
        with("buy", {amount: 0.1, price: 344.5}) { raw_open_order }
      allow(described_class::OpenOrderParser).
        to receive(:parse).
        with(raw_open_order) { parsed_open_order }
    end

    it "parses result" do
      should be(parsed_open_order)
    end
  end
end
