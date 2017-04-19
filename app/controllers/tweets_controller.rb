class TweetsController < ApplicationController
  def index
    @input_content = params[:id] ? Tweet.find(params[:id]) : Tweet.new
    @tweet = Tweet.includes(:user).not_reply.order('updated_at DESC')
    @users = User.all
    @tweets = Tweet.page(params[:page]).per(3)
    if params[:reply_tweet_id]
      @reply_tweet =Tweet.find(params[:reply_tweet_id])
    end
  end

  def create
    tweet = Tweet.new
    tweet.attributes = input_content_param
    tweet.user_id = current_user.id
    if tweet.valid?
      tweet.save!
    else
      flash[:alert] = tweet.errors.full_messages
    end
    redirect_to action: :index
  end

  def update
    tweet = Tweet.find(params[:id])
    tweet.attributes = input_content_param
    if tweet.valid?
      tweet.save!
    else
      flash[:alert] = tweet.errors.full_contents
    end
    redirect_to action: :index
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to action: :index
  end

  private
  def input_content_param
    params.require(:tweet).permit(:content, :reply_tweet_id)
  end
end
