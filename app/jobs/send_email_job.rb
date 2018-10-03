class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(address, text)
    @text = text
    @address = address
    AdminMessageMailer.message_to_user(@address, @text).deliver_later
  end
end
