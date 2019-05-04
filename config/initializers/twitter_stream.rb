if Rails.const_defined? 'Server'
  TwitterStreamService.instance.filterByHashtags(HashtagFilter.all)
end