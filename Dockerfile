ARG version=ruby:latest
FROM $version

# Needed for jruby
RUN apt-get update \
    && apt-get install -y make git

COPY prism/prism/nginx/cert.crt /usr/local/share/ca-certificates/cert.crt
RUN update-ca-certificates

WORKDIR /app
COPY . .

RUN make install
