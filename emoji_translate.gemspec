# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "emoji_translate/version"

Gem::Specification.new do |spec|
  spec.name          = "emoji_translate"
  spec.version       = EmojiTranslate::VERSION
  spec.authors       = ["Vyacheslav Pukhanov"]
  spec.email         = ["vyacheslav.pukhanov@gmail.com"]

  spec.summary       = %q{Allows you to 📚 translate text to ✨ emoji ✨}
  spec.homepage      = "https://github.com/vpukhanov/emoji_translate"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "json", "~> 2.1"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
