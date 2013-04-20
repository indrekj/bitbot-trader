require "spec_helper"

describe Providers::MtGox, "#open_orders" do
  let(:result) {
    %!{"result":"success","data":[{"oid":"7c6d2237-52fb-4af4-b6ec-75e42f50c331","currency":"USD","item":"BTC","type":"bid","amount":{"value":"35.00000000","value_int":"3500000000","display":"35.00000000\u00a0BTC","display_short":"35.00\u00a0BTC","currency":"BTC"},"effective_amount":{"value":"35.00000000","value_int":"3500000000","display":"35.00000000\u00a0BTC","display_short":"35.00\u00a0BTC","currency":"BTC"},"price":{"value":"30.10000","value_int":"3010000","display":"$30.10000","display_short":"$30.10","currency":"USD"},"status":"open","date":1365886868,"priority":"1365886868485232","actions":[]}]}!
  }

  let(:provider) { described_class.new(options, client) }
  let(:options)  { {key: "mock", secret: "mock"} }

  let(:client) { described_class::HttpClient.new(connection) }
  let(:connection) { mock_connection("/money/orders", result) }

  it "parses open orders" do
    open_orders = provider.open_orders
    expect(open_orders.size).to be(1)

    order = open_orders.first
    expect(order.id).to eq("7c6d2237-52fb-4af4-b6ec-75e42f50c331")
    expect(order.amount).to eq(35)

    price = order.price
    expect(price.value).to eq(30.1)
    expect(price.currency).to eq("USD")
  end
end
