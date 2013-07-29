require 'emarsys'
require 'rspec'
require 'webmock/rspec'

WebMock.disable_net_connect!(:allow => 'coveralls.io')

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
end

def stub_emarsys_authentication!
  Emarsys.configure do |config|
    config.api_username = "my_username"
    config.api_password = "my_password"
  end
end

def standard_return_body
  {:body => "{\"replyCode\":0,\"replyText\":\"Something\",\"data\":1}"}
end