#ruby lib
require "net/http"
require "uri"
require "openssl"

#gem
require "json"

# A wrapper for ruby net/http, supports http/https, RESTful methods, headers, certificate
# @author Tianyu Huang [tianhsky@yahoo.com]
# 
module EZHttp

  # Send http request to specified url and return responses
  # @param [String] url: to send request to
  # @param [Hash/String] data: hash to send or encoded query string or stringified hash
  # @param [String] method: choose from "get"/"post"/"delete"/"put", if nil default is "post"
  # @param [String] content_type: ie."application/json"
  # @param [Array[String]] headers: is an array of Strings, ie.["encoded_key:encoded_value","content-type:application/json"];
  # @param [String] cert_path: to the certificate file, don't specify or set nil if none
  # @return [Net::HTTPResponse] response from remote server, example to access its fields: response.body
  # 
  def self.Send(url, data=nil, method=nil, content_type=nil, headers=nil, cert_path=nil)

    begin
      # Parse url
      url.strip!
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      if (url.match(/^https/))
        http.use_ssl = true
      end

      # Create request
      request_method = data.nil? ? "get" : "post"
      request_method = method || request_method
      request_method.strip!
      request_method.downcase!
      case request_method
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
    rescue
      throw "Error in creating request"
    end


    # Set content-type
    request["content-type"] = content_type.strip! unless content_type.nil?


    # Set data (can be json or encoded query string)
    begin
      unless (data.nil?)
        if (data.class.to_s == "Hash" || data.respond_to?("merge"))
          request.body = data.to_json
          request["content-type"] = "application/json" if request["content-type"].nil?
        else
          if (data.include?("{") && data.include?("}"))
            request["content-type"] = "application/json" if request["content-type"].nil?
          end
          request.body = data.strip
          #request["content-type"] = "application/x-www-form-urlencoded" if request["content-type"].nil?
        end
      end
    rescue
      throw "Error in parsing data"
    end


    # Set headers
    begin
      unless (headers.nil?)
        headers.each do |header|
          key = header.split(':')[0]
          value = header.split(':')[1]
          request[key.strip.downcase] = value.strip
        end
      end
    rescue
      throw "Error in parsing headers"
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


  def self.Post(url, data=nil, content_type=nil, headers=nil, cert_path=nil)
    self.Send(url, data, "post", content_type, headers, cert_path)
  end

  def self.Get(url, data=nil, content_type=nil, headers=nil, cert_path=nil)
    self.Send(url, data, "get", content_type, headers, cert_path)
  end

  def self.Put(url, data=nil, content_type=nil, headers=nil, cert_path=nil)
    self.Send(url, data, "put", content_type, headers, cert_path)
  end

  def self.Delete(url, data=nil, content_type=nil, headers=nil, cert_path=nil)
    self.Send(url, data, "delete", content_type, headers, cert_path)
  end

  # Upload files
  # @param [String] url: server to upload
  # @param [Hash] files: [{"name","content"}]
  # @param [Array[String]] headers: is an array of Strings, ie.["authorization:Basic twwtws33vsfesfsd=="];
  #
  def self.Upload(url, files, headers=nil, cert_path=nil)

    begin
      # Parse url
      url.strip!
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      if (url.match(/^https/))
        http.use_ssl = true
      end

      # Create request
      request = Net::HTTP::Post.new(uri.request_uri)
    rescue
      throw "Error in creating request"
    end

    # Set headers
    begin
      unless (headers.nil?)
        headers.each do |header|
          key = header.split(':')[0]
          value = header.split(':')[1]
          request[key.strip.downcase] = value.strip
        end
      end
    rescue
      throw "Error in parsing headers"
    end

    # Create files
    boundry = "--content--boundry--keybegin--AaB03sfwegSFSWxGBgSBsFDYcRcRMi--keyend--"
    post_body = []

    if (!files.nil? && files.length > 0)
      files.each_with_index do |file, i|
        post_body << "--#{boundry}\r\n"
        post_body << "content-disposition: form-data; name=\"upload[file#{i}]\"; filename=\"#{file["name"]}\"\r\n"
        post_body << "content-type: application/octet-stream\r\n"
        post_body << "\r\n"
        post_body << file["content"] + "\r\n"
      end
      post_body << "--#{boundry}--\r\n"

      request.body = post_body.join
    end

    # Set content type
    request["content-type"] = "multipart/form-data, boundary=#{boundry}"

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

