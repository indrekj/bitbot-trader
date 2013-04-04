require "spec_helper"

describe HttpRequest, ".post" do
  subject { described_class.post(path, body) }

  let(:path) { "http://example.com" }
  let(:body) { {foo: "bar"} }

  let(:parsed_response) { mock("parsed response") }
  let(:response)        { stub(parsed_response: parsed_response) }

  it "makes post request" do
    HTTParty.stub(:post).
      with(path, body: body).
      and_return(response)

    expect(subject).to eq(parsed_response)
  end
end
