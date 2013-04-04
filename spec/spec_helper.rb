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

require "devtools/spec_helper"
require "bitbot/trader"

Dir[File.dirname(__FILE__) + "/shared/**/*.rb"].each {|f| require f}
Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}

include Bitbot::Trader
