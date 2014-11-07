require 'analytics/version'

Gem::Specification.new do |s|
  s.name        = 'analytics'
  s.version     = Analytics::VERSION
  s.date        = '2014-11-05'
  s.summary     = 'Analytics'
  s.description = 'A simple analytics gem'
  s.authors     = ['Adam Gross']
  s.email       = 'agross@synergydatasystems.com'
  s.files       = ['lib/analytics.rb']
  s.license     = 'MIT'

  s.add_development_dependency 'rspec', '~>3.1.0'
end
