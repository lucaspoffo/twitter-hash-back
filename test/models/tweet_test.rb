require 'test_helper'

class TweetTest < ActiveSupport::TestCase
  
  test "can filter based on hashtag" do
    tweet = Tweet.create({
      text: 'Teste',
      user: User.first,
      id: 123
    })
    tweet.hashtags << Hashtag.create({text: 'filtertest'})
    filtered_tweets = Tweet.contains_hashtags(['filtertest'])
    assert(filtered_tweets.include? tweet)
    assert_equal(filtered_tweets.length, 1)
  end
end
