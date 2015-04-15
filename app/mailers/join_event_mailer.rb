class JoinEventMailer < ApplicationMailer
  default from: 'dinnr.makers@gmail.com'

  def join_email(options)
    @user = options[:user]
    @event = options[:event]
    mail(to: @user.email, subject: "You have succesfully joined an event")
  end

end
