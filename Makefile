.PHONY: install test test-integ test-docker

install:
	gem install bundler:2.1.2; bundle install

test:
	bundle exec rake

test-integ: test

version ?= ruby:latest
test-docker:
	curl -s https://raw.githubusercontent.com/sendgrid/sendgrid-oai/HEAD/prism/prism.sh -o prism.sh
	version=$(version) bash ./prism.sh
