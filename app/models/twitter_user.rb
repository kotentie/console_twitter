class TwitterUser < ActiveRecord::Base
  # Remember to create a migration!
  has_many :tweets


  def tweets_stale?(user)
    @time = user.tweets[-2].tweet_time
    @time_of_last_tweet = user.tweets.last.tweet_time
    puts Time.parse(@time) - Time.parse(@time_of_last_tweet)
    if Time.parse(@time) - Time.parse(@time_of_last_tweet) <= 1
       false
    else
      true
    end
  end

end