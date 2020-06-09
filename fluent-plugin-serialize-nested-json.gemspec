# coding: utf-8
Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-serialize-nested-json"
  spec.version       = "0.0.2"
  spec.authors       = ["Yagnesh Mistry"]
  spec.email         = ["ysh@live.in"]
  spec.description   = %q{Parser plugin that serializes nested JSON attributes}
  spec.summary       = %q{Parser plugin that serializes nested JSON attributes}
  spec.homepage      = "https://github.com/ysh7/fluent-plugin-serialize-nested-json"
  spec.license       = "BSD"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'fluentd', ['>= 0.14.0', '< 2']
  spec.add_runtime_dependency 'yajl-ruby', '~> 1.0'

  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'bundler', '~> 1.16'

  spec.add_development_dependency 'test-unit', ['~> 3.2']
  spec.add_development_dependency 'test-unit-rr', ['~> 1.0']
end
