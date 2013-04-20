require "spec_helper"

describe Bitbot::Trader::Request, "#call" do
  subject { described_class.new(client).call }

  let(:client) { mock("client") }

  it "should raise NotImplementedError" do
    expect {
      subject
    }.to raise_error(NotImplementedError)
  end
end
