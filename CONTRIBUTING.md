Thanks to [Solidus](http://github.com/solidusio/solidus) for this amazing guide!!!

## Filing an issue

When filing an issue on the ATM Locator project, please provide these details:

* A comprehensive list of steps to reproduce the issue.
* What you're *expecting* to happen compared with what's *actually* happening.
* Any relevant stack traces ("Full trace" preferred)

In 99% of cases, this information is enough to determine the cause and solution
to the problem that is being described.

Please remember to format code using triple backticks (\`) so that it is neatly
formatted when the issue is posted.

## Pull requests

We gladly accept pull requests to add documentation, fix bugs and, in some circumstances,
add new features to the ATM Locator.

Here's a quick guide:

1. Fork the repo.

2. Run the tests. We only take pull requests with passing tests, and it's great
to know that you have a clean slate.

3. Create new branch then make changes and add tests for your changes. Only
refactoring and documentation changes require no new tests. If you are adding
functionality or fixing a bug, we need tests!

4. Push to your fork and submit a pull request. If the changes will apply cleanly
to the latest stable branches and master branch, you will only need to submit one
pull request.


At this point you're waiting on us. We like to at least comment on, if not
accept, pull requests within three business days (and, typically, one business
day). We may suggest some changes or improvements or alternatives.

### Pull Request Guidelines

* The specs must pass for each individual commit.
* Each individual commit should make sense by itself as far as possible.
* Breaking up a large change into smaller (coherent) commits is encouraged.
* We do not currently have a policy about whether or not to force-push while
people are reviewing your pull request.
* Good commit messages are also encouraged. Here are some resources on writing
good commit messages:
  * [Notes from Linus](https://github.com/torvalds/subsurface/commit/b6590150d68df528efd40c889ba6eea476b39873)
  * [Erlang's guide](https://github.com/erlang/otp/wiki/Writing-good-commit-messages)
  * [An often-cited post](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html)

Some things that will increase the chance that your pull request is accepted,
taken straight from the Ruby on Rails guide:

* Use Rails idioms and helpers
* Include tests that fail without your code, and pass with it
* Update the documentation, the surrounding one, examples elsewhere, guides,
  whatever is affected by your contribution

### Follow the Coding Conventions

This is a Rails-based application.  See the [Rails coding conventions](http://guides.rubyonrails.org/contributing_to_ruby_on_rails.html#follow-the-coding-conventions).

And in case we didn't emphasize it enough: we love tests!
