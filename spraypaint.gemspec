# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{spraypaint}
  s.version = "0.9.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tom Ward"]
  s.date = %q{2009-03-28}
  s.email = %q{tom@popdog.net}
  s.files = ["about.yml", "generators", "lib", "MIT-LICENSE", "rails", "Rakefile", "syntax.rb", "test", "VERSION.yml", "rails/init.rb", "lib/spraypaint", "lib/spraypaint/behaviour", "lib/spraypaint/behaviour/discovery.rb", "lib/spraypaint/behaviour/manipulation.rb", "lib/spraypaint/behaviour/persistence.rb", "lib/spraypaint/behaviour.rb", "lib/spraypaint/default_sanitizer.rb", "lib/spraypaint/model", "lib/spraypaint/model/tag.rb", "lib/spraypaint/model/tagging.rb", "lib/spraypaint.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/tomafro/spraypaint}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Rails tagging in a can}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
