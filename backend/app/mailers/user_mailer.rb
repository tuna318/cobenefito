class UserMailer < ApplicationMailer
  default from: ENV['EMAIL_ACCOUNT']

  def invitation_email
    @url = ENV['CLIENT_URL']
    @user = params[:user]
    @password = params[:password]
    @space = params[:space]

    mail(to: @user.email, subject: 'Invitation to cobenefito space')
  end
end
