class Tweet < ActiveRecord::Base
  belongs_to :user

  validates :message, presence: true
  validates :message, length: {maximum: 140, too_long: "A tweet is 140 characters max."}
end
