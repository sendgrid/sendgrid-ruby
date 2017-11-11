FROM ruby:2.4.2-jessie

# Clone sendgrid-ruby
WORKDIR /sources
RUN git clone https://github.com/sendgrid/sendgrid-ruby.git

# Bundle
WORKDIR /sources/sendgrid-ruby
RUN bundle install

# Install prism
RUN curl https://raw.githubusercontent.com/stoplightio/prism/master/install.sh | sh
