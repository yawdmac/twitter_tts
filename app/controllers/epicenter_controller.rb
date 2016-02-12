class EpicenterController < ApplicationController
	before_filter :authenticate_user!
  def feed
#Here we will initialize the array that will
#hold Tweets from the current user's
#following list.
  	@following_tweets = []
  	@follower_count = 0 

  	#We pul in all the tweets..
  	@tweets = Tweet.all
  	@users = User.all
#Then we sort through the tweets
#to find the ones associated with 
#users from the currenyt users
#following array.

  	@tweets.each do |tweet|
  		current_user.following.each do |f|
  			if tweet.user_id == f
  				@following_tweets.push(tweet)
  				#And those tweets are pushed 
  				#into the @following_tweets array
  				#we saw back on the view
  			end
  		end
  	end


  		
  		
  		@users.each do |user|
  			if user.following.include?(current_user.id)
  				@follower_count += 1
  			end
  	end
  end

  def show_user
  	@user = User.find(params[:id])
  end

  def now_following
  	@user = User.find(params[:follow_id])
  	current_user.following.push(params[:follow_id].to_i)
  	current_users.save
  end


  def unfollow
  	@user = User.find(params[:unfollow_id])
  	current_user.following.delete(params[:unfollow_id].to_i)
  	current_user.save
  end
end

