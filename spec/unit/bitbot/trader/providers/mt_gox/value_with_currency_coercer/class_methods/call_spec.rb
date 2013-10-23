require "spec_helper"

describe Providers::MtGox::ValueWithCurrencyCoercer, ".call" do
  subject { described_class.call(data) }

  context "when non-BTC currency" do
    let(:data) { {"value_int" => 123456789, "currency" => "EUR"} }

    its([:value]) { should be_big_decimal(1234.56789) }
    its([:currency]) { should eq("EUR") }
  end

  context "when BTC currency" do
    let(:data) { {"value_int" => 123456789, "currency" => "BTC"} }

    its([:value]) { should be_big_decimal(1.23456789) }
    its([:currency]) { should eq("BTC") }
  end
end
