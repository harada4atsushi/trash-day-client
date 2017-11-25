module OmniAuth
  module Strategies
    class Doorkeeper < OmniAuth::Strategies::OAuth2
      option :name, :doorkeeper

      site = 'http://localhost:3000'
      site = 'https://trash-day-server.herokuapp.com' if Rails.env.production?
      option :client_options, site: site, authorize_path: '/oauth/authorize'

      uid { raw_info['id'] }
      # providerから送られてきたデータの内、どれを使いたいか
      info do
        { email: raw_info['email'] }
      end

      # providerのAPIを叩いて、データを取ってくる
      # def raw_info
      #   @raw_info ||= access_token.get('/api/login.json').parsed
      # end

      def raw_info
        # binding.pry
        @raw_info ||= JSON.parse(access_token.get('api/v1/me').response.body)
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end
