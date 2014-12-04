# encoding: utf-8
module ChinaSMS
  module Service
    module Isms360
      extend self
      URL = "http://210.51.190.233:8085/mt"

      def to(phone, content, options)
        phones = Array(phone).join(',')
        res = Net::HTTP.post_form(URI.parse("#{URL}/MT3.ashx"), src: options[:username], pwd: options[:password], dest: phones, msg: content, codec: 0)
        result res.body
      end

      def result(body)
        body
      end

    end
  end
end
