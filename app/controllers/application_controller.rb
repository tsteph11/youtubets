class ApplicationController < ActionController::Base

    def login
        if !request.params['code'].nil?
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
                req.params['redirect_uri'] = 'http://localhost:3000/login'
            end
            session[:access_token] = JSON.parse(res.body)['access_token']
        end
        redirect_to new_youtube_url
    end
end
