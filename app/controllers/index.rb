
get '/' do
  # Look in app/views/index.erb
  puts ENV["TOKEN"]
  erb :index
end


post '/usernames/new' do

@twitter_user = params[:twitter_user]
TwitterUser.find_or_create_by_username(username: @twitter_user)
redirect to "/#{@twitter_user}"


end


get '/:username' do


@user = TwitterUser.find_by_username(params[:username])
  if @user.tweets.empty?
    tweets = Twitter.user_timeline(params[:username])
      tweets.each do |tweet|
        Tweet.create(content: tweet.text, twitter_user_id: @user.id, tweet_time: tweet.created_at, image: tweet.profile_image_url)
          @tweets = @user.tweets.limit(10)

      end

  elsif @user.tweets_stale?(@user)
    tweets = Twitter.user_timeline(params[:username])
      tweets.each do |tweet|
        p tweet
        p @user.id
        Tweet.create(content: tweet.text, twitter_user_id: @user.id, tweet_time: tweet.created_at, image: tweet.profile_image_url)
        @tweets = @user.tweets.limit(10)
      end
  else
    @tweets = @user.tweets.limit(10)
    erb :_user_tweets_fast
  end
@tweets = @user.tweets.limit(10)
erb :user_tweets

end

get '/search/new' do

@tweets=Twitter.search(params[:hash_tag], :lang => params[:language], :count => params[:number]).results

erb :search
end

post '/tweets/new' do

Twitter.update(params[:tweet])

# @twitter_user = params[:twitter_user]
# TwitterUser.find_or_create_by_username(username: @twitter_user)
# Tweet.create(content: params[:tweet], )
redirect to ('/')
end