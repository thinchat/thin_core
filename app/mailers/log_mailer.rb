class LogMailer < ActionMailer::Base
  include Resque::Mailer

  default from: "thinchat@gmail.com"

  def log_transcript(email, room_id)
    @room = Room.find(room_id) #need for view template rendering
    mail to: email, subject: "Your Chat Transcript from Thinchat"
  end
end
