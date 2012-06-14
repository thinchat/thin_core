class LogMailer < ActionMailer::Base
  include Resque::Mailer

  default from: "thinchat@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.log_mailer.log_transcript.subject
  #
  #

  def log_transcript(email, room_id)
    @room = Room.find(room_id)
    mail to: email, subject: "Your Chat Transcript from Thinchat"
  end
end
