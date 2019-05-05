class HashtagFilter < ApplicationRecord
  after_commit :restart_stream_service, on: [:create, :destroy]

  def restart_stream_service
    TwitterStreamService.instance.filterByHashtags(HashtagFilter.all)
  end
end
