require "spec_helper"

describe Providers::MtGox::OpenOrderParser, "#parse" do
  subject(:order) { described_class.new(data).parse }

  context "when bid" do
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

    it { should be_a(OpenOrder) }
    it { should be_bid }
    its(:id) { should eq("7c6d2237-52fb-4af4-b6ec-75e42f50c331") }

    context "amount" do
      subject { order.amount }
      it { should be_a(Amount) }
      its(:value) { should eq(35) }
      its(:currency) { should eq("BTC") }
    end

    context "price" do
      subject { order.price }
      it { should be_a(Price) }
      its(:value) { should eq(30.1) }
      its(:currency) { should eq("USD") }
    end
  end

  context "when ask" do
    let(:data) {
      {
        "oid"      => "69dbeefc-1911-4b0e-b60e-b3948b50a880",
        "currency" => "USD",
        "item"     => "BTC",
        "type"     => "ask",
        "status"   => "invalid",
        "date"     => 1366640210,
        "priority" => "1366640210930103",
        "amount" => {
          "value_int" => "1220000000",
          "currency"  => "BTC"
        },
        "effective_amount" => {
          "value_int" => "1220000000",
          "currency"  => "BTC"
        },
        "price" => {
          "value_int" => "12061185",
          "currency"  => "USD"
        }
      }
    }

    it { should be_a(OpenOrder) }
    it { should be_ask }
    its(:id) { should eq("69dbeefc-1911-4b0e-b60e-b3948b50a880") }

    context "amount" do
      subject { order.amount }
      it { should be_a(Amount) }
      its(:value) { should eq(12.2) }
      its(:currency) { should eq("BTC") }
    end

    context "price" do
      subject { order.price }
      it { should be_a(Price) }
      its(:value) { should eq(120.61185) }
      its(:currency) { should eq("USD") }
    end
  end
end
