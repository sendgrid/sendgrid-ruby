.PHONY: install test

install:
	gem install bundler:1.16.6; bundle install

test:
	bundle exec rake spec
