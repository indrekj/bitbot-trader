require "spec_helper"

describe ApiMethods, "#account" do
  subject { object.account }

  let(:object)        { provider_mock.new(client) }
  let(:client)        { mock("client") }

  let(:request_class) { Class.new }
  let(:request)       { mock("request") }

  before do
    object.class.const_set("AccountInfoRequest", request_class)
    request_class.stub(:new).with(client) { request }
  end

  it "calls request class" do
    request.should_receive(:call)
    subject
  end
end
