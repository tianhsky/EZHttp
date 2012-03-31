# EZHttp

A helper wrapper around net/http, supports http/https(with/without certificate), post/get requests, one method call does everything.

## How to use it
	response = EZHttp.Send("https://www.example.com:83/api", "post", {"key1"=>"value1"}, "application/json", nil)
	puts response.body

## Installation

Add the following line to your "Gemfile"
gem "ez_http"
then execute bundle install

See here for more details:
RubyGem: [http://rubygems.org/gems/ez_http](http://rubygems.org/gems/ez_htt "EZHttp RubyGem Page")

## Author

Tianyu Huang
