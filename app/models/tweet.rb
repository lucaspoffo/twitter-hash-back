class Tweet < ApplicationRecord
  self.primary_key = "id"
  belongs_to :user
  has_and_belongs_to_many :hashtags

  scope :contains_hashtags, ->(hashtags) { joins(:hashtags).where(hashtags: {text: hashtags}) }
end
