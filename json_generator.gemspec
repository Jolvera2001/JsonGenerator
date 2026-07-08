Gem::Specification.new do |spec|
  spec.name = 'json_generator'
  spec.version = '0.1.0'
  spec.authors = ['Johan Olvera']
  spec.summary = 'Generate JSON files from a JSON defined schema'
  spec.files = Dir["src/**/*.rb"]
  spec.executables = ["jgen"]
  spec.bindir = "bin"
  spec.required_ruby_version = '>= 4.0.0'
end