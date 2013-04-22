if ENV["COVERAGE"] == "true"
  require "simplecov"
  require "coveralls"

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]

  SimpleCov.start do
    add_filter "spec"
  end
end

require "bitbot/trader"

include Bitbot::Trader
require "devtools/spec_helper"
