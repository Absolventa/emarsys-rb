require 'emarsys'
require 'rspec'
require 'webmock/rspec'
require 'timecop'

WebMock.disable_net_connect!

RSpec.configure do |config|
  config.before(:all) { stub_emarsys_authentication! }
end

def stub_emarsys_authentication!
  Emarsys.configure do |config|
    config.api_username = "my_username"
    config.api_password = "my_password"
  end
  Emarsys.allow_default_configuration = true
end

def standard_return_body
  {:body => "{\"replyCode\":0,\"replyText\":\"Something\",\"data\":1}"}
end

def stub_get(path, &block)
  stub = stub_request(:get, "https://api.emarsys.net/api/v2/#{path}").to_return(standard_return_body)
  yield if block_given?
  stub
end

def stub_post(path, &block)
  stub = stub_request(:post, "https://api.emarsys.net/api/v2/#{path}").to_return(standard_return_body)
  yield if block_given?
  stub
end
