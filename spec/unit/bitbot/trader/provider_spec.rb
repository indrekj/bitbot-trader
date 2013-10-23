require "spec_helper"

describe Provider do
  describe "#client" do
    subject { klass.new(client).client }

    let(:klass) {
      Class.new(described_class) {
        def initialize(client)
          @client = client
        end
      }
    }
    let(:client) { double }

    it { should be(client) }
  end
end
