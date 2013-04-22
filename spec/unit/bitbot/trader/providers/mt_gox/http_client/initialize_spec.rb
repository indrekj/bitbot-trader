require "spec_helper"

describe Providers::MtGox::HttpClient, "#initialize" do
  let(:connection) { mock("connection") }

  context "with default nonce generator" do
    subject { described_class.new(connection) }

    it { should be_a(described_class) }
  end


  context "with custom nonce generator" do
    subject { described_class.new(connection, nonce_generator) }

    let(:nonce_generator) { mock("nonce generator") }

    it { should be_a(described_class) }
  end
end
