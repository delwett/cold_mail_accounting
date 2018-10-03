class AdminMessageMailer < ApplicationMailer
  default from: 'dmitriy.trunin@kodep.ru'
  def message_to_user(address, text)
    @text = text
    binding.pry
    mail to: address, subject: t(:admin_message)
  end
end