require "spec_helper"

describe Providers::MtGox::PriceWriter, ".parse" do
  subject { described_class.parse(hash) }

  let(:hash) { {"value_int" => 12345678, "currency" => "USD"} }

  its([:value]) { should be_big_decimal(123.45678) }
  its([:currency]) { should eq("USD") }
end
