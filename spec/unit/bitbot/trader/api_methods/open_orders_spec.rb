require "spec_helper"

describe ApiMethods, "#open_orders" do
  subject { object.open_orders }

  let(:object)        { provider_double.new(client) }
  let(:client)        { double("client") }

  let(:request_class) { Class.new }
  let(:request)       { double("request") }

  before do
    object.class.const_set("OpenOrdersRequest", request_class)
    request_class.stub(:new).with(client) { request }
  end

  it "calls request class" do
    request.should_receive(:call)
    subject
  end
end
