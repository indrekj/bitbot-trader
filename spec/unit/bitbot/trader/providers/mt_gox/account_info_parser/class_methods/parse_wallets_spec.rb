require "spec_helper"

describe Providers::MtGox::AccountInfoParser, ".parse_wallets" do
  subject { described_class.parse_wallets(raw_wallets) }

  let(:raw_wallets) {
    {"EUR" => {"Balance" => balance}}
  }
  let(:balance) { double }

  it "delegates each wallet balance to ValueWithCurrency" do
    Providers::MtGox::ValueWithCurrencyCoercer.
      should_receive(:call).
      with(balance)
    subject
  end
end
