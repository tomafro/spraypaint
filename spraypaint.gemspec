# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{spraypaint}
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tom Ward (tomafro)"]
  s.date = %q{2009-03-31}
  s.email = %q{tom@popdog.net}
  s.files = [".gitignore", "CHANGELOG", "MIT-LICENSE", "Rakefile", "TODO", "VERSION.yml", "about.yml", "generators/spraypaint_migration/spraypaint_migration_generator.rb", "generators/spraypaint_migration/templates/spraypaint_migration.rb", "lib/spraypaint.rb", "lib/spraypaint/behaviour.rb", "lib/spraypaint/behaviour/discovery.rb", "lib/spraypaint/behaviour/manipulation.rb", "lib/spraypaint/behaviour/persistence.rb", "lib/spraypaint/default_sanitizer.rb", "lib/spraypaint/model/tag.rb", "lib/spraypaint/model/tagging.rb", "lib/spraypaint/sanitizer.rb", "rails/init.rb", "spraypaint.gemspec", "test/app/controllers/application.rb", "test/app/controllers/application_controller.rb", "test/app/models/account.rb", "test/app/models/book.rb", "test/app/models/film.rb", "test/config/boot.rb", "test/config/database.yml", "test/config/environment.rb", "test/config/environments/development.rb", "test/config/environments/test.rb", "test/config/routes.rb", "test/db/schema.rb", "test/script/console", "test/spec/default_sanitizer_spec.rb", "test/spec/models/tag_spec.rb", "test/spec/models/tagging_spec.rb", "test/spec/spec_helper.rb", "test/spec/spraypaint_spec.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/tomafro/spraypaint}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Simple tagging in a can}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
