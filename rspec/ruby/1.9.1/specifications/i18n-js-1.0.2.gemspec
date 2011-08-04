# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{i18n-js}
  s.version = "1.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nando Vieira"]
  s.date = %q{2011-04-13}
  s.description = %q{It's a small library to provide the Rails I18n translations on the Javascript.}
  s.email = ["fnando.vieira@gmail.com"]
  s.files = ["spec/i18n_spec.js", "spec/i18n_spec.rb", "spec/resources/custom_path.yml", "spec/resources/default.yml", "spec/resources/locales.yml", "spec/resources/multiple_conditions.yml", "spec/resources/multiple_files.yml", "spec/resources/no_scope.yml", "spec/resources/simple_scope.yml", "spec/spec_helper.rb"]
  s.homepage = %q{http://rubygems.org/gems/i18n-js}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{It's a small library to provide the Rails I18n translations on the Javascript.}
  s.test_files = ["spec/i18n_spec.js", "spec/i18n_spec.rb", "spec/resources/custom_path.yml", "spec/resources/default.yml", "spec/resources/locales.yml", "spec/resources/multiple_conditions.yml", "spec/resources/multiple_files.yml", "spec/resources/no_scope.yml", "spec/resources/simple_scope.yml", "spec/spec_helper.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<i18n>, [">= 0"])
      s.add_development_dependency(%q<fakeweb>, [">= 0"])
      s.add_development_dependency(%q<activesupport>, ["~> 3.0.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.5.0"])
      s.add_development_dependency(%q<ruby-debug19>, [">= 0"])
      s.add_development_dependency(%q<spec-js>, ["~> 0.1.0.beta.0"])
    else
      s.add_dependency(%q<i18n>, [">= 0"])
      s.add_dependency(%q<fakeweb>, [">= 0"])
      s.add_dependency(%q<activesupport>, ["~> 3.0.0"])
      s.add_dependency(%q<rspec>, ["~> 2.5.0"])
      s.add_dependency(%q<ruby-debug19>, [">= 0"])
      s.add_dependency(%q<spec-js>, ["~> 0.1.0.beta.0"])
    end
  else
    s.add_dependency(%q<i18n>, [">= 0"])
    s.add_dependency(%q<fakeweb>, [">= 0"])
    s.add_dependency(%q<activesupport>, ["~> 3.0.0"])
    s.add_dependency(%q<rspec>, ["~> 2.5.0"])
    s.add_dependency(%q<ruby-debug19>, [">= 0"])
    s.add_dependency(%q<spec-js>, ["~> 0.1.0.beta.0"])
  end
end
