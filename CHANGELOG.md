# Change Log
All notable changes to this project will be documented in this file.

## [4.0.0] - 2016-07-23 ##
### BREAKING CHANGE
- Update dependency to [ruby-http-client](https://github.com/sendgrid/ruby-http-client/releases/tag/v3.0.0)
- Response headers now return a hash instead of a string
- Thanks to [Chris France](https://github.com/hipsterelitist) for the pull request!

## [3.0.7] - 2016-07-20 ##
### Added
- README updates
- Update introduction blurb to include information regarding our forward path
- Update the v3 /mail/send example to include non-helper usage
- Update the generic v3 example to include non-fluent interface usage

## [3.0.6] - 2016-07-05 ##
### Added
- Update docs, unit tests and examples to include Sender ID

## [3.0.5] - 2016-07-05 ##
### Added
- Accept: application/json header per https://sendgrid.com/docs/API_Reference/Web_API_v3/How_To_Use_The_Web_API_v3/requests.html

### Updated
- Content based on our updated [Swagger/OAI doc](https://github.com/sendgrid/sendgrid-oai)

## [3.0.4] - 2016-06-15 ##
### Added
- Updated dependency on ruby-http-client

## [3.0.3] - 2016-06-15 ##
### Fixing
- Import structure

## [3.0.2] - 2016-06-15 ##
### Added
- Relative import for mail/helper

## [3.0.1] - 2016-06-15 ##
### Added
- Add mail/send helper to the $LOAD_PATH, updated http client dependency

## [3.0.0] - 2016-06-13 ##
### Added
- Breaking change to support the v3 Web API
- New HTTP client
- v3 Mail Send helper

## [1.1.6] - 2015-11-26 ##
## Added
Support for cc_name and bcc_name via [#31](https://github.com/sendgrid/sendgrid-ruby/pull/31)

Thanks [Dylan](https://github.com/DylanGriffith)!

## [1.1.5] - 2015-10-28 ##
## Added
Support for [Templates](https://github.com/sendgrid/sendgrid-ruby#working-with-templates) via [#28](https://github.com/sendgrid/sendgrid-ruby/pull/28)

Thanks [Jake](https://github.com/yez)!


## [1.0.5] - 2015-10-21 ##
### Fixed
Remove puts from mail.rb [#29](https://github.com/sendgrid/sendgrid-ruby/pull/29)

## [1.0.4] - 2015-10-06 ##
### Added
Inline content support

## [1.0.3] - 2015-10-01 ##
### Fixed
Payload 'to' attribute fix for smtpapi