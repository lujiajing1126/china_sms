# encoding: utf-8
require "china_sms/version"
require 'net/http'
Dir.glob("#{File.expand_path(File.dirname(__FILE__))}/china_sms/service/*.rb").sort.each do |f|
  require f.match(/(china_sms\/service\/.*)\.rb$/)[0]
end

module ChinaSMS
  extend self

  attr_reader :accounts
  SCOPE_TYPES = [:international,:global,:domestic]
  DEFAULT_SCOPE = :domestic
  def use(service, options)
    @accounts = {} if @accounts.nil?
    @accounts[service] = {:username => options[:username],:password => options[:password]}
    scope = SCOPE_TYPES.include?(options[:scope]) ? options[:scope] : DEFAULT_SCOPE
    @services = {} if @services.nil?
    @services[scope] = ChinaSMS::Service.const_get("#{service.to_s.capitalize}")
    @services[scope].const_set("URL", options[:base_uri]) if options[:base_uri]
  end

  def to(receiver, content, options = {})
    scope = SCOPE_TYPES.include?(options[:scope]) ? options[:scope] : DEFAULT_SCOPE
    return if @services.nil?
    service = @services[scope]
    options = default_options(service.name).merge options
    service.to receiver, content, options if service
  end

  def get(options = {})
    scope = SCOPE_TYPES.include?(options[:scope]) ? options[:scope] : DEFAULT_SCOPE
    return if @services.nil?
    service = @services[scope]
    options = default_options(service.name).merge options
    @service[options[:scope]].get options if service
  end

  def clear
    @services = @accounts = nil
  end

  private

  def default_options(service)
    @accounts[service.split("::").last.downcase.to_sym]
  end

end
