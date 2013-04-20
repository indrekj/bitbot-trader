require "spec_helper"

describe Providers::MtGox::HttpClient::HmacMiddleware, "#call" do
  subject { described_class.new(app, options).call(env) }

  let(:app)     { mock }
  let(:options) { {key: "KEY", secret: "c2VjcmV0" } }
  let(:env)     { mock }

  let(:headers) { {} }
  let(:path)    { "money/orders" }
  let(:body)    { "nonce=123" }

  before do
    described_class.stub(:extract_params).with(env).
      and_return([headers, path, body])
    app.stub(:call)
  end

  it "forwards environment to app" do
    app.should_receive(:call).with(env)
    subject
  end

  it "adds Rest-Key to headers" do
    subject
    expect(headers["Rest-Key"]).to eq("KEY")
  end

  it "adds Rest-Sign to headers" do
    subject
    expect(headers["Rest-Sign"]).to eq("Jd1OnkDAy0mkSCq1+w3Aiyeotw+lGF0GOR3tp5Ch1DMkyRW9QJ4FrmyFZIoee5itfAOnq9sRslqPd3n3UKw64A==")
  end

  it "adds User-Agent to headers" do
    subject
    expect(headers["User-Agent"]).to eq("bitbot-trader")
  end
end
