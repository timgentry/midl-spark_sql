# frozen_string_literal: true

require_relative 'lib/midl/spark_sql/version'

Gem::Specification.new do |spec|
  spec.name          = 'midl-spark_sql'
  spec.version       = Midl::SparkSql::VERSION
  spec.authors       = ['Tim Gentry']
  spec.email         = ['timgentry@users.noreply.github.com']

  spec.summary       = 'MiDL Spark SQL'
  spec.description   = 'MiDL Intermediate Representation Spark SQL Adapter'
  spec.homepage      = 'https://github.com/timgentry/midl-spark_sql'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.2')

  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/timgentry/midl-spark_sql'
  spec.metadata['changelog_uri'] = 'https://github.com/timgentry/midl-spark_sql/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'activerecord'
  spec.add_dependency 'midl'
  spec.add_dependency 'sqlite3'

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
