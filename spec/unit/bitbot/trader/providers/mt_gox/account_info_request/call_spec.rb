require "spec_helper"

describe Providers::MtGox::AccountInfoRequest, "#call" do
  subject { request.call }

  let(:request)  { described_class.new(client) }
  let(:client)   { HttpRequestMock.new }

  let(:result)      { {"data" => raw_account} }
  let(:raw_account) { double }

  before do
    client.stub(:post).with("money/info").and_return(result)
  end

  it "parses open orders" do
    Providers::MtGox::AccountInfoParser.should_receive(:new).
      with(raw_account).
      and_return(double(parse: "result"))
    expect(subject).to eq("result")
  end
end
