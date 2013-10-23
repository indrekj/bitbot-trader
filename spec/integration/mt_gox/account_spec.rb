require "spec_helper"

describe Providers::MtGox, "#account" do
  let(:result) {
    %!{"result":"success","data":{"Login":"johndoe","Index":"193629","Id":"9b46b62e-4fd3-4cfa-9445-96f49dee846c","Rights":["get_info"],"Language":"en_US","Created":"2012-08-30 21:35:49","Last_Login":"2013-04-22 14:16:11","Wallets":{"BTC":{"Balance":{"value":"0.00000000","value_int":"0","display":"0.00000000\u00a0BTC","display_short":"0.00\u00a0BTC","currency":"BTC"},"Operations":164,"Daily_Withdraw_Limit":{"value":"100.00000000","value_int":"10000000000","display":"100.00000000\u00a0BTC","display_short":"100.00\u00a0BTC","currency":"BTC"},"Monthly_Withdraw_Limit":null,"Max_Withdraw":{"value":"100.00000000","value_int":"10000000000","display":"100.00000000\u00a0BTC","display_short":"100.00\u00a0BTC","currency":"BTC"},"Open_Orders":{"value":"0.00000000","value_int":"0","display":"0.00000000\u00a0BTC","display_short":"0.00\u00a0BTC","currency":"BTC"}},"EUR":{"Balance":{"value":"0.12314","value_int":"12314","display":"0.12314\u00a0\u20ac","display_short":"0.12\u00a0\u20ac","currency":"EUR"},"Operations":3,"Daily_Withdraw_Limit":{"value":"1000.00000","value_int":"100000000","display":"1,000.00000\u00a0\u20ac","display_short":"1,000.00\u00a0\u20ac","currency":"EUR"},"Monthly_Withdraw_Limit":{"value":"10000.00000","value_int":"1000000000","display":"10,000.00000\u00a0\u20ac","display_short":"10,000.00\u00a0\u20ac","currency":"EUR"},"Max_Withdraw":{"value":"1000.00000","value_int":"100000000","display":"1,000.00000\u00a0\u20ac","display_short":"1,000.00\u00a0\u20ac","currency":"EUR"},"Open_Orders":{"value":"0.00000","value_int":"0","display":"0.00000\u00a0\u20ac","display_short":"0.00\u00a0\u20ac","currency":"EUR"}},"USD":{"Balance":{"value":"3533.02728","value_int":"353302728","display":"$3,533.02728","display_short":"$3,533.03","currency":"USD"},"Operations":155,"Daily_Withdraw_Limit":{"value":"1000.00000","value_int":"100000000","display":"$1,000.00000","display_short":"$1,000.00","currency":"USD"},"Monthly_Withdraw_Limit":{"value":"10000.00000","value_int":"1000000000","display":"$10,000.00000","display_short":"$10,000.00","currency":"USD"},"Max_Withdraw":{"value":"1000.00000","value_int":"100000000","display":"$1,000.00000","display_short":"$1,000.00","currency":"USD"},"Open_Orders":{"value":"1053.50000","value_int":"105350000","display":"$1,053.50000","display_short":"$1,053.50","currency":"USD"}}},"Monthly_Volume":{"value":"413.48602792","value_int":"41348602792","display":"413.48602792\u00a0BTC","display_short":"413.49\u00a0BTC","currency":"BTC"},"Trade_Fee":0.53}}!
  }

  let(:provider) { described_class.new(options, client) }
  let(:options)  { {key: "double", secret: "double"} }

  let(:client) { described_class::HttpClient.new(connection) }
  let(:connection) { mock_connection("/money/info", result) }

  it "parses account info" do
    account = provider.account

    expect(account.fee).to eq(0.53)

    usd_wallet = account.wallet("USD")
    expect(usd_wallet.balance).to eq(3533.02728)

    eur_wallet = account.wallet("EUR")
    expect(eur_wallet.balance).to eq(0.12314)

    btc_wallet = account.wallet("BTC")
    expect(btc_wallet.balance).to eq(0)
  end
end
