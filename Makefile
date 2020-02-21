.PHONY: install test

install:
	gem install bundler:2.1.2; bundle install

test:
	bundle exec rake spec
