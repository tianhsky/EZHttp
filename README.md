# EZHttp

A helper wrapper around net/http, supports http/https(with/without certificate), post/get requests, one method call does everything.

## How to use it

	# default it will send a post request to specified url with the hash object as json
	response = EZHttp.Send("https://www.example.com:83/api", {"key1"=>"value1"})
	# or
	response = EZHttp.Send("https://www.example.com:83/api", {"key1"=>"value1"}, "post", "application/json")
	# or with certificate
	response = EZHttp.Send("https://www.example.com:83/api", {"key1"=>"value1"}, "post", "application/json", "/path_to_cert.pem")
	
	puts response.body

## Installation

Add the following line to your "Gemfile"
	gem "ez_http"
then execute bundle install  

See here for more details:  
[http://rubygems.org/gems/ez_http](http://rubygems.org/gems/ez_htt "EZHttp RubyGem Page")

## Author

Tianyu Huang
