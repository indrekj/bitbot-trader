require "spec_helper"

describe Providers::MtGox::HttpClient, "#post" do
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
