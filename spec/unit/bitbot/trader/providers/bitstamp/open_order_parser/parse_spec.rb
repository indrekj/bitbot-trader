require "spec_helper"

describe Providers::Bitstamp::OpenOrderParser, "#parse" do
  subject(:open_order) { parser.parse }

  let(:parser)  { described_class.new(options) }
  let(:options) { {id: 1, price: 2.34, amount: 32} }

  it { should be_a(OpenOrder) }
  its(:id) { should eq("1") }
  its(:amount) { should eq(32) }

  context "price" do
    subject { open_order.price }
    it { should be_a(Price) }
    its(:value) { should eq(2.34) }
    its(:currency) { should eq("USD") }
  end
end
