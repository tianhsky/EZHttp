lib = File.expand_path("../lib/", __FILE__)
$:.unshift lib unless $:.include?(lib)

require "ez_http/version"

Gem::Specification.new do |s|

  # Basic info
  s.name        = "ez_http"
  s.version     = ::EZHttp::VERSION
  s.platform 	= Gem::Platform::RUBY
  s.date        = "2012-04-15"
  s.summary     = "Make http/https requests easier"
  s.description = "A wrapper for ruby net/http, supports http/https, RESTful methods, headers, certificate and file uploads"
  s.authors     = ["Tianyu Huang"]
  s.email       = ["tianhsky@yahoo.com"]
  s.homepage    = "http://rubygems.org/gems/ez_http"
  
  # Dependencies
  #s.required_rubygems_version = ">= 1.8.22"
  s.add_dependency "json", ">= 1.6.6"

  # Files
  s.files       = `git ls-files`.split("\n")
  s.require_paths = ["lib"]
  s.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.extra_rdoc_files   = ["README.md", "doc/index.html"]
  
end
