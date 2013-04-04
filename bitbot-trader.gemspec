lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "bitbot/trader/version"

Gem::Specification.new do |spec|
  spec.name          = "bitbot-trader"
  spec.version       = Bitbot::Trader::VERSION
  spec.authors       = ["Indrek Juhkam"]
  spec.email         = ["indrek@urgas.eu"]
  spec.description   = %q{}
  spec.summary       = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "virtus"
  spec.add_dependency "httparty", "~> 0.10"
end
