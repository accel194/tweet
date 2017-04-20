module TweetsHelper

  def mypost?(tweet)
    tweet.user.id == current_user.id
  end
end
