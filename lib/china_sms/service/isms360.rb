# encoding: utf-8
module ChinaSMS
  module Service
    module Isms360
      extend self
      URL = "http://210.51.190.233:8085/mt"

      def to(phone, content, options)
        phones = Array(phone).join(',')
	case content.encoding.name
	when "US-ASCII"
	  coding = 0
	when "ISO-8859-1"
	  coding = 3
	when "UTF-8" 
	  coding = 8
	else
	  content.encode!(Encoding::ASCII)
	  coding = 0
	end
        res = Net::HTTP.post_form(URI.parse("#{URL}/MT3.ashx"), src: options[:username], pwd: options[:password], dest: phones, msg: content.unpack("H*").first, codec: coding )
        result res.body
      end

      def result(body)
        if body.to_i >= 0
	  {success: body.to_i}
	else
	  {status: 'error',code:body.to_i}
	end
      end

    end
  end
end
