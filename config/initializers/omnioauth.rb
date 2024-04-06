# frozen_string_literal: true

OmniAuth.config.request_validation_phase = nil
#
# module OmniAuth
#   module Strategies
#     # Authentication strategy for connecting with APIs constructed using
#     # the [OAuth 2.0 Specification](http://tools.ietf.org/html/draft-ietf-oauth-v2-10).
#     # You must generally register your application with the provider and
#     # utilize an application id and secret in order to authenticate using
#     # OAuth 2.0.
#     class OAuth2
#       def render(uri)
#         r = Rack::Response.new
#         r.write({ oauth_url: uri }.to_json)
#         r.finish
#       end
#
#       def request_phase
#         render client.auth_code.authorize_url({ redirect_uri: callback_url }.merge(authorize_params))
#       end
#     end
#   end
# end
