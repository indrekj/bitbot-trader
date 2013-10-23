require "spec_helper"

describe Providers::Bitstamp::HttpClient do
  describe ".build" do
    subject { described_class.build(options) }

    let(:options) { {username: "double", password: "double"} }
    let(:connection) { double }

    before do
      described_class.should_receive(:make_connection).
        and_return(connection)
    end

    it { should be_a(described_class) }
    its(:username) { should eq("double") }
    its(:password) { should eq("double") }
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
    let(:client)     { described_class.new(connection, "username", "password") }
    let(:connection) { double("connection") }
    let(:path)       { "some_action" }

    context "with default options" do
      subject { client.post(path) }

      let(:options) { {param: "value"} }

      before do
        connection.should_receive(:post).
          with("some_action/", {user: "username", password: "password"}).
          and_return(double(body: '{"result": "yey"}'))
      end

      it { should eq({"result" => "yey"}) }
    end

    context "with custom options" do
      subject { client.post(path, options) }

      let(:options) { {param: "value"} }

      before do
        connection.should_receive(:post).
          with("some_action/", {
            user: "username", password: "password", param: "value"
          }).
          and_return(double(body: '{"result": "yey"}'))
      end

      it { should eq({"result" => "yey"}) }
    end
  end
end
