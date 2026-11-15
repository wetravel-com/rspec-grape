module RSpec
  module Grape
    module Methods
      include Rack::Test::Methods

      def app
        self.class.metadata[:grape_app] || RSpec.configuration.grape_app || described_class
      end

      def api_method
        @api_method ||= api_endpoint_description.split(' ').first.downcase.to_sym
      end

      def api_url
        @api_url ||= api_endpoint_description.split(' ').last
      end

      def parameterized_api_url(params = nil)
        raise RSpec::Grape::UrlIsNotParameterized unless parameterized_url?

        params ||= {}

        url = api_url.dup
        names = RSpec::Grape::Utils.url_param_names(api_url)
        names.each do |name|
          raise RSpec::Grape::UrlParameterNotSet unless params.has_key?(name.to_sym)

          url[":#{name}"] = params.delete(name).to_s
        end

        url
      end

      def call_api(params = nil)
        params ||= {}
        params = params.dup

        if parameterized_url?
          url = parameterized_api_url(params)
        else
          url = api_url
        end

        if %w[GET HEAD DELETE].include?(api_method.to_s.upcase) || params.empty? || file_upload?(params)
          self.send(api_method, url, params)
        else
          self.send(api_method, url, {}, { 'CONTENT_TYPE' => 'application/json', input: params.to_json })
        end
      end

      def expect_endpoint_to(matcher)
        ::Grape::Endpoint.before_each { |endpoint| expect(endpoint).to matcher }
      end

      def expect_endpoint_not_to(matcher)
        ::Grape::Endpoint.before_each { |endpoint| expect(endpoint).not_to matcher }
      end


      private

      def api_endpoint_description
        @api_endpoint_description ||= RSpec::Grape::Utils.find_endpoint_description(self.class)
      end

      def parameterized_url?
        api_url =~ /\/:/
      end

      def file_upload?(value)
        case value
        when Rack::Test::UploadedFile then true
        when Hash then value.values.any? { |v| file_upload?(v) }
        when Array then value.any? { |v| file_upload?(v) }
        else false
        end
      end
    end
  end
end
