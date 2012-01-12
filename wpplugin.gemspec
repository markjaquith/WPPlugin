# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'wpplugin.rb'

Gem::Specification.new do |s|
  s.name        = "wpplugin"
  s.version     = WPPlugin::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Mark Jaquith"]
  s.email       = ["mark@jaquith.me"]
  s.homepage    = "http://github.com/markjaquith/WPPlugin"
  s.summary     = %q{Command line tool for updating WordPress plugins}
  s.description = %q{WPPlugin is a command line tool that updates WordPress plugins. Great for WordPress installs that live in a Git repository.}
  s.has_rdoc = false

  # s.required_rubygems_version = ">= 1.3.6"
  # s.rubyforge_project         = "wpplugin"

  s.files              = `git ls-files`.split("\n")
  # s.test_files         = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables        = %w(wpplugin)
  s.require_paths      = ["lib"]
end
