require "spec_helper"

describe Providers::Bitstamp, "#initialize" do
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
