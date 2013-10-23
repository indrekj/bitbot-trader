require "spec_helper"

describe Providers::Bitstamp::HttpClient, "#post" do
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
