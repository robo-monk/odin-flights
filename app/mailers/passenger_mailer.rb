class PassengerMailer < ApplicationMailer
  default from: 'noreply@odinflights.com'

  def thank_you_email
    @passenger = params[:passenger]
    mail(to: @passenger.email, subject: 'Welcome to Odin Flights!' )
  end
end
