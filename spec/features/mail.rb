require 'spec_helper'

feature 'SendGrid Mail' do

	it 'posts successfully to our API' do

		sendgrid = SendGrid::Client.new(api_user, api_key)

		sendgrid.send(email)

	end
	
end	