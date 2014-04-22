# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ids_please'

Gem::Specification.new do |s|
  s.name = "ids_please"
  s.version = IdsPlease::VERSION
  s.authors = ["gazay"]
  s.description = %q{Helps to get ids or screen names from links to social network accounts}
  s.summary = %q{Helps to get ids or screen names from links to social network accounts}
  s.licenses = ['MIT']
  s.email = "alex.gaziev@gmail.com"
  s.extra_rdoc_files = ["LICENSE"]
  s.rdoc_options = ["--charset=UTF-8"]
  s.homepage = "http://github.com/gazay/ids_please"
  s.require_paths = ["lib"]
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'byebug'
end
