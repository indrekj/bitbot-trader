require "spec_helper"

describe Providers::Bitstamp, "#initialize" do
  subject { described_class.new(username: username, password: password) }

  let(:username) { "23443" }
  let(:password) { "TopSecret" }

  it { should be_a(described_class) }
  its(:username) { should eq(username) }
  its(:password) { should eq(password) }
end
