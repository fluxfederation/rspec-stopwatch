require_relative './lib/rspec/stopwatch/version'

Gem::Specification.new do |s|
  s.name = 'rspec-stopwatch'
  s.version = RSpec::Stopwatch::VERSION
  s.license = 'MIT'

  s.summary = 'Ruby gem for writing performance specs'
  s.description = 'Provides a matcher that checks the run time of a block'
  s.homepage = 'https://git.powershop.co.nz/hjwylde/rspec-stopwatch-gem'

  s.authors = ['Henry J. Wylde']
  s.email = ['public@hjwylde.com']

  s.files = `git ls-files lib/`.split("\n")
  s.test_files = `git ls-files spec/`.split("\n")
  s.require_path = 'lib'

  s.add_dependency 'rspec', '~> 3'

  s.add_dependency 'activesupport', '~> 4'
end

