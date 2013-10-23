require "spec_helper"

describe Bitbot::Trader::Request do
  describe "#initialize" do
    subject { described_class.new(client) }

    let(:client) { double("client") }

    it { should be_a(described_class) }
  end

  describe "#call" do
    let(:client) { double("client") }

    context "without arguments" do
      it "should raise NotImplementedError" do
        expect {
          described_class.new(client).call
        }.to raise_error(NotImplementedError)
      end
    end

    context "with arguments" do
      it "should raise NotImplementedError" do
        expect {
          described_class.new(client).call("argument")
        }.to raise_error(NotImplementedError)
      end
    end
  end

  describe "#client" do
    subject { described_class.new(client).client }

    let(:client) { double("client") }

    it { should eql(client) }
  end
end
