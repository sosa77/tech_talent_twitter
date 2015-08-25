class EpicenterController < ApplicationController
  def feed
    @following_tweets = []
    @tweets = Tweet.all
    @follower_count = 0
    @users = User.all

    if user_signed_in?
      @users.each do |user|
        if user.following.include?(current_user.id)
          @follower_count =+ 1
        end
      end
      # add tweet to following_tweets array if tweet user id
      # is present in user's following array
      @tweets.each do |tweet|
        current_user.following.each do |f|
         if tweet.user_id == f
           @following_tweets.push(tweet)
         end
        end
      end
    else
      redirect_to new_user_session_path
    end
  end

  def show_user
    @user = User.find(params[:id])
  end

  def now_following
    @user = User.find(params[:follow_id])

    # add user_id to current_user folllowing array
    current_user.following.push(params[:follow_id].to_i)
    current_user.save
  end

  def unfollow
    current_user.following.delete(params[:unfollow_id].to_i)
    current_user.save
  end
end
