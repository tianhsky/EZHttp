# EZHttp

A wrapper for ruby net/http, supports http/https, RESTful methods, certificate.

## How to use it

send a post request to specified url with the json as data

	response = EZHttp.Send("https://www.example.com:83/api",
				{"key1"=>"value1"})

send a put request to specified url with encoded query string params as data

	response = EZHttp.Send("https://www.example.com:83/api",
				"key1=I%27ll+do&key2=He%27+do",
				"put",
				"application/x-www-form-urlencoded")

specify extra headers

	response = EZHttp.Send("https://www.example.com:83/api",
				{"key1"=>"value1"},
				"post",
				{"content-type" => "application/json", "authentication" => "xxxx"})

use certificate

	response = EZHttp.Send("https://www.example.com:83/api",
				{"key1"=>"value1"},
				"post",
				"application/json",
				"/path_to_cert.pem")

display raw response

	puts response.body

## Installation

Add the following line to rails "Gemfile"    
  
	gem "ez_http"
  
then execute   

	$ bundle install  


See [http://rubygems.org/gems/ez_http](http://rubygems.org/gems/ez_http "EZHttp RubyGem Page") for more details   

## Authors

Tianyu Huang

