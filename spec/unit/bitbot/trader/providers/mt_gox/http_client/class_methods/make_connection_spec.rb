require "spec_helper"

describe Providers::MtGox::HttpClient, ".make_connection" do
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
