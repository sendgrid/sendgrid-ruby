Hello! Thank you for choosing to help contribute to one of the Twilio SendGrid open-source libraries. There are many ways you can contribute and help is always welcome.  We simply ask that you follow the following contribution policies.

**All third-party contributors acknowledge that any contributions they provide will be made under the same open-source license that the open-source project is provided under.**
- [Feature Request](#feature-request)
- [Submit a Bug Report](#submit-a-bug-report)
  - [Please use our Bug Report Template](#please-use-our-bug-report-template)
- [Improvements to the Codebase](#improvements-to-the-codebase)
  - [Development Environment](#development-environment)
    - [Install and Run Locally](#install-and-run-locally)
      - [Prerequisites](#prerequisites)
      - [Initial setup:](#initial-setup)
  - [Environment Variables](#environment-variables)
      - [Execute:](#execute)
- [Understanding the Code Base](#understanding-the-code-base)
- [Testing](#testing)
- [Style Guidelines & Naming Conventions](#style-guidelines--naming-conventions)
- [Creating a Pull Request](#creating-a-pull-request)
- [Code Reviews](#code-reviews)

<a name="roadmap"></a>
We use [Milestones](https://github.com/sendgrid/sendgrid-ruby/milestones) to help define current roadmaps, please feel free to grab an issue from the current milestone. Please indicate that you have begun work on it to avoid collisions. Once a PR is made, community review, comments, suggestions, and additional PRs are welcomed and encouraged.

There are a few ways to contribute, which we'll enumerate below:

<a name="feature-request"></a>
## Feature Request

If you'd like to make a feature request, please read this section.

The GitHub issue tracker is the preferred channel for library feature requests, but please respect the following restrictions:

- Please **search for existing issues** in order to ensure we don't have duplicate bugs/feature requests.
- Please be respectful and considerate of others when commenting on issues

<a name="submit-a-bug-report"></a>
## Submit a Bug Report

Note: DO NOT include your credentials in ANY code examples, descriptions, or media you make public.

A software bug is a demonstrable issue in the code base. In order for us to diagnose the issue and respond as quickly as possible, please add as much detail as possible into your bug report.

Before you decide to create a new issue, please try the following:

1. Check the Github issues tab if the identified issue has already been reported, if so, please add a +1 to the existing post.
2. Update to the latest version of this code and check if an issue has already been fixed
3. Copy and fill in the Bug Report Template we have provided below

### Please use our Bug Report Template

In order to make the process easier, we've included a [sample bug report template](ISSUE_TEMPLATE.md).

<a name="improvements-to-the-codebase"></a>
## Improvements to the Codebase

We welcome direct contributions to the sendgrid-ruby code base. Thank you!

### Development Environment ###

#### Install and Run Locally ####

##### Prerequisites #####

- Ruby 2.1+
- [ruby_http_client](https://github.com/sendgrid/ruby-http-client)


##### Initial setup: #####

1. Clone the project

   ```bash
   git clone https://github.com/sendgrid/sendgrid-ruby.git
   cd sendgrid-ruby
   ```

1. Install bundler and bundle

   ```bash
   bundle install
   ```

### Environment Variables

First, get your free Twilio SendGrid account [here](https://sendgrid.com/free?source=sendgrid-ruby).

Next, update your environment with your [SENDGRID_API_KEY](https://app.sendgrid.com/settings/api_keys).

```bash
echo "export SENDGRID_API_KEY='YOUR_API_KEY'" > sendgrid.env
echo "sendgrid.env" >> .gitignore
source ./sendgrid.env
```

##### Execute: #####

See the [examples folder](examples) to get started quickly.

To run the examples using the local version of this library from the root directory of this repo, please replace:

`require 'sendgrid-ruby'`

with:

`require_relative './lib/sendgrid-ruby.rb'`

Then run using:

```bash
ruby example.rb
```

<a name="understanding-the-codebase"></a>
## Understanding the Code Base

**/examples**

Working examples that demonstrate usage.

**/test**

Tests for the mail send and Web API v3 endpoints.

**/lib**

The Web API v3 client is `sendgrid-ruby.rb`

## Testing

All PRs require passing tests before the PR will be reviewed. All test files are in the [`tests`](test) directory. For the purposes of contributing to this repo, please update the [`test_sendgrid-ruby.rb`](test/sendgrid/test_sendgrid-ruby.rb) file with unit tests as you modify the code.

The integration tests require a Twilio SendGrid mock API in order to execute. We've simplified setting this up using Docker to run the tests. You will just need [Docker Desktop](https://docs.docker.com/get-docker/) and `make`.

Once these are available, simply execute the Docker test target to run all tests: `make test-docker`. This command can also be used to open an interactive shell into the container where this library is installed. To start a *bash* shell for example, use this command: `command=bash make test-docker`.

<a name="style-guidelines-and-naming-conventions"></a>
## Style Guidelines & Naming Conventions

Generally, we follow the style guidelines as suggested by the official language. However, we ask that you conform to the styles that already exist in the library. If you wish to deviate, please explain your reasoning.

- [Community Driven Style Guide](https://github.com/bbatsov/ruby-style-guide)

Please run your code through:

- [rubocop](https://github.com/bbatsov/rubocop).

<a name="creating-a-pull-request"></a>
## Creating a Pull Request

1. [Fork](https://help.github.com/fork-a-repo/) the project, clone your fork,
   and configure the remotes:

   ```bash
   # Clone your fork of the repo into the current directory
   git clone https://github.com/sendgrid/sendgrid-ruby
   
   # Navigate to the newly cloned directory
   cd sendgrid-ruby
   
   # Assign the original repo to a remote called "upstream"
   git remote add upstream https://github.com/sendgrid/sendgrid-ruby
   ```

2. If you cloned a while ago, get the latest changes from upstream:

   ```bash
   git checkout <dev-branch>
   git pull upstream <dev-branch>
   ```

3. Create a new topic branch (off the main project development branch) to
   contain your feature, change, or fix:

   ```bash
   git checkout -b <topic-branch-name>
   ```

4. Commit your changes in logical chunks. Please adhere to these [git commit
   message guidelines](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html)
   or your code is unlikely to be merged into the main project. Use Git's
   [interactive rebase](https://help.github.com/articles/interactive-rebase)
   feature to tidy up your commits before making them public.

4a. Create tests.

4b. Create or update the example code that demonstrates the functionality of this change to the code.

5. Locally merge (or rebase) the upstream development branch into your topic branch:

   ```bash
   git pull [--rebase] upstream main
   ```

6. Push your topic branch up to your fork:

   ```bash
   git push origin <topic-branch-name>
   ```

7. [Open a Pull Request](https://help.github.com/articles/using-pull-requests/)
    with a clear title and description against the `main` branch. All tests must be passing before we will review the PR.

<a name="code-reviews"></a>
## Code Reviews

If you can, please look at open PRs and review them. Give feedback and help us merge these PRs much faster! If you don't know how, Github has some [great information on how to review a Pull Request](https://help.github.com/articles/about-pull-request-reviews/).
