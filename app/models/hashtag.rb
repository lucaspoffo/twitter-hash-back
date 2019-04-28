class Hashtag < ApplicationRecord
  has_and_belongs_to_many :tweet
  before_save :downcase_text

  def downcase_text
    self.text.downcase!
  end

end
