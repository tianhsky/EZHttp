require "net/http"
require "uri"
require "openssl"

# A helper wrapper around net/http, supports http/https(with/without certificate), post/get requests, one method call does everything.
#  How to use:
#   response = EZHttp.Send("https://www.example.com:83/api", "post", {"key1"=>"value1"}, "application/json", nil)
#   puts response.body
# 
# @author Tianyu Huang [tianhsky@yahoo.com]
# 
module EZHttp

  # Send request to specified url and will return responses
  # @param [String] url: to send request to
  # @param [String] method: is "get" or "post", if nil default is "post"
  # @param [Hash] data: to send
  # @param [String] content_type: if nil default is "application/json" 
  # @param [String] cert_path: to the certificate file, set nil if none
  # @return [Net::HTTPResponse] response from remote server, example to access its fields: response.body, response.status
  # 
  def self.Send(url, method, data, content_type, cert_path)
    # Parse url
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)

    if (url.match(/^https/))
      http.use_ssl = true
    end

    # Create request obj
    request = nil

    method = method || "post"
    case method.downcase
      when "post"
        request = Net::HTTP::Post.new(uri.request_uri)
      when "get"
        request = Net::HTTP::Get.new(uri.request_uri)
      else
        request = Net::HTTP::Post.new(uri.request_uri)
    end

    request.set_form_data(data)
    request["Content-Type"] = content_type || "application/json"

    # Add cert if any
    if (cert_path.nil?)
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    else
      http.use_ssl = true
      pem = File.read(cert_path)
      http.cert = OpenSSL::X509::Certificate.new(pem)
      http.key = OpenSSL::PKey::RSA.new(pem)
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    end

    # Send request and return response
    response = http.request(request)

  end
end
