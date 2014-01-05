require "spec_helper"

describe Providers::Bitstamp::HttpClient do
  describe ".build" do
    subject { described_class.build(options) }

    let(:options) { {client_id: 12, api_key: "key", api_secret: "secret"} }
    let(:connection) { double }

    before do
      described_class.should_receive(:make_connection).
        and_return(connection)
    end

    it { should be_a(described_class) }
    its(:client_id)  { should eq(12) }
    its(:api_key)    { should eq("key") }
    its(:api_secret) { should eq("secret") }
    its(:connection) { should be(connection) }
  end

  describe ".make_connection" do
    subject(:connection) { described_class.make_connection }

    it { should be_a(Faraday::Connection) }

    it "has correct url_prefix" do
      expect(subject.url_prefix.to_s + "/").to eq(described_class::HOST)
    end

    context "request handlers" do
      subject { connection.builder.handlers }

      it { should eq([
        Faraday::Request::UrlEncoded,
        Faraday::Adapter::NetHttp])
      }
    end
  end

  describe "#post" do
    let(:client)     { described_class.new(connection, client_id: 1, api_key: "key", api_secret: "secret") }
    let(:connection) { double("connection") }
    let(:path)       { "some_action" }

    before do
      allow(Utils::NonceGenerator).to receive(:generate) { 1388950877 }
    end

    context "with default options" do
      subject { client.post(path) }

      let(:options) { {param: "value"} }

      before do
        connection.should_receive(:post).
          with("some_action/",
            key: "key", nonce: 1388950877,
            signature: "0EE372B2558D2D1CB3C4DD7F48A2BD7ED14D91240940CBD883CBADD28E2997B5"
          ).
          and_return(double(body: '{"result": "yey"}'))
      end

      it { should eq({"result" => "yey"}) }
    end

    context "with custom options" do
      subject { client.post(path, options) }

      let(:options) { {param: "value"} }

      before do
        connection.should_receive(:post).
          with("some_action/",
            param: "value", key: "key", nonce: 1388950877,
            signature: "0EE372B2558D2D1CB3C4DD7F48A2BD7ED14D91240940CBD883CBADD28E2997B5"
          ).
          and_return(double(body: '{"result": "yey"}'))
      end

      it { should eq({"result" => "yey"}) }
    end
  end
end
