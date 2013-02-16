require 'spec_helper'

describe EZHttp do

	describe "Send a Get request to http://www.google.com" do
		before :all do
			@response = EZHttp.Get("http://www.google.com")
		end
		
		it "should receive response with 200 http status code" do
			@response.code.should eql "200"
		end
		
		it "should receive response with non-empty body" do
			@response.body.should_not be_empty
		end
	end
	
	describe "Send a Get request to http://www.google.com/non_exist_page" do
		before :all do
			@response = EZHttp.Get("http://www.google.com/non_exist_page")
		end
		
		it "should receive response with 404 http status code" do
			@response.code.should eql "404"
		end
	end
		
end
