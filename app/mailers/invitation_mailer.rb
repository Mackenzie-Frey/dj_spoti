require 'twilio-ruby'

class InvitationMailer < ApplicationMailer

  def invite(phone_number, current_party)
    account_sid = ENV["ACCOUNT_SID"]
    auth_token = ENV["AUTH_TOKEN"]
    url = "https://dj-spoti.herokuapp.com/join?i=#{current_party.identifier}"
    @client = Twilio::REST::Client.new account_sid, auth_token
    @client.messages.create(body: "Hey Party Animal Join#{current_party.name} Here  #{url} ",
                            to: phone_number,
                            from: "+12063396159")
  end
end
