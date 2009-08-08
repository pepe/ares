# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ares}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Josef Pospisil"]
  s.date = %q{2009-08-07}
  s.description = %q{Simple library for querying Ares system in Czech republic with translation of labels.}
  s.email = %q{pepe@gravastar.cz}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "README.rdoc",
     "Rakefile",
     "lib/ares.rb",
     "spec/ares_spec.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/pepe/ares}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Simple ruby wrapper for Czech Ares service}
  s.test_files = [
    "spec/ares_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 1.4.0"])
    else
      s.add_dependency(%q<activesupport>, [">= 1.4.0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 1.4.0"])
  end
end
