require "spec_helper"

describe Providers::Bitstamp::OpenOrderParser, "#parse" do
  subject(:open_order) { parser.parse }

  let(:parser)  { described_class.new(data) }
  let(:data) {
    {
      "id"       => 2826860,
      "type"     => 0,
      "price"    => "20.10",
      "amount"   => "10.00000000",
      "datetime" => "2013-04-20 12:12:14"
    }
  }

  it { should be_a(OpenOrder) }
  it { should be_bid }
  its(:id) { should eq("2826860") }

  context "amount" do
    subject { open_order.amount }
    it { should be_a(Amount) }
    its(:value) { should eq(10) }
    its(:currency) { should eq("BTC") }
  end

  context "price" do
    subject { open_order.price }
    it { should be_a(Price) }
    its(:value) { should eq(20.1) }
    its(:currency) { should eq("USD") }
  end
end
