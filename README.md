
# EZHttp

[![Build Status](https://travis-ci.org/tianhsky/EZHttp.png?branch=master)](https://travis-ci.org/tianhsky/EZHttp)
[![Dependency Status](https://gemnasium.com/tianhsky/EZHttp.png)](https://gemnasium.com/tianhsky/EZHttp)

A wrapper for ruby net/http, supports http/https, RESTful methods, headers, certificate and file uploads.     
It supports both command line and ruby code.   

## How to use it

### Command Line

Send with query string

	ezhttp \
	--url "https://api.twitter.com/1/followers/ids.json" \
	--method "get" \
	--data "cursor=-1&screen_name=twitterapi"

Send with query string

	ezhttp \
	--url "https://api.twitter.com/1/followers/ids.json&cursor=-1&screen_name=twitterapi" \
	--method "get" 

Send with json

	ezhttp \
	--url 'http://127.0.0.1:3000/file/upload_file' \
	--data '{"name":{"fn":"xxx","ln":"xxx"}}' \
	--method 'post' \
	--type 'application/json' 

Send with header

	ezhttp \
	--url 'https://api.twitter.com/oauth/request_token' \
	--method 'post' \	
	--header 'Authorization: OAuth oauth_nonce="K7ny27JTpKVsTgdyLdDfmQQWVLERj2zAK5BslRsqyw", oauth_callback="http%3A%2F%2Fmyapp.com%3A3005%2Ftwitter%2Fprocess_callback", oauth_signature_method="HMAC-SHA1", oauth_timestamp="1300228849", oauth_consumer_key="OqEqJeafRSF11jBMStrZz", oauth_signature="Pc%2BMLdv028fxCErFyi8KXFM%2BddU%3D", oauth_version="1.0"'


Upload file

	ezhttp \
	--url 'http://127.0.0.1:3000/file/upload_file' \
	--files 'path_to_file.png'

Upload multiple files with header

	ezhttp \
	--url 'http://127.0.0.1:3000/file/upload_file' \
	--files 'path_to_file1.zip','path_to_file2.jpg' \
	--header 'authorization:Basic Zvsdwegbdgegsdv0xvsd='

### Ruby

Send with encoded query string as data

	# Post request
	response = EZHttp.Post("https://www.example.com:83/api",
				"user_id=12345&token=sdfwD12g%7Ecc")

	# Get request
	response = EZHttp.Get("http://www.example.com/api",
				"user_id=12345&token=sdfwD12g%7Ecc")

	# OR
	response = EZHttp.Get("http://www.example.com/api?user_id=12345&token=sdfwD12g%7Ecc")

Send with hash as data
 
	# Post request
	response = EZHttp.Post("https://www.example.com:83/api",
				{"name1"=>"value", "name2" => "value2"})

	# Put request
	response = EZHttp.Put("https://www.example.com:83/api",
				{"name1"=>"value", "name2" => "value2"})

Send with extra headers

	response = EZHttp.Post("https://www.example.com:83/api",
				"user_id=12345&token=sdfwD12g%7Ecc",
				nil,
				[
					"authentication:oAuth username=xxx&password=xxx",
					"other_header:other_values"
				])

Send with pem certificate

	response = EZHttp.Delete("https://www.example.com:83/api",
				{"user_id"=>"12345"},
				"application/json",
				nil,
				"/path_to_cert.pem")

Upload file(s)

	# 
	files = []
	file = File.open("path_to_file.extension", "rb")
	files.push({"name" => File.basename(file), "content" => file.read})
	file.close

	# simply upload file
	response = EZHttp.Upload("https://www.example.com:83/api",
				files)

	# upload file with headers
	response = EZHttp.Upload("https://www.example.com:83/api",
				files,
				["authorization:Basic Zvsdwegbdgegsdv0xvsd="])

Display response

	puts response.body

## Installation

Add the following line to rails "Gemfile"    
  
	gem "ez_http"
  
then execute   

	$ bundle install  


See [http://rubygems.org/gems/ez_http](http://rubygems.org/gems/ez_http "EZHttp RubyGem Page") for more details   

## Authors

Tianyu Huang

