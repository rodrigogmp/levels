# CGTrader Level System

The goal of this task is to test your ability to test, refactor and implement new functionality on a given system. Note
that this repository does not represent the actual code of CGTrader, but only acts as a testing ground.

## Tasks

1. Make sure test suite runs through all of the tests successfully. Hint: it won't at first.
2. Refactor implementation code and tests where you see fit. You have as much freedom here as you wish.
3. Implement new functionality. More details below.

## New Functionality

Imagine the situation where management assigns you a task. Management wants that the system would automatically reward
users or reduce their tax rate when they level up. Users are supposed to have a combination of rewards and privileges
based on their user level. The only privilege in this case is tax reduction. However, management is not sure if that
will always be the case, so you, as a developer, should make changes with the idea that requirements for this may change
and the functionality should be flexible.

## Notes & Requirements

* Try not to spend more than 4 hours on this task. This will constrain you not to spend too much time on trivial
details (sometimes you have to make compromises in order to deliver fast).
* You may refactor not only the code in the models, but in tests too. Keep in mind that test code is still code that
needs to be maintained.
* Use git to track your changes.
* When finished, simply zip the project and send it via e-mail.

Good luck!

## Solution

*  I've implemented privileges feature, that is associated to levels. How each user has a level, according with their experience, oce they reach any level, user automatically receives this level privileges.

* In addition to the fee reduction privilege, two others have also been implemented: earning extra coins and increasing the amount of available 3d models
  Note: Other privileges can be implemented easily, just add new items inside the enum "kind", in the model privilege.

* I had to use the following command line to run the tests: rspec spec/spec_helper.rb spec/, otherwise my database woudn't initiated, I coudn't figure out why.

* For some reason, the model lib/cgtrader_levels/models/user.rb was not found by simplecov, that's why it doesn't appear inside the converage/index.html file, despite that, I've tried to write tests to cover all the possible use cases.

