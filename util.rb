def log(str)
	puts Time.now
	puts str.to_s
end



def sms(str)
	require 'twilio-ruby'

	begin
		account_sid = "ACebd2b03587f7d7a0fc4a0e9b9a0bd946" # Your Account SID from www.twilio.com/console
		auth_token = "2639aede472429b2cc619d663c5a4d67"   # Your Auth Token from www.twilio.com/console

		@client = Twilio::REST::Client.new account_sid, auth_token
		message = @client.account.messages.create(:body => str,
			:to => "+15307607172",    # Replace with your phone number
			:from => "+19162457327")  # Replace with your Twilio number

		puts message.sid

	rescue Twilio::REST::RequestError => e
	  puts e.message
	  close
	  setup
	  run
	end
end
