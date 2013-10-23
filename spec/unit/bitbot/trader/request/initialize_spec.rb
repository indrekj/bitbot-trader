require "spec_helper"

describe Request, "#initialize" do
  subject { described_class.new(client) }

  let(:client) { double("client") }

  it { should be_a(described_class) }
end
