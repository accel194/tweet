class TweetsController < ApplicationController
  def index
    @input_content = Tweet.new
    @tweet = Tweet.includes(:user).order('updated_at DESC')
  end

  def create
    tweet = Tweet.new
    tweet.attributes = input_content_param
    tweet.user_id = current_user.id
    if tweet.valid?
      tweet.save!
    else
      flash[:alert] = tweet.errors.full_contents
    end
    redirect_to action: :index
  end

  private
  def input_content_param
    params.require(:tweet).permit(:content)
  end
end
