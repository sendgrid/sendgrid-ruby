install:
	gem install bundler:1.14.6; bundle install

test:
	bundle exec rake spec
