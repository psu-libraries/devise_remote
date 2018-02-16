
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'devise_remote/version'

Gem::Specification.new do |spec|
  spec.name          = 'devise_remote'
  spec.version       = DeviseRemote::VERSION
  spec.authors       = ['Carolyn Cole, Adam Wead']
  spec.email         = ['cam156@psu.edu, agw13@psu.edu']

  spec.summary       = 'Authentication using Devise with remote services such as LDAP and Shibboleth'
  spec.description   = 'Allows Devise to authenticate users from central-authentication services like LDAP and Shibboleth.'
  spec.homepage      = 'https://github.com/psu-libraries/devise_remote'

  spec.licenses      = ['Apache-2.0']

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'devise', '~> 4.0'
  spec.add_dependency 'rails', '~> 5.0'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.50.0'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.17.1'
  spec.add_development_dependency 'byebug', '~> 10.0'
  spec.add_development_dependency 'pry-byebug', '~> 3.5'
  spec.add_development_dependency 'sqlite3', '~> 1.3'
end
