#encoding: utf-8
require 'spec_helper'
require File.expand_path( "../lib/sharing_counter.rb" , File.dirname(__FILE__))

describe SharingCounter do

  def stub_requests_facebook!
    stub_get! "http://graph.facebook.com/?id=#{ @url }", "facebook.json.erb"
  end

  def stub_requests_twitter!
    stub_get! "http://urls.api.twitter.com/1/urls/count.json?url=#{ @url }", "twitter.json.erb"
  end

  def stub_requests_vk!
    stub_get! "http://vk.com/widget_like.php?app=#{ @app_id }&page=0&type=mini&url=#{ @url }", "vk.html.erb"
  end

  def stub_requests_ok!
    stub_get! "https://connect.ok.ru/dk?st.cmd=extLike&uid=odklcnt0&ref=#{ @url }", "ok.jsonp.erb"
  end

  before do
    @url    = "http://sharing.el"
    @count  = 100
    @app_id = 1
    SharingCounter.configure do |config|
      config.vk = { app_id: @app_id }
    end
  end

  it "counting" do
    stub_requests_facebook!
    stub_requests_twitter!
    stub_requests_vk!
    stub_requests_ok!
    counter = SharingCounter.get_count @url
    expect(counter[:facebook]).to eq @count
    expect(counter[:twitter]).to  eq @count
    expect(counter[:vk]).to       eq @count
    expect(counter[:ok]).to       eq @count
  end

  it "facebook total count" do
    stub_requests_facebook!
    counter = SharingCounter.get_count @url, [:facebook]
    expect(counter[:facebook]).to eq @count
    expect(counter[:twitter]).to  be_nil
    expect(counter[:vk]).to       be_nil
    expect(counter[:ok]).to       be_nil
  end

  it "counting twitter sharing" do
    stub_requests_twitter!
    counter = SharingCounter.get_count @url, [:twitter]
    expect(counter[:facebook]).to be_nil
    expect(counter[:twitter]).to  eq @count
    expect(counter[:vk]).to       be_nil
    expect(counter[:ok]).to       be_nil
  end

  it "counting vk sharing" do
    stub_requests_vk!
    counter = SharingCounter.get_count @url, [:vk]
    expect(counter[:facebook]).to be_nil
    expect(counter[:twitter]).to  be_nil
    expect(counter[:vk]).to       eq @count
    expect(counter[:ok]).to       be_nil
  end

  it "counting odnoklassniki sharing" do
    stub_requests_ok!
    counter = SharingCounter.get_count @url, [:ok]
    expect(counter[:facebook]).to be_nil
    expect(counter[:twitter]).to  be_nil
    expect(counter[:vk]).to       be_nil
    expect(counter[:ok]).to       eq @count
  end

end
