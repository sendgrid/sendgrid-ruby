require './lib/sendgrid-ruby.rb'

client = SendGrid::Client.new ENV['SENDGRID_USERNAME'], ENV['SENDGRID_PASSWORD']
email = SendGrid::Mail.new(from: 'root@mail.doesnotscale.com', subject: 'Test', text: 'Body of sexy')
email.add_to 'eddiezane@sendgrid.com'
email.add_to 'rbin@sendgrid.com'
puts client.send(email)
