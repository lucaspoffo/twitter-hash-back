require 'test_helper'

class HashtagFiltersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hashtag_filter = hashtag_filters(:one)
  end

  test "should get index" do
    get hashtag_filters_url, as: :json
    assert_response :success
  end

  test "should create hashtag_filter" do
    assert_difference('HashtagFilter.count') do
      post hashtag_filters_url, params: { hashtag_filter: { text: @hashtag_filter.text } }, as: :json
    end

    assert_response 201
  end

  test "should show hashtag_filter" do
    get hashtag_filter_url(@hashtag_filter), as: :json
    assert_response :success
  end

  test "should update hashtag_filter" do
    patch hashtag_filter_url(@hashtag_filter), params: { hashtag_filter: { text: @hashtag_filter.text } }, as: :json
    assert_response 200
  end

  test "should destroy hashtag_filter" do
    assert_difference('HashtagFilter.count', -1) do
      delete hashtag_filter_url(@hashtag_filter), as: :json
    end

    assert_response 204
  end
end
