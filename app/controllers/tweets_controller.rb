class TweetsController < ApplicationController
  def recent
    Tweet.ordered_json
    tweets = Tweet.ordered_json
    render json: tweets
  end

  def search
    hashtag = Hashtag.where(name: params[:keyword]).first
    if hashtag
      render json: hashtag.tweets.ordered_json
    else
      render :nothing => true, status: 404
    end
  end

  def create
    tweet = Tweet.create(params[:tweet])
    hashtags_names = params[:hashtags] || []
    hashtags_names.each do |name|
      tweet.hashtags << Hashtag.first_or_create(name: name)
    end
    render json: tweet.to_json(methods: :hashtag_names)
  end

end