class ApplicationController < ActionController::Base

    def login
        client_id = Google::Auth::ClientId.from_file('./oauth2.keys.json')
        scope = ['https://www.googleapis.com/auth/youtube.upload']
        authorizer = Google::Auth::WebUserAuthorizer.new(client_id, scope, '/login')

        redirect_to authorizer.get_authorization_url(request: request)
    end

    def logout
        reset_session
    end

    def oauth2callback
        conn = Faraday.new(url: 'https://oauth2.googleapis.com/token') do |faraday|
            faraday.request  :url_encoded             # form-encode POST params
            faraday.response :logger                  # log requests and responses to $stdout
            faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        end
        res = conn.post do |req|
            req.headers['content-type'] = 'application/x-www-form-urlencoded'
            req.params['grant_type'] = 'authorization_code'
            req.params['client_id'] = YOUTUBE_CONFIG['client_id']
            req.params['client_secret'] = YOUTUBE_CONFIG['client_secret']
            req.params['code'] = CGI.unescape(request.params[:code])
            req.params['redirect_uri'] = 'http://localhost:3000/oauth2callback'
        end
        session[:access_token] = JSON.parse(res.body)['access_token']
        redirect_to new_youtube_url
    end
end
