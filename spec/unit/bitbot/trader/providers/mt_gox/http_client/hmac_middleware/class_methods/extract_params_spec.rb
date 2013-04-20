require "spec_helper"

describe Providers::MtGox::HttpClient::HmacMiddleware, ".extract_params" do
  subject { described_class.extract_params(env) }

  let(:env) { {request_headers: headers, url: url, body: body} }

  let(:headers) { {} }
  let(:url)     { mock(to_s: "https://data.mtgox.com/api/2/money/orders") }
  let(:body)    { {} }


  its([0]) { should eql(headers) }
  its([1]) { should eq("money/orders") }
  its([2]) { should eql(body) }
end
