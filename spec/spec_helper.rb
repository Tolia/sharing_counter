require 'rubygems'
require 'webmock/rspec'
# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

def fixture_file(filename)
  file_path = File.expand_path File.dirname(__FILE__) + '/fixtures/' + filename
  template  = File.read file_path
  ERB.new(template).result binding
end

def stub_get!(url, filename, options={})
  response_opts = {
    body: fixture_file(filename),
    headers: {
      "Content-Type" => 'application/json; charset=utf-8'
    },
    status: 200
  }.merge(options)
  stub_request(:get, url).to_return response_opts
end
