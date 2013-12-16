require 'sinatra'
require 'twilio-ruby'

get '/' do
  account_sid = 'ACfe7e78231c52c27cd7d4fd42db5ffcf9'
  auth_token = '1968a4b25f522dda89844bf1689d5958'
  capability = Twilio::Util::Capability.new account_sid, auth_token
  testing_app_sid = 'APeae4f49e53ce1bc22720045931443181'
  capability.allow_client_outgoing testing_app_sid
  capability.allow_client_incoming 'jason'
  token = capability.generate
  erb :index, locals: { token: token }
end

post '/voice' do
  response = Twilio::TwiML::Response.new do |r|
    r.Dial callerId: '7039972176' do |d|
      d.Client 'jason'
    end
  end
  response.text
end
