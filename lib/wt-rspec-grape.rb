require 'rspec/core'
require 'rack/test'

require 'rspec/grape/exceptions'
require 'rspec/grape/utils'
require 'rspec/grape/methods'

RSpec.configure do |config|
  config.include RSpec::Grape::Methods, type: :api
  config.include RSpec::Grape::Methods, :api

  after = Proc.new do
    # Grape 3.3 moved test hook reset out of `before_each(nil)` into a
    # dedicated `reset_before_each` (Grape::Testing). Requires grape >= 3.3.
    ::Grape::Endpoint.reset_before_each
  end

  config.after(:each, :api, &after)
  config.after(:each, type: :api, &after)
end
