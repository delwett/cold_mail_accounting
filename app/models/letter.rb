class Letter < ApplicationRecord
  include AASM
  belongs_to :user
  validates :url, :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :url, format: { :with => /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?\Z/i }

  aasm column: 'letter_status' do
    state :new, initial: true
    state :in_progress
    state :completed
    state :cancelled

    event :to_in_progress do
      transitions from: :new, to: :in_progress
    end

    event :to_completed do
      transitions from: [:new, :in_progress], to: :completed
    end

    event :to_cancelled do
      transitions from: [:new, :in_progress], to: :cancelled
    end
  end
end
