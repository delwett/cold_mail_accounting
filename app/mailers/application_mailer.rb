class ApplicationMailer < ActionMailer::Base
  default from: ENV['MAIL_LOGIN']
  layout 'mailer'
end
