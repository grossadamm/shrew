lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'shrew/version'

Gem::Specification.new do |s|
  s.name          = 'shrew'
  s.version       = Shrew::VERSION
  s.summary       = 'Shrew'
  s.description   = 'A simple shrew gem'
  s.authors       = ['Adam Gross']
  s.email         = 'agross@synergydatasystems.com'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ['lib']
  s.license       = 'MIT'

  s.add_dependency 'activesupport', '>=4.0.0'
  s.add_dependency 'activerecord', '>=4.0.0'

  s.add_development_dependency 'rspec', '~>3.1.0'
  s.add_development_dependency 'rspec-rails', '~>3.1.0'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'database_cleaner'
end
