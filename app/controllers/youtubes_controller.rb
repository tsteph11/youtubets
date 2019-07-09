class YoutubesController < ApplicationController
    def new
    end

    def create
        snippets = {
            title: params[:youtube][:title]
        }.to_s
        youtube_upload_scope = 'https://www.googleapis.com/upload/youtube/v3/videos'
        payload = {video: Faraday::UploadIO.new(
            params[:youtube][:youtube].tempfile.path,
            params[:youtube][:youtube].content_type
        ),
        snippet: snippets }.to_s
        
        conn = Faraday.new(url: youtube_upload_scope) do |faraday|
            faraday.request :multipart
            faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        end
        res = conn.post do |req|
            req.params['part'] = 'snippet'
            req.params['access_token'] = session[:access_token]
            req.headers['content-type'] = params[:youtube][:youtube].content_type.to_s
            req.headers['Transfer-Encoding'] = 'chunked'
            req.body = payload
        end

        if res.status == 200
            @vid = "https://www.youtube.com/embed/#{JSON.parse(res.body)['id']}"
            render 'youtubes/ph'
            raise
        else
            raise
        end

    end
end