
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "email/delivery/version"

Gem::Specification.new do |spec|
  spec.name          = "email-delivery"
  spec.version       = Email::Delivery::VERSION
  spec.authors       = ["Pranava Swaroop"]
  spec.email         = ["stalin.pranava@gmail.com"]

  spec.summary       = %q{A service (Backend) that accepts the necessary information and sends emails.}
  spec.description   = %q{This gem is a service (Backend) that accepts the necessary information and sends emails. It provides an abstraction between two different e-mail sevice providers and quickly falls over to a working provider without affecting the users.}
  spec.homepage      = "https://www.lifemeasure.com"
  spec.license       = "MIT"


  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency "rest-client", '~> 2.0.2'

  spec.add_development_dependency "bundler", "~> 1.16.a"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-mocks", "~> 3.0"
  spec.add_development_dependency "dotenv", "~> 2.2.1"
  spec.add_development_dependency "byebug"
end
