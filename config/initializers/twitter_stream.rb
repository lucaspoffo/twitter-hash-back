if Rails.const_defined? 'Server'
  TwitterStreamService.instance.filterByHashtags(['USA', 'America', 'Trump'])
end