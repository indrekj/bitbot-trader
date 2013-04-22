require "spec_helper"

describe Providers::MtGox::ValueWithCurrency, ".parse" do
  subject { described_class.parse(data, 3) }

  let(:data) { {"value_int" => 12345, "currency" => "EUR"} }

  its([:value]) { should be_big_decimal(12.345) }
  its([:currency]) { should eq("EUR") }
end
