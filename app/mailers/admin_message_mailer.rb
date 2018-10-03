class AdminMessageMailer < ApplicationMailer
  def message_to_user(address, text)
    @text = text
    mail to: address, subject: t(:admin_message)
  end
end