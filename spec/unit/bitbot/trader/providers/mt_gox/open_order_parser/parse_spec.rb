require "spec_helper"

describe Providers::MtGox::OpenOrderParser, "#parse" do
  subject(:order) { described_class.new(data).parse }

  let(:data) {
    {
      "oid"              => "7c6d2237-52fb-4af4-b6ec-75e42f50c331",
      "currency"         => "USD",
      "item"             => "BTC",
      "type"             => "bid",
      "status"           => "open",
      "date"             => 1365886868,
      "priority"         => "1365886868485232",
      "amount" => {
        "value_int" => "3500000000",
        "currency"  => "BTC"
      },
      "effective_amount" => {
        "value_int" => "3500000000",
        "currency"  => "BTC"
      },
      "price" => {
        "value_int" => "3010000",
        "currency"  => "USD"
      }
    }
  }

  its(:id) { should eq("7c6d2237-52fb-4af4-b6ec-75e42f50c331") }
  its(:amount) { should eq(35) }

  context "price" do
    subject { order.price }
    it { should be_a(Price) }
    its(:value) { should eq(30.1) }
    its(:currency) { should eq("USD") }
  end
end
