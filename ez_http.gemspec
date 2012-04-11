Gem::Specification.new do |s|

  # Basic info
  s.name        = "ez_http"
  s.version     = "1.0.3"
  s.platform 	= Gem::Platform::RUBY
  s.date        = "2012-04-11"
  s.summary     = "Make http/https request easier"
  s.description = "A wrapper for ruby net/http, supports http/https, RESTful methods, certificate."
  s.authors     = ["Tianyu Huang"]
  s.email       = ["tianhsky@yahoo.com"]
  s.homepage    = "http://rubygems.org/gems/ez_http"
  
  # Dependencies
  # s.required_rubygems_version = ">= 1.3.6"

  # Files
  s.files       = `git ls-files`.split("\n")
  s.extra_rdoc_files   = ["README.md", "doc/index.html"]
  
end
