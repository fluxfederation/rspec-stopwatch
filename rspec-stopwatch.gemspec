require_relative './lib/rspec/stopwatch/version'

Gem::Specification.new do |s|
  s.name = 'rspec-stopwatch'
  s.version = RSpec::Stopwatch::VERSION
  s.license = 'MIT'

  s.summary = 'RSpec matcher to help with writing performance specs'
  s.description = 'Provides a matcher that checks the run time of a block and expects it to be under a certain time'
  s.homepage = 'https://github.com/powershop/rspec-stopwatch'

  s.authors = ['Henry J. Wylde']
  s.email = ['hjwylde@powershop.co.nz']

  s.files = `git ls-files lib/`.split("\n")
  s.test_files = `git ls-files spec/`.split("\n")
  s.require_path = 'lib'

  s.add_dependency 'rspec', '~> 3'
  s.add_dependency 'activesupport', '~> 4'
end

