# encoding: utf-8
require 'spec_helper'

describe "Voice" do

  describe "voice#to" do
    let(:username) { 'api' }
    let(:password) { 'key-password' }
    let(:content) { '1234' }
    subject { ChinaSMS::Service::Voice.to phone, content, username: username, password: password }

    describe 'single phone' do
      let(:phone) { '13928935535' }

      before do
        stub_request(:post, "http://#{username}:#{password}@voice-api.luosimao.com/v1/verify.json").
          with(:body => {"message"=> content, "mobile"=> phone}).to_return(body: '{"error":0,"msg":"ok"}')
      end

      its([:success]) { should eql true }
      its([:code]) { should eql 0 }
      its([:message]) { should eql "ok" }
    end
  end

end
