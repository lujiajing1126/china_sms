# encoding: utf-8
require 'spec_helper'
require 'rspec/its'

describe "ChinaSMS" do
  let(:service) { :tui3 }
  let(:username) { 'saberma' }
  let(:password) { '666666' }
  let(:phone) { '15902122792' }
  let(:content) { '活动通知：深圳 Rubyist 活动时间变更到明天下午 7:00，请留意。' }

  context 'with service' do
    before { ChinaSMS.use service, username: username, password: password ,scope: :global
	     ChinaSMS.use service, username: username, password: password,scope: :domestic
    }
    describe "#use" do
      subject (:chinasms){ ChinaSMS }
      it "username is saberma" do
	expect(chinasms.accounts["tui3_global".to_sym][:username]).to eq "saberma"
      end
    end

    describe "#to" do
      before { allow(ChinaSMS::Service::Tui3).to receive(:to).with(phone,content,{:username => username,:password => password}).and_return(success: true, code: 0) }
      subject { ChinaSMS.to(phone, content) }
      its([:success]) { should eql true }
      its([:code]) { should eql 0 }
    end
  end

  context 'without service' do
    before { ChinaSMS.clear }

    describe '#to' do
      it 'should be ignore' do
        ChinaSMS.to(phone, content)
      end
    end

  end

end
