# Change Log
All notable changes to this project will be documented in this file.

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