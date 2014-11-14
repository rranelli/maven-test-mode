# Emacs Maven test mode
[![MELPA](http://melpa.org/packages/maven-test-mode-badge.svg)](http://melpa.org/#/maven-test-mode)
[![Build Status](https://travis-ci.org/rranelli/maven-test-mode.svg)](https://travis-ci.org/rranelli/maven-test-mode)

## Intallation
You can install via `MELPA`, or manually by downloading `maven-test-mode` and
adding the following to your init file:

```lisp
(add-to-list 'load-path "/path/to/maven-test-mode")
(require 'maven-test-mode)
```

## Usage

If `maven-test-mode` is installed properly, it will be started automatically
when `java-mode` is started.

## Customization

### Output format

If you prefer the more 'verbose' `maven` output, change the default of
`maven-test-test-task-options`:

```lisp
(setq maven-test-test-task-options "")
```

### Toggling between implementation and tests

In order to map between the class file and it's test, `maven-test-mode` uses the
variable `maven-test-class-to-test-subs`. This variable specifies a list of
substitution pairs `(REPLACE . BY)` that will be applied to the class file path
in order to find the corresponding test file:

```lisp
(s-replace-all subs (buffer-file-name))
```

If your project does not comply with the default convention, you need to change
the value of this variable.

### Running test defined at point

In order to identify which test method is immediately defined before point,
`maven-test-mode` uses the regexes defined at
`maven-test-test-method-name-regexes`. If your test method definition does not
match the default regexes, you need to add your custom regex to the list with
something like:

```lisp
(add-to-list 'maven-test-test-method-name-regexes "my-special-regex")
```

## Contributing

Love Emacs? Great, help out by contributing. The easiest way
to contribute is to checkout the
[git project](https://github.com/rranelli/maven-test-mode), make a change
and then submit a pull request.

### Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Update the version and changelog in the header of rspec-mode.el to
reflect the change.
* Send me a pull request. Bonus points for topic branches.

## Acknowledgments
This package is largely inspired in
[rspec-mode](https://github.com/pezra/rspec-mode) by Peter Williams.
