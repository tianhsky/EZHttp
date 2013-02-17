require_relative '../lib/ez_http'

RSpec::Matchers.define :be_success_or_found do |expected|
  match do |actual|
    actual.start_with? "2" or actual.start_with? "3"
  end
end

RSpec::Matchers.define :be_not_found do |expected|
  match do |actual|
    actual == "404"
  end
end