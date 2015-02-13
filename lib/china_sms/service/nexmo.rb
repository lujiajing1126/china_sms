# encoding: utf-8
require 'nexmo'
module ChinaSMS
  module Service
    module Nexmo
      extend self

      def to(phone, code, options)
        prefix = options[:prefix].to_i || 86
        nexmo = ::Nexmo::Client.new(key: options[:username], secret: options[:password])
        begin
          case prefix
            when 1
              result = nexmo.send_2fa_message(to: phone, pin: code)
            else
              content = "Your Whosv code is #{code}."
              result = nexmo.send_message(from: 'Whosv', to: phone, text: content)
          end
          {success: result.to_i}
        rescue
          {error: 0}
        end
      end
    end
  end
end
