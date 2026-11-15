require 'grape'

class TestAPI < Grape::API
  format :json

  helpers do
    def help_me; { helper_stubbed: false } end
  end

  class << self
    attr_accessor :api_was_called
  end
  
  get :test_api_was_called do
    TestAPI.api_was_called = true
  end

  params do
    requires :param
  end
  get :test_params do
    { result: params[:param] }
  end

  params do
    requires :param
  end
  get :test_api_params do
    { result: params[:param] }
  end

  get :test_helper_invocation do
    help_me
  end

  params do
    requires :file, type: File
    requires :name
  end
  post :test_upload do
    { filename: params[:file][:filename], content: params[:file][:tempfile].read, name: params[:name] }
  end

  get '/params/:param/:id' do    
    params
  end
end
