require "spec_helper"

describe Providers::MtGox::HttpClient do
  describe ".build" do
    subject { described_class.build(options) }

    let(:options) { {api_key: "double", api_secret: "double"} }
    let(:connection) { double }

    before do
      described_class.should_receive(:make_connection).with("double", "double").
        and_return(connection)
    end

    it { should be_a(described_class) }
    its(:connection) { should be(connection) }
  end

  describe ".make_connection" do
    subject(:connection) { described_class.make_connection("key", "secret") }

    it { should be_a(Faraday::Connection) }

    it "has correct url_prefix" do
      expect(subject.url_prefix.to_s + "/").to eq(described_class::HOST)
    end

    context "request handlers" do
      subject { connection.builder.handlers }

      it { should eq([
        Faraday::Request::UrlEncoded,
        Providers::MtGox::HttpClient::HmacMiddleware,
        Faraday::Adapter::NetHttp])
      }

      it "has HmacMiddleware with correct params" do
        connection.builder.handlers.delete(subject[0])
        hmac_middleware = connection.builder.to_app(double)
        expect(hmac_middleware.key).to eq("key")
        expect(hmac_middleware.secret).to eq("secret")
      end
    end
  end

  describe "#initialize" do
    let(:connection) { double("connection") }

    context "with default nonce generator" do
      subject { described_class.new(connection) }

      it { should be_a(described_class) }
      its(:nonce_generator) { should be(Utils::NonceGenerator) }
    end

    context "with custom nonce generator" do
      subject { described_class.new(connection, nonce_generator) }

      let(:nonce_generator) { double("nonce generator") }

      it { should be_a(described_class) }
      its(:nonce_generator) { should be(nonce_generator) }
    end
  end

  describe "#post" do
    let(:client)          { described_class.new(connection, nonce_generator) }
    let(:connection)      { double("connection") }
    let(:nonce_generator) { double(generate: 123) }
    let(:path)            { "some_action" }

    context "with default options" do
      subject { client.post(path) }

      let(:options) { {param: "value"} }

      before do
        connection.should_receive(:post).
          with("some_action", {nonce: 123}).
          and_return(double(body: '{"result": "yey"}'))
      end

      it { should eq({"result" => "yey"}) }
    end

    context "with custom options" do
      subject { client.post(path, options) }

      let(:options) { {param: "value"} }

      before do
        connection.should_receive(:post).
          with("some_action", {param: "value", nonce: 123}).
          and_return(double(body: '{"result": "yey"}'))
      end

      it { should eq({"result" => "yey"}) }
    end
  end
end
