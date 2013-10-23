require "spec_helper"

describe Request, "#client" do
  subject { described_class.new(client).client }

  let(:client) { double("client") }

  it { should eql(client) }
end
