require 'twitter'
require 'singleton'

class TwitterStreamService
  include Singleton

  def initialize
    @client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = ENV.fetch("TWITTER_CONSUMER_KEY")
      config.consumer_secret     = ENV.fetch("TWITTER_CONSUMER_SECRET")
      config.access_token        = ENV.fetch("TWITTER_ACCESS_TOKEN")
      config.access_token_secret = ENV.fetch("TWITTER_ACCESS_SECRET")
    end
  end

  def filterByHashtags(hashtags)
    closeStream if @filter_thread && @filter_thread.status

    track = hashtags.map {|h| '#' + h[:text]}.join(",")

    return if track.empty?

    @filter_thread = Thread.new do
      @client.filter(track: track, tweet_mode: 'extended') do |object|
        tweet_params = object.to_hash
        text = getTweetText(tweet_params)
        hashtags = getTweetHashtags(tweet_params)
  
        user = findOrCreateUser(tweet_params[:user])
        tweet = createTweet(text, user, tweet_params[:id])
      
        hashtags.each do |h| 
          hashtag = findOrCreateHashtag(h[:text])
          tweet.hashtags << hashtag
        end
      end
    end
  end

  def getTweetText(params)
    if params[:truncated] 
      return params[:extended_tweet][:full_text]
    end
    return params[:text]
  end

  def closeStream
    @client.close
    @filter_thread.kill
  end

  def getTweetHashtags(params)
    if params[:truncated] 
      return params[:extended_tweet][:entities][:hashtags]
    end
    return params[:entities][:hashtags]
  end

  def createTweet(text, user, id)
    tweet = Tweet.create({
      text: text,
      user: user,
      id: id
    })
    return tweet
  end

  def findOrCreateUser(params)
    begin
      user = User.find(params[:id])
    rescue
      user = User.create({
        id: params[:id],
        name: params[:name],
        screen_name: params[:screen_name],
        profile_image_url: params[:profile_image_url]
      })
    end
    return user
  end

  def findOrCreateHashtag(text)
    #Downcase because the API search is case-insensitive
    text.downcase!
    hashtag = Hashtag.find_by(text: text)
    if not hashtag
      hashtag = Hashtag.new({text: text})
      hashtag.save
    end
    return hashtag
  end
    
end

