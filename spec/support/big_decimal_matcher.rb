RSpec::Matchers.define :be_big_decimal do |expected|
  match do |actual|
    actual.is_a?(BigDecimal) && actual == BigDecimal(expected.to_s)
  end
end
