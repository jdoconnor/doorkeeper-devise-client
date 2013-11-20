module OmniAuth
  module Strategies
    class Doorkeeper < OmniAuth::Strategies::OAuth2
      option :name, :doorkeeper

      option :client_options, {
        :authorize_path => "/oauth/authorize",
        :darby => 'likes_cake'
      }

      option :authorize_params, {:darby => 'foobar'}

      option(:scope, 'public rule_world manage_businesses')

      uid do
        raw_info["id"]
      end

      info do
        {
          :email => raw_info["email"],
          :name => raw_info["name"]
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/users/me.json').parsed
      end
    end
  end
end
