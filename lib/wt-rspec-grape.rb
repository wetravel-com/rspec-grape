require 'rspec/core'
require 'rack/test'
require 'grape'
require 'grape/testing'

require 'rspec/grape/exceptions'
require 'rspec/grape/utils'
require 'rspec/grape/methods'

RSpec.configure do |config|
  config.include RSpec::Grape::Methods, type: :api
  config.include RSpec::Grape::Methods, :api

  after = Proc.new do
    ::Grape::Endpoint.reset_before_each
  end

  config.after(:each, :api, &after)
  config.after(:each, type: :api, &after)
end
