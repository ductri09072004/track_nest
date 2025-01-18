
# Track Nest

A Flutter project created by [Very Good Cli](https://cli.vgv.dev/) 🤖

Track Nest is a finance tracker application that will help you manage your balance. It was designed with local access only so you don't have to worry about your information leaking out 😊

## Table of Content

- [Feature](https://github.com/ductri09072004/track_nest/tree/dev?tab=readme-ov-file#features)
- [Getting Started](https://github.com/ductri09072004/track_nest/tree/dev?tab=readme-ov-file#getting-started)
- [Run Project](https://github.com/ductri09072004/track_nest/tree/dev?tab=readme-ov-file#run-project)
- [Running Tests](https://github.com/ductri09072004/track_nest/tree/dev?tab=readme-ov-file#running-tests)
- [Note](https://github.com/ductri09072004/track_nest/tree/dev?tab=readme-ov-file#note)
- [Merge, Branch and Commit Rules](https://github.com/ductri09072004/track_nest/tree/dev?tab=readme-ov-file#merge-branch-and-commit-rules)

## Features

- Add expenses and income
- Scan bill to add quickly
- Split the bill with multiple people
- Manage categories easily
- No need to log in or register
- Cross-platform

## Getting Started

Before installing my project, you need to install the following things.

1. Install [Node.Js](https://nodejs.org/en) use the following commands:

```sh
# Download and install Chocolatey:
powershell -c "irm https://community.chocolatey.org/install.ps1|iex"

# Download and install Node.js:
choco install nodejs-lts --version="22"

# Verify the Node.js version:
node -v # Should print "v22.13.0".

# Verify npm version:
npm -v # Should print "10.9.2".
```

2. Install [Flutter](https://flutter.dev/)

3. Install [Very Good Cli](https://cli.vgv.dev/)

```bash
dart pub global activate very_good_cli
```

## Run Project

After installing all the following above it's time for the next step

1. Clone the project

```bash
  git clone https://github.com/ductri09072004/track_nest.git
```

2. Go to the project directory

```bash
  cd track_nest
```

3. Install dependencies

```bash
  flutter pub get
```

4. Run (development)

```bash
  flutter run --flavor development --target lib/main_development.dart
```

## Running Tests

To run all unit and widget tests use the following command:

```sh
flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

## Note

### About the project environment

Because this project was created using Very Good Cli, it contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*Track_nest works on iOS, Android, Web, and Windows._

But to our fav, we only use **development** env because we don't use the other (staging and production) much, and deleting or config the project again may take us a while

### About build error format

When you create a pull request, there will be an error about build, it was about formatting the file

So to fix it, open terminal and use

```bash
dart format .
```

Then you are good to go ✨

### About revert commit

1. Use `git log` to the commit id you want to revert

2. `git revert <commit_id>` to revert to that commit

3. Commit it to remote repo

Then you are good to go ✨

## Merge, Branch and Commit Rules

### 1. Create branch

New branch always created from _**main**_ (or _**develop**_)

1. Use `git checkout main` to checkout _main_

2. To update the newest things of _main_ to local, use `git pull`

3. `git checkout -b <branch-name>` to create a new branch from _main_

\*_Note_: before push the new branch up to repo, **ALWAYS** checkout _**main**_ version on repo and local is the same (or **up-to-date**)

- `git pull origin main` to update all the newest things on _main_ to local

- up the branch to repo by `git push`

### 2. Naming branch

Following this rule

```bash
<type>/<issue_number>-<issue_title_in_english>
```

In which

_<type>_ are:

- feature: new feature
- bugfix: bug fixing when found out a bug
- hotfix: serious bug that needs to be fixed immediately on _main_
- revert: revert back to the previous commit
- update: change feature or logic available

_<issue_number>_ is the number of the issue on github, remember there is an **#** before the number

_<issue_title_in_english>_ is the name of the issue but in English

### 3. Commit name

```bash
<type>/<change content>
```

In which _<type>_ are:

- feat: A new feature
- fix: A bug fix
- docs: documentation only changes
- style: Changes that do not affect the meaning of the code (white space, formatting, missing semi-colons, etc)
- refactor: A code change that neither fixes a bug nor adds a feature
- perf: A code change that improves performance
- test: Adding missing tests or correcting existing tests
- build: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- ci: Changes to our CI configuration files and scripts
- chore: Other changes that don't modify src or test files
- revert: Reverts a previous commit
