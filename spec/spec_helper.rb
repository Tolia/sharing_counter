require 'rubygems'
require 'fakeweb'
# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

def fixture_file(filename)
  file_path = File.expand_path File.dirname(__FILE__) + '/fixtures/' + filename
  template  = File.read file_path
  ERB.new(template).result binding
end

def stub_get!(url, filename, options={})
  opts = {
    body: fixture_file(filename),
    content_type: 'application/json; charset=utf-8'
  }.merge(options)
  FakeWeb.register_uri :get, url, opts
end
