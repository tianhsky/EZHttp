require_relative 'spec_helper'

describe EZHttp do

	describe "Send a Get request to http://www.google.com" do
		before :all do
			@response = EZHttp.Get("http://www.google.com")
		end
		
		it "should receive response with 2xx(success)/3xx(found) http status code" do
			@response.code.should be_success_or_found
		end
		
		it "should receive response with non-empty body" do
			@response.body.should_not be_empty
		end
	end
	
	describe "Send a Get request to http://www.google.com/non_existent_page" do
		before :all do
			@response = EZHttp.Get("http://www.google.com/non_existent_page")
		end
		
		it "should receive response with 404(not found) http status code" do
			@response.code.should be_not_found
		end
	end
		
end
