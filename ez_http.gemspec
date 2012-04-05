Gem::Specification.new do |s|

  # Basic info
  s.name        = "ez_http"
  s.version     = "1.0.2"
  s.platform 	= Gem::Platform::RUBY
  s.date        = "2012-04-04"
  s.summary     = "Make http/https request easier"
  s.description = "A helper wrapper around net/http, supports http/https(with/without certificate), post/get requests, one method call does everything."
  s.authors     = ["Tianyu Huang"]
  s.email       = ["tianhsky@yahoo.com"]
  s.homepage    = "http://rubygems.org/gems/ez_http"
  
  # Dependencies
  # s.required_rubygems_version = ">= 1.3.6"

  # Files
  s.files       = `git ls-files`.split("\n")
  s.extra_rdoc_files   = ["README.md", "doc/index.html"]
  
end
