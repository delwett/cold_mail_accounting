class Letter < ApplicationRecord
  include AASM
  belongs_to :user
  STATE_TYPES = ["In progress", "Completed"]
  validates :url, :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: {
      with: URI::MailTo::EMAIL_REGEXP
  }
  validates :url, :url => true
end
