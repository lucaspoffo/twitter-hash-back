require 'test_helper'

class  TwitterStreamServiceTest < ActiveSupport::TestCase
  
  test "it finds user" do
      user = User.find(1)
      params = {
        id: 1
      }
      assert_equal(TwitterStreamService.instance.findOrCreateUser(params), user)
  end

  test "it creates user when not finding" do
    count = User.count
    params = {
      id: 123456789,
      name: 'Teste',
      screen_name: 'Screen Teste',
      profile_image_url: 'www.test.com'
    }
    user = TwitterStreamService.instance.findOrCreateUser(params)
    assert_equal user.id, params[:id]
    assert_equal user.name, params[:name]
    assert_equal user.screen_name, params[:screen_name]
    assert_equal user.profile_image_url, params[:profile_image_url]
    assert_equal User.count, count + 1
  end

  test "it finds hashtag" do
    text = 'brasil'
    hashtag = Hashtag.find_by text: text
    assert_equal(TwitterStreamService.instance.findOrCreateHashtag(text), hashtag)
  end

  test "it finds hashtag ignoring case" do
    hashtag = Hashtag.find_by text: 'brasil'
    assert_equal(TwitterStreamService.instance.findOrCreateHashtag('BrAsiL'), hashtag)
  end

  test "it creates hashtag when not finding" do
    count = Hashtag.count
    text = 'newhash'
    hashtag = TwitterStreamService.instance.findOrCreateHashtag(text)
    assert_equal hashtag.text, text
    assert_equal Hashtag.count, count + 1
  end

  test "it creates hashtag with downcase text" do
    count = Hashtag.count
    text = 'ARGENTINA'
    hashtag = TwitterStreamService.instance.findOrCreateHashtag(text)
    assert_equal hashtag.text, text
    assert_equal Hashtag.count, count + 1
    assert_equal hashtag, Hashtag.find_by(text: 'argentina')
  end

  test "it creates tweet" do
    count = Tweet.count
    user = User.first
    text = 'test tweet'
    id = 123
    tweet = TwitterStreamService.instance.createTweet(text, user, id)
    assert_equal Tweet.count, count + 1
    assert_equal tweet.user, user
    assert_equal tweet.text, text
  end
end