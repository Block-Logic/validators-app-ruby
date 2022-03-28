# frozen_string_literal: true

require_relative "lib/solana_validators_client/version"

Gem::Specification.new do |spec|
  spec.name          = "solana_validators_client"
  spec.version       = SolanaValidatorsClientVersion::VERSION
  spec.authors       = ["BlockLogic team"]
  spec.email         = ["maciej.kocyla@polcode.net"]

  spec.summary       = "Ruby wrapper for validators.app API endpoints" 
  spec.homepage      = "https://github.com/Block-Logic/validators-app-ruby"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Block-Logic/validators-app-ruby"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "~> 0.20"

  spec.add_development_dependency "dotenv", "~> 2.7.6"
  spec.add_development_dependency "minitest-vcr", "~> 1.4.0"
  spec.add_development_dependency "webmock", "~> 3.14.0"

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
