class YoutubesController < ApplicationController
    def new
    end

    def create
        raise
        youtube_upload_scope = ' https://www.googleapis.com/upload/youtube/v3/videos'
        

        params[:youtube][:title]
        params[:youtube]
        Content-Type
        video/mp4

        conn = Faraday.new(url: youtube_upload_scope) do |faraday|
            faraday.request  :url_encoded             # form-encode POST params
            faraday.response :logger                  # log requests and responses to $stdout
            faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        end
        conn.post do |req|
            req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
            req.params['grant_type'] = 'authorization_code'
            req.params['client_id'] = YOUTUBE_CONFIG['client_id']
            req.params['client_secret'] = YOUTUBE_CONFIG['client_secret']
            req.params['redirect_uri'] = 'http://localhost:3000/login'
        end
        raise
    end
end