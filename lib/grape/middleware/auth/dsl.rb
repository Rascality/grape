# frozen_string_literal: true

require 'rack/auth/basic'

module Grape
  module Middleware
    module Auth
      module DSL
        extend ActiveSupport::Concern

        module ClassMethods
          # Add an authentication type to the API. Currently
          # only `:http_basic` is supported.
          def auth(type = nil, options = {}, &block)
            if type
              namespace_inheritable(:auth, options.reverse_merge(type: type.to_sym, proc: block))
              use Grape::Middleware::Auth::Base, namespace_inheritable(:auth)
            else
              namespace_inheritable(:auth)
            end
          end

          # Add HTTP Basic authorization to the API.
          #
          # @param [Hash] options A hash of options.
          # @option options [String] :realm "API Authorization" The HTTP Basic realm.
          def http_basic(options = {}, &block)
            options[:realm] ||= 'API Authorization'
            auth :http_basic, options, &block
          end
        end
      end
    end
  end
end
