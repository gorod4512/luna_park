# frozen_string_literal: true

require 'luna_park/gateways/http/errors/default'

module LunaPark
  module Gateways
    module Http
      module Handlers
        class Default
          attr_reader :skip_errors

          def initialize(skip_errors: [])
            @skip_errors = skip_errors
          end

          def error(title, request:, response:)
            unless skip_errors.include? response.code # rubocop:disable Style/GuardClause
              raise Errors::Default::Diagnostic.new(title, request: request, response: response)
            end
          end

          def timeout_error(title, request:)
            raise Errors::Default::Timeout.new(title, request: request) unless skip_errors.include?(:timeout)
          end
        end
      end
    end
  end
end
