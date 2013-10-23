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

  describe "#open_orders" do
    subject { provider.open_orders }

    let(:provider) { described_class.new(options, client) }
    let(:options)  { { username: "double", password: "double" } }
    let(:client)   { double.as_null_object }

    let(:request)     { double("request", call: open_orders) }
    let(:open_orders) { double("open orders") }

    before do
      described_class::OpenOrdersRequest.stub(:new).with(client) { request }
    end

    it { should be(open_orders) }
  end
end
