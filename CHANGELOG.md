# Change Log
All notable changes to this project will be documented in this file.

[2020-08-19] Version 6.3.4
--------------------------
**Library - Docs**
- [PR #319](https://github.com/sendgrid/sendgrid-ruby/pull/319): Run all the *.md files through grammar.ly service and update accordingly. Thanks to [@Sarthakagarwal22](https://github.com/Sarthakagarwal22)!
- [PR #344](https://github.com/sendgrid/sendgrid-ruby/pull/344): Update example.rb. Thanks to [@kylearoberts](https://github.com/kylearoberts)!

**Library - Chore**
- [PR #432](https://github.com/sendgrid/sendgrid-ruby/pull/432): update GitHub branch references to use HEAD. Thanks to [@thinkingserious](https://github.com/thinkingserious)!


[2020-07-22] Version 6.3.3
--------------------------
**Library - Chore**
- [PR #431](https://github.com/sendgrid/sendgrid-ruby/pull/431): migrate to new default sendgrid-oai branch. Thanks to [@eshanholtz](https://github.com/eshanholtz)!
- [PR #366](https://github.com/sendgrid/sendgrid-ruby/pull/366): add Rubocop configuration file. Thanks to [@RolandBurrows](https://github.com/RolandBurrows)!

**Library - Test**
- [PR #429](https://github.com/sendgrid/sendgrid-ruby/pull/429): fix the license test and actually run the test scripts. Thanks to [@childish-sambino](https://github.com/childish-sambino)!

**Library - Docs**
- [PR #273](https://github.com/sendgrid/sendgrid-ruby/pull/273): Create a Use Cases Directory and Associated Files. Thanks to [@alanunruh](https://github.com/alanunruh)!


[2020-07-08] Version 6.3.2
--------------------------
**Library - Test**
- [PR #368](https://github.com/sendgrid/sendgrid-ruby/pull/368): add Simplecov Local Enhancements. Thanks to [@RolandBurrows](https://github.com/RolandBurrows)!


[2020-06-25] Version 6.3.1
--------------------------


[2020-06-24] Version 6.3.0
--------------------------
**Library - Feature**
- [PR #428](https://github.com/sendgrid/sendgrid-ruby/pull/428): adds rack middleware to make request verification easier in rack apps. Thanks to [@philnash](https://github.com/philnash)!
- [PR #425](https://github.com/sendgrid/sendgrid-ruby/pull/425): verify signature from event webhook. Thanks to [@eshanholtz](https://github.com/eshanholtz)!

**Library - Fix**
- [PR #427](https://github.com/sendgrid/sendgrid-ruby/pull/427): drop the starkbank dependency. Thanks to [@childish-sambino](https://github.com/childish-sambino)!


[2020-05-13] Version 6.2.1
--------------------------
**Library - Fix**
- [PR #421](https://github.com/sendgrid/sendgrid-ruby/pull/421): migrate to common prism setup. Thanks to [@childish-sambino](https://github.com/childish-sambino)!


[2020-04-29] Version 6.2.0
--------------------------
**Library - Feature**
- [PR #417](https://github.com/sendgrid/sendgrid-ruby/pull/417): add support for Twilio Email. Thanks to [@childish-sambino](https://github.com/childish-sambino)!


[2020-04-15] Version 6.1.4
--------------------------
**Library - Fix**
- [PR #416](https://github.com/sendgrid/sendgrid-ruby/pull/416): correct the User-Agent casing. Thanks to [@childish-sambino](https://github.com/childish-sambino)!


[2020-04-01] Version 6.1.3
--------------------------
**Library - Docs**
- [PR #414](https://github.com/sendgrid/sendgrid-ruby/pull/414): support verbiage for login issues. Thanks to [@adamchasetaylor](https://github.com/adamchasetaylor)!

**Library - Chore**
- [PR #413](https://github.com/sendgrid/sendgrid-ruby/pull/413): upgrade rake dev dependency. Thanks to [@childish-sambino](https://github.com/childish-sambino)!


[2020-03-18] Version 6.1.2
--------------------------
**Library - Chore**
- [PR #337](https://github.com/sendgrid/sendgrid-ruby/pull/337): Remove unnecessary require statements. Thanks to [@moutten](https://github.com/moutten)!
- [PR #354](https://github.com/sendgrid/sendgrid-ruby/pull/354): Update Dockerfile ruby version. Thanks to [@Rovel](https://github.com/Rovel)!

**Library - Fix**
- [PR #412](https://github.com/sendgrid/sendgrid-ruby/pull/412): loosen the ruby_http_client version constraint. Thanks to [@childish-sambino](https://github.com/childish-sambino)!


[2020-03-04] Version 6.1.1
--------------------------
**Library - Docs**
- [PR #375](https://github.com/sendgrid/sendgrid-ruby/pull/375): update bug template URL. Thanks to [@divyanshu-rawat](https://github.com/divyanshu-rawat)!
- [PR #385](https://github.com/sendgrid/sendgrid-ruby/pull/385): Remove announcements (the job posting is filled?). Thanks to [@deyton](https://github.com/deyton)!

**Library - Chore**
- [PR #409](https://github.com/sendgrid/sendgrid-ruby/pull/409): bump `bundler` version to 2.1.2. Thanks to [@chhhris](https://github.com/chhhris)!
- [PR #408](https://github.com/sendgrid/sendgrid-ruby/pull/408): add Ruby 2.7 to Travis. Thanks to [@childish-sambino](https://github.com/childish-sambino)!


[2020-02-19] Version 6.1.0
--------------------------
**Library - Feature**
- [PR #405](https://github.com/sendgrid/sendgrid-ruby/pull/405): Use latest SendGrid HTTP Client. Thanks to [@saveav](https://github.com/saveav)!


[2020-01-22] Version 6.0.4
--------------------------
**Library - Fix**
- [PR #404](https://github.com/sendgrid/sendgrid-ruby/pull/404): add skip_cleanup flag to fix travis deploy. Thanks to [@thinkingserious](https://github.com/thinkingserious)!


[2020-01-22] Version 6.0.3
--------------------------
**Library - Docs**
- [PR #402](https://github.com/sendgrid/sendgrid-ruby/pull/402): baseline all the templated markdown docs. Thanks to [@childish-sambino](https://github.com/childish-sambino)!


[2020-01-08] Version 6.0.2
--------------------------
**Library - Fix**
- [PR #401](https://github.com/sendgrid/sendgrid-ruby/pull/401): Only try to deploy once to rubygems. Thanks to [@thinkingserious](https://github.com/thinkingserious)!


[2020-01-03] Version 6.0.1
--------------------------
**Library - Chore**
- [PR #400](https://github.com/sendgrid/sendgrid-ruby/pull/400): Add auto-deploy to travis.yml. Thanks to [@thinkingserious](https://github.com/thinkingserious)!
- [PR #399](https://github.com/sendgrid/sendgrid-ruby/pull/399): Add testing to Makefile. Thanks to [@thinkingserious](https://github.com/thinkingserious)!
- [PR #396](https://github.com/sendgrid/sendgrid-ruby/pull/396): Adding Makefile to assist with automation. Thanks to [@thinkingserious](https://github.com/thinkingserious)!

**Library - Fix**
- [PR #321](https://github.com/sendgrid/sendgrid-ruby/pull/321): TROUBLESHOOTING.md broken link fix. Thanks to [@arshadkazmi42](https://github.com/arshadkazmi42)!


[2019-06-04] Version 6.0.0
--------------------------
### BREAKING CHANGE
- [PR #284](https://github.com/sendgrid/sendgrid-ruby/pull/284): The sinatra gem is no longer specified as a dependency of this gem. If you would like to use the inbound processing, please follow the [upgrade guide](UPGRADE.md). Big thanks to [@jjb](https://github.com/jjb) for the PR!

### Added
- [PR #271](https://github.com/sendgrid/sendgrid-ruby/pull/271): Add ability to impersonate a subuser. Big thanks to [@danilospa](https://github.com/danilospa) for the PR!
- [PR #278](https://github.com/sendgrid/sendgrid-ruby/pull/278): Make SendGrid permissions management easy. Big thanks to [@sony-mathew](https://github.com/sony-mathew) for the PR!
- [PR #343](https://github.com/sendgrid/sendgrid-ruby/pull/343) and [PR #345](https://github.com/sendgrid/sendgrid-ruby/pull/345): Update README.md with examples for dynamic templates and corrections to the old legacy template example. Big thanks to [@kylearoberts](https://github.com/kylearoberts) for the PR!
- [PR #216](https://github.com/sendgrid/sendgrid-ruby/pull/216): Get unassigned IPs example. Big thanks to [@cristianossd](https://github.com/cristianossd) for the PR!
- [PR #231](https://github.com/sendgrid/sendgrid-ruby/pull/231): Add support for IO objects set as Attachment content. Big thanks to [@awj](https://github.com/awj) for the PR!
- [PR #232](https://github.com/sendgrid/sendgrid-ruby/pull/232): Add method to check email content for secret keys. Big thanks to [@jaredsilver](https://github.com/jaredsilver) for the PR!
- [PR #236](https://github.com/sendgrid/sendgrid-ruby/pull/236): Add an IpManagement helper. Big thanks to [@brokenthumbs](https://github.com/brokenthumbs) for the PR!
- [PR #264](https://github.com/sendgrid/sendgrid-ruby/pull/264): Add Email Statistics helper example. Big thanks to [@jeremyjung](https://github.com/jeremyjung) for the PR!
- [PR #246](https://github.com/sendgrid/sendgrid-ruby/pull/246): Modified Mail Class calling examples with SendGrid::Mail. Big thanks to [@rohan-techfreak](https://github.com/rohan-techfreak) for the PR!
- [PR #268](https://github.com/sendgrid/sendgrid-ruby/pull/268): Added Code Review to CONTRIBUTING.md. Big thanks to [@mptap](https://github.com/mptap) for the PR!
- [PR #276](https://github.com/sendgrid/sendgrid-ruby/pull/276): Codebase Improvement: Use attr_accessor instead of getters and setters. Big thanks to [@rahul26goyal](https://github.com/rahul26goyal) for the PR!
- [PR #365](https://github.com/sendgrid/sendgrid-ruby/pull/365): Add our Developer Experience Engineer career opportunity to the README. Big thanks to [@mptap](https://github.com/mptap) for the PR!

### Fixes
- [PR #262](https://github.com/sendgrid/sendgrid-ruby/pull/262): Fix CONTRIBUTING.md formatting. Big thanks to [@thepriefy](https://github.com/thepriefy) for the PR!
- [PR #277](https://github.com/sendgrid/sendgrid-ruby/pull/277): Fix travis warning. Big thanks to [@rahul26goyal](https://github.com/rahul26goyal) for the PR!
- [PR #303](https://github.com/sendgrid/sendgrid-ruby/pull/303): Update readme tags and fix minor test failures. Big thanks to [@af4ro](https://github.com/af4ro) for the PR!
- [PR #370](https://github.com/sendgrid/sendgrid-ruby/pull/370): Remove references to "Whitelabel". Big thanks to [@crweiner](https://github.com/crweiner) for the PR!
- [PR #383](https://github.com/sendgrid/sendgrid-ruby/pull/383): Correct endpoint for single spam report requests. Big thanks to [@bermannoah](https://github.com/bermannoah) for the PR!

## [5.3.0] - 2018-10-12 ##
### Added
- [PR #300](https://github.com/sendgrid/sendgrid-ruby/pull/300): Support for Dynamic Templates. Big thanks to [@nedcampion](https://github.com/nedcampion) for the PR!
- [PR #178](https://github.com/sendgrid/sendgrid-ruby/pull/178): Convert key/value arguments to CustomArgs to strings. Big thanks to [@sitaramshelke](https://github.com/sitaramshelke) for the PR!
- [PR #258](https://github.com/sendgrid/sendgrid-ruby/pull/258): Added unittest to check for specific repo files. Big thanks to [@mptap](https://github.com/mptap) for the PR!
- [PR #255](https://github.com/sendgrid/sendgrid-ruby/pull/255): Add a unittest to check the license.md file date range. Big thanks to [@prashuchaudhary](https://github.com/prashuchaudhary) for the PR!
- [PR #181](https://github.com/sendgrid/sendgrid-ruby/pull/181): Add Docker. Big thanks to [@shrivara](https://github.com/shrivara) for the PR!
- [PR #248](https://github.com/sendgrid/sendgrid-ruby/pull/248): Added .codeclimate.yml. Big thanks to [@proton](https://github.com/proton) for the PR!
- [PR #260](https://github.com/sendgrid/sendgrid-ruby/pull/260): Update ruby-http-client dependency to support v3.3.0. Big thanks to [@mptap](https://github.com/mptap) for the PR!
- [PR #304](https://github.com/sendgrid/sendgrid-ruby/pull/304): Readability update for documentation. Big thanks to [@af4ro](https://github.com/af4ro) for the PR!
- [PR #306](https://github.com/sendgrid/sendgrid-ruby/pull/306): Update example to work in Rails console. Big thanks to [@RogerPodacter](https://github.com/RogerPodacter) for the PR!

### Fixes
- [PR #252](https://github.com/sendgrid/sendgrid-ruby/pull/252): Update LICENSE, set correct year. Big thanks to [@pushkyn](https://github.com/pushkyn) for the PR!
- [PR #257](https://github.com/sendgrid/sendgrid-ruby/pull/257): README.md typo fix. Big thanks to [@shucon](https://github.com/shucon) for the PR!

## [5.2.0] - 2017-10-30 ##
### Added
- PR #234: Helpers for email statistics - global, category, subuser 
- Thanks to [Awin Abi](https://github.com/awinabi) for the pull request!

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
- For a full example of usage, please [see here](examples/helpers/mail/example.rb#L21).

## [4.3.3] - 2017-5-2
### Update
- #157: Specify required ruby version as '>= 2.2'
- This library does not support [Ruby 2.1 or below](https://www.ruby-lang.org/en/news/2017/04/01/support-of-ruby-2-1-has-ended/).
- Thanks to [Ryunosuke Sato](https://github.com/tricknotes) for the pull request!

## [4.3.2] - 2017-5-1 ##
### Fixes
- #161: Fixed problematic Sinatra dependency
- Brings back Rails 4 compatibility (and Rack 1.x applications, in general), also removes release candidate version constraint (both broken in #160). Moreover, ensures that tests are run against two major Sinatra versions, which should protect from compatibility issues in the future, somewhat. Related issue: #159.
- Thanks to [Sebastian Skałacki](https://github.com/skalee) for the pull request!

## [4.3.1] - 2017-4-12 ##
### Fixes
- #160: Updated sinatra version to 2.0
- Fixes bundler dependency issues with rails >5.0 and rack 2.0. Solves #159
- Thanks to [gkats](https://github.com/gkats) for the pull request!

## [4.3.0] - 2017-4-12 ##
### Added
- #70: Adds an account settings management helper object
- See the [helper README](lib/sendgrid/helpers/settings) for details
- Thanks to [Kyle Kern](https://github.com/kernkw) for the pull request!

## [4.2.1] - 2017-4-10 ##
### Fixed
- #112: Fixes version ambiguity in gemspec
- Thanks to [Chris McKnight](https://github.com/cmckni3) for the pull request!

## [4.2.0] - 2017-4-10 ##
### Added
- #148: Set api_key to an empty string
- This makes creating an API key for a SendGrid sub-user who does not have an API key easier. See #146 for details
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
- Added a [USE_CASES.md](USE_CASES.md) section, with the first use case example for transactional templates

## [4.0.2] - 2016-07-26 ##
### Fixed
- Example and USAGE DELETE calls were missing example payloads

## [4.0.1] - 2016-07-25 ##
### Added
- [Troubleshooting](TROUBLESHOOTING.md) section

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
