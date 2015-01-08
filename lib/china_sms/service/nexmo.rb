# encoding: utf-8
require 'nexmo'
module ChinaSMS
  module Service
    module Nexmo
      extend self

      def to(phone, content, options)
        nexmo = Nexmo::Client.new(key: options[:username], secret: options[:password])
        begin
          result = nexmo.send_message(from: 'Whosv', to: phone, text: content)
          {success: result.to_i}
        rescue
          {error: 0}
        end
      end
    end
  end
end
