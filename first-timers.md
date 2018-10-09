# First Time Contributors To SendGrid Ruby

Editing SendGrid Ruby is easy!
If you see an error, a typo, or have something you would like to add, you can make your suggestion via GitHub, the content management system we use for SendGrid Ruby. Once you have submitted your suggestion, the SendGrid Ruby team can easily review it before it is published to the SendGrid Ruby repository.  

You can find [here](https://github.com/sendgrid/sendgrid-ruby/issues?q=is%3Aopen+label%3A%22difficulty%3A+easy%22+label%3A%22status%3A+help+wanted%22) a list of issues for an easy start on this repo.

To make changes to the [sendgrid-ruby](https://github.com/sendgrid/sendgrid-ruby) repository, follow these steps:

1. __Sign in your GitHub account.__  
If you do not already have a GitHub account, you will have to create one in order to suggest a change. Click the Sign up link in the upper right-hand corner to create an account. Enter your username, password, and email address. If you are an employee of SendGrid, please use your full name with your GitHub account and enter SendGrid as your company so we can easily identify you.  

<img src="/static/img/github_sign_up.png" width="800">

2. __[Fork](https://help.github.com/fork-a-repo/)__ the [sendgrid-ruby](https://github.com/sendgrid/sendgrid-ruby) repository:

<img src="/static/img/sendgrid_ruby_fork.png" width="800">

3. __Clone__ your fork via the following commands:  

    ```bash
    # Clone your fork of the repo into the current directory
    git clone https://github.com/your_username/sendgrid-ruby

    # Navigate to the newly cloned directory
    cd sendgrid-ruby

    # Assign the original repo to a remote called "upstream"
    git remote add upstream https://github.com/sendgrid/sendgrid-ruby
    ```

> Don't forget to replace *your_username* in the URL by your real GitHub username.

4. __Create a new topic branch__ (off the main project development branch) to
   contain your feature, change, or fix:

   ```bash
   git checkout -b <topic-branch-name>
   ```

5. __Commit your changes__ in logical chunks. Please adhere to these [git commit
   message guidelines](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html)
   or your code is unlikely be merged into the main project. Use Git's
   [interactive rebase](https://help.github.com/articles/interactive-rebase)
   feature to tidy up your commits before making them public.

    5a. Create tests.

    5b. Create or update the example code that demonstrates the functionality of this change to the code.

6. __Locally merge (or rebase)__ the upstream development branch into your topic branch:

   ```bash
   git pull [--rebase] upstream master
   ```

7. __Push__ your topic branch up to your fork:

   ```bash
   git push origin <topic-branch-name>
   ```

8. __[Open a Pull Request](https://help.github.com/articles/using-pull-requests/)__
    with a clear title and description against the `master` branch. All tests must be passing before we will review the PR.

> All contributors to the [sendgrid-ruby](https://github.com/sendgrid/sendgrid-ruby) repo need to sign a CLA before their changes can be merged.
