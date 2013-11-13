require "spec_helper"

describe Providers::Bitstamp do
  describe "#initialize" do
    let(:options)  { double("options") }
    let(:username) { "23443" }
    let(:password) { "TopSecret" }

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

  let(:provider) { described_class.new({}, client) }
  let(:client)   { double.as_null_object }

  describe "#open_orders" do
    subject { provider.open_orders }

    let(:raw_orders) { [double] }
    let(:parsed_orders) { double }

    before do
      allow(client).to receive(:post).with("open_orders") { raw_orders }
      allow(described_class::OpenOrderParser).
        to receive(:parse_collection).
        with(raw_orders) { parsed_orders }
    end

    it "parses requested orders" do
      expect(provider.open_orders).to eq(parsed_orders)
    end
  end

  describe "#account" do
    subject { provider.account }

    let(:raw_account) { double }
    let(:parsed_account) { double }

    before do
      allow(client).to receive(:post).with("balance") { raw_account }
      allow(described_class::AccountInfoParser).
        to receive(:parse).
        with(raw_account) { parsed_account }
    end

    it "parses requested account" do
      expect(provider.account).to eq(parsed_account)
    end
  end
end
