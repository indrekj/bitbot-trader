require "spec_helper"

describe Providers::Bitstamp::HttpClient, ".make_connection" do
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
