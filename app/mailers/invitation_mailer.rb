require 'twilio-ruby'

class InvitationMailer < ApplicationMailer

  def self.invite(phone_number)
    account_sid = ENV["ACCOUNT_SID"]
    auth_token = ENV["AUTH_TOKEN"]
    @client = Twilio::REST::Client.new account_sid, auth_token
    message = @client.messages.create(body: "this is ruby",
                                      to: phone_number,
                                      from: "+12063396159"
    )
  end
end
