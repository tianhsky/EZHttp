require "net/http"
require "uri"
require "openssl"

# A wrapper for ruby net/http, supports http/https, RESTful methods, certificate.
#  How to use:
#
#   # send a post request to specified url with the json as data
#   response = EZHttp.Send("https://www.example.com:83/api",
#                         {"key1"=>"value1"})
#
#   # send a put request to specified url with encoded query string params as data
#   response = EZHttp.Send("https://www.example.com:83/api",
#                         "key1=I%27ll+do&key2=He%27+do",
#                         "put",
#                         "application/x-www-form-urlencoded")
#
#   # specify extra headers
#   response = EZHttp.Send("https://www.example.com:83/api",
#                         {"key1"=>"value1"},
#                         "post",
#                         {"content-type" => "application/json", "authentication" => "xxxx"})
#
#   # use certificate
#   response = EZHttp.Send("https://www.example.com:83/api",
#                         {"key1"=>"value1"},
#                         "post",
#                         "application/json",
#                         "/path_to_cert.pem")
#
#   # display raw response
#   puts response.body
# 
# @author Tianyu Huang [tianhsky@yahoo.com]
# 
module EZHttp

  # Send http request to specified url and return responses
  # @param [String] url: to send request to
  # @param [Hash/String] data: to send
  # @param [String] method: choose from "get"/"post"/"delete"/"put", if nil default is "post"
  # @param [Hash] headers: if nil default is {"content-type" => "application/json"}
  # @param [String] cert_path: to the certificate file, set nil if none
  # @return [Net::HTTPResponse] response from remote server, example to access its fields: response.body, response.status
  # 
  def self.Send(url, data, method="post", headers={"content-type" => "application/json"}, cert_path=nil)

    # Parse url
    begin
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      if (url.match(/^https/))
        http.use_ssl = true
      end
    rescue
      throw "Error in url"
    end


    # Create request
    begin
      method = method || "post"
      case method.downcase
        when "post"
          request = Net::HTTP::Post.new(uri.request_uri)
        when "get"
          request = Net::HTTP::Get.new(uri.request_uri)
        when "put"
          request = Net::HTTP::Put.new(uri.request_uri)
        when "delete"
          request = Net::HTTP::Delete.new(uri.request_uri)
        else
          request = Net::HTTP::Post.new(uri.request_uri)
      end

      # Set form data
      request.set_form_data(data)

      # Set default content-type
      request["content-type"] = "application/json"

      # Set headers
      unless (headers.class.to_s == "String")
        if (headers.respond_to?("merge"))
          headers.each do |key, value|
            request[key.downcase] = value
          end
        end
      else
        content_type = headers
        request["content-type"] = content_type
      end

    rescue
      throw "Error in creating request"
    end


    # Add cert if any
    begin
      if (cert_path.nil?)
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      else
        http.use_ssl = true
        pem = File.read(cert_path)
        http.cert = OpenSSL::X509::Certificate.new(pem)
        http.key = OpenSSL::PKey::RSA.new(pem)
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      end
    rescue
      throw "Error in creating certificate"
    end


    # Send request and return response
    response = http.request(request)

  end
end
