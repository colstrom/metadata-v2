Gem::Specification.new do |gem|
  gem.name        = 'metadata-v2'
  gem.version     = `git describe --tags --abbrev=0`.chomp + '.pre'
  gem.licenses    = 'MIT'
  gem.authors     = ['Chris Olstrom']
  gem.email       = 'chris@olstrom.com'
  gem.homepage    = 'https://github.com/colstrom/metadata-v2'
  gem.summary     = 'A Ruby Interface to the Joyent Metadata Protocol (Version 2)'

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  gem.require_paths = ['lib']
end
