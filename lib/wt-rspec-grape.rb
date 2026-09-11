require 'rspec/core'
require 'rack/test'
require 'grape'
# Defines Grape::Endpoint.before_each / .reset_before_each, which the endpoint
# matchers use. Documented as opt-in all along, but Grape < 4 left it in the
# eager load so `require 'grape'` pulled it in; Grape >= 4 excludes it. Must come
# after `require 'grape'` -- it prepends onto Grape::Endpoint at load time. A
# no-op on Grape 3.3, where the eager load got there first.
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
