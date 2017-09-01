# Change Log
All notable changes to this project will be documented in this file.

## [5.1.0] - 2017-9-1 ##
### Added
- #173: Update ruby-http-client dependency
- [#12](https://github.com/sendgrid/ruby-http-client/pull/12) Add a helper that returns the response body as a hash via the `parsed_body` method in the `Response` object.
- Thanks to [Diego Camargo](https://github.com/belfazt) for the pull request!

## [5.0.0] - 2017-05-27
### BREAKING CHANGE
- #108 Fix unexpected `Mail` `#categories`, `#categories=` behavior
- Fixed Issue #95 Refactor Mail Helper Array Assignments
- `personalization.to` becomes `personalization.add_to()`
- `personalization.cc` becomes `personalization.add_cc()`
- `personalization.bcc` becomes `personalization.add_bcc()`
- `personalization.headers` becomes `personalization.add_header()`
- `personalization.substitutions` becomes `personalization.add_substitution()`
- `personalization.custom_args` becomes `personalization.add_custom_arg()`
- `mail.personalizations` becomes `mail.add_personalization()`
- `mail.contents` becomes `mail.add_content()`
- `mail.attachments` becomes `mail.add_attachment()`
- `mail.sections` becomes `mail.add_section()`
- `mail.headers` becomes `mail.add_header()`
- `mail.categories` becomes `mail.add_category()`
- `mail.custom_args` becomes `mail.custom_args()`
- For a full example of usage, please [see here](https://github.com/sendgrid/sendgrid-ruby/blob/master/examples/helpers/mail/example.rb#L21).

## [4.3.3] - 2017-5-2
### Update
- #157: Specify required ruby version as '>= 2.2'
- This library does not support [Ruby 2.1 or below](https://www.ruby-lang.org/en/news/2017/04/01/support-of-ruby-2-1-has-ended/).
- Thanks to [Ryunosuke Sato](https://github.com/tricknotes) for the pull request!

## [4.3.2] - 2017-5-1 ##
### Fixes
- #161: Fixed problematic Sinatra dependency
- Brings back Rails 4 compatibility (and Rack 1.x applications, in general), also removes release candidate version constraint (both broken in #160). Moreover, ensures that tests are run against two major Sinatra versions, which should protect from compatibility issues in future, somewhat. Related issue: #159.
- Thanks to [Sebastian Skałacki](https://github.com/skalee) for the pull request!

## [4.3.1] - 2017-4-12 ##
### Fixes
- #160: Updated sinatra version to 2.0
- Fixes bundler dependency issues with rails >5.0 and rack 2.0. Solves #159
- Thanks to [gkats](https://github.com/gkats) for the pull request!

## [4.3.0] - 2017-4-12 ##
### Added
- #70: Adds an account settings management helper object
- See the [helper README](https://github.com/sendgrid/sendgrid-ruby/tree/master/lib/sendgrid/helpers/settings) for details
- Thanks to [Kyle Kern](https://github.com/kernkw) for the pull request!

## [4.2.1] - 2017-4-10 ##
### Fixed
- #112: Fixes version ambiguity in gemspec
- Thanks to [Chris McKnight](https://github.com/cmckni3) for the pull request!

## [4.2.0] - 2017-4-10 ##
### Added
- #148: Set api_key to empty string
- This makes creating an API key for a SendGrid subuser who does not have an API key easier. See #146 for details
- Thanks to [Adam Beck](https://github.com/Gwash3189) for the pull request!

## [4.1.1] - 2017-4-6 ##
### Fixed
- #115 #134: Fix typos in initialize methods
- Thanks to [Ben Jackson](https://github.com/benjackson84) for the pull request!

## [4.1.0] - 2017-4-6 ##
### Add
- #144: Add [Inbound Email Parse Webhook](https://sendgrid.com/docs/API_Reference/Webhooks/inbound_email.html) support
- Thanks to [Wataru Sato](https://github.com/awwa) for the pull request!

## [4.0.8] - 2017-2-17 ##
### Add
- Solves #147: Add User Agent string

## [4.0.7] - 2017-1-25 ##
### Fixes
- [Pull Request #7](https://github.com/sendgrid/ruby-http-client/pull/7)
- Fixes [issue #6](https://github.com/sendgrid/ruby-http-client/issues/6): TLS certificates not verified
- Thanks to [Koen Rouwhorst](https://github.com/koenrh) for the pull request!

## [4.0.6] - 2016-10-18 ##
### Added
- Pull #113: Fix Travis CI Prism functionality for non-SendGrid contributors, update deprecated File.exists

## [4.0.5] - 2016-10-17 ##
### Added
- Pull #110, fixed Issue #109
- Automates StopLight.io Prism mock server locally & on Travis CI
- Thanks to [KY](https://github.com/tkbky) for the pull request!

## [4.0.4] - 2016-09-15 ##
### Fixed
- Pull #72: [remove unnecessary ruby 2.2 requirement](https://github.com/sendgrid/sendgrid-ruby/pull/72)
- Thanks to [Billy Watson](https://github.com/billywatson) for the pull request!

## [4.0.3] - 2016-08-24 ##
### Added
- Table of Contents in the README
- Added a [USE_CASES.md](https://github.com/sendgrid/sendgrid-ruby/blob/master/USE_CASES.md) section, with the first use case example for transactional templates

## [4.0.2] - 2016-07-26 ##
### Fixed
- Example and USAGE DELETE calls were missing example payloads

## [4.0.1] - 2016-07-25 ##
### Added
- [Troubleshooting](https://github.com/sendgrid/sendgrid-ruby/blob/master/TROUBLESHOOTING.md) section

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
