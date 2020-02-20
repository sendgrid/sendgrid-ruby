.PHONY: install test

install:
	gem install bundler:1.17.3; bundle install

test:
	bundle exec rake spec
