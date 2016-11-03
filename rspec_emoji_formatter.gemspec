# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec_emoji_formatter/version'

Gem::Specification.new do |spec|
  spec.name          = "rspec-emoji-formatter"
  spec.version       = RspecEmojiFormatter::VERSION
  spec.authors       = ["Alex Taylor"]
  spec.email         = ["alexmctaylorpants@gmail.com"]

  spec.summary       = %q{Add some 😀 to your tests!}
  spec.description   = %q{A formatter for RSpec that tracks the suite's progress with emojis. Because I wanted to.}
  spec.homepage      = "https://github.com/alextaylor000/rspec-emoji-formatter"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4"
end
