# Docker image for sendgrid-ruby

## Quickstart
1. [Install Docker](https://docs.docker.com/engine/installation/) on your machine.
2. Run `docker run --rm -it sendgrid/sendgrid-ruby irb`.
3. Run `require './lib/sendgrid-ruby.rb'`.

## Poke around

If you would like to just poke around in the image and check some examples:
```sh
docker run --rm -it sendgrid/sendgrid-ruby bash
```

If you want to mount your fork or specific version of the gem:
```sh
docker run --rm -v /path/to/local/sendgrid-ruby:/sources/sendgrid-ruby -it sendgrid/sendgrid-ruby bash
```

## Running tests

If you would like to run the tests present in the image:
```sh
docker run --rm sendgrid/sendgrid-ruby rake
```

If you want to run tests on your fork or a specific version, mount the codebase onto the image:
```sh
docker run --rm -v /path/to/local/sendgrid-ruby:/sources/sendgrid-ruby sendgrid/sendgrid-ruby rake
```
