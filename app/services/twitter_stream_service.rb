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

    hashtags = hashtags.reject {|h| h[:text].blank?}
    return if hashtags.empty?
    track = hashtags.map {|h| '#' + h[:text]}.join(",")
    

    simple_hashtags = hashtags.map{|h| {text: h[:text].downcase}};

    @filter_thread = Thread.new do
      @client.filter(track: track, tweet_mode: 'extended') do |object|
        parsed_tweet = TweetParserService.new(object.to_hash)

        # exclude retweets
        next if parsed_tweet.tweet.key?(:retweeted_status)
        # check if tweet has desired hashtags
        next if (parsed_tweet.hashtags & simple_hashtags).empty?

        user = findOrCreateUser(parsed_tweet.user)
    
        tweet = Tweet.create({
          text: parsed_tweet.text,
          user: user,
          id: parsed_tweet.id
        })

        parsed_tweet.hashtags.each do |h| 
          hashtag = findOrCreateHashtag(h[:text])
          tweet.hashtags << hashtag
        end
      end
    end
  end

  def closeStream
    @client.close
    @filter_thread.kill
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

