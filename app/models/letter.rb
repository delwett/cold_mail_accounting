class Letter < ApplicationRecord
  include AASM
  belongs_to :user
  validates :url, :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :url, format: { :with => /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?\Z/i }
  validates :comment, length: { maximum: 500 }

  scope :beginning_month_to_today, -> { where(created_at: Date.today.beginning_of_month..Date.tomorrow) }
  scope :last_half_year, -> { where('created_at > ?', Date.today.months_ago(6)) }

  scope :new_letters, -> { where(letter_status: 'new') }
  scope :in_progress_letters, -> { where(letter_status: 'in_progress') }
  scope :completed_letters, -> { where(letter_status: 'completed') }
  scope :cancelled_letters, -> { where(letter_status: 'cancelled') }
  scope :letters_count, -> { group(:letter_status).count }
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

  def self.get_count(states, letters)
    count = letters.group(:letter_status).count
    states.each { |state| count[state.to_s] = 0 if count[state.to_s].blank? }
    count.sort.to_h
  end
end
