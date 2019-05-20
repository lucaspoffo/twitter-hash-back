class TweetParserService
  attr_reader :tweet, :text, :user, :id, :hashtags

  def initialize(tweet)
    @tweet = tweet
    @id = tweet[:id]
    @user = tweet[:user]
    @text = parse_tweet_text
    @hashtags = parse_tweet_hashtags
  end

  def parse_tweet_text
    if @tweet[:truncated] 
      return @tweet[:extended_tweet][:full_text]
    end
    return @tweet[:text]
  end

  def parse_tweet_hashtags
    if @tweet[:truncated] 
      hashtags = @tweet[:extended_tweet][:entities][:hashtags]
    else
      hashtags = @tweet[:entities][:hashtags]
    end
    return hashtags.map {|h| {text: h[:text].downcase}}
  end
end