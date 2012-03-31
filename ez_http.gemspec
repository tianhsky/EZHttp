Gem::Specification.new do |s|
  s.name        = 'ez_http'
  s.version     = '1.0.0'
  s.platform 	= Gem::Platform::RUBY
  s.date        = '2012-03-30'
  s.summary     = "Make http/https request easier"
  s.description = "A helper wrapper around net/http, supports http/https(with/without certificate), post/get requests, one method call does everything."
  s.authors     = ["Tianyu Huang"]
  s.email       = 'tianhsky@yahoo.com'
  s.files       = `git ls-files`.split("\n")
  s.homepage    = 'http://rubygems.org/gems/ez_http'
  s.extra_rdoc_files   = ["doc/index.html"]

  s.required_rubygems_version = ">= 1.3.6"
  s.add_development_dependency "openssl"
  s.add_development_dependency "net/http"
  s.add_development_dependency "uri"
end