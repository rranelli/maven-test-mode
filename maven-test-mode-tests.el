(require 'maven-test-mode)

(ert-deftest test-task-concatenates-options ()
  (setq maven-test-test-task-options "-Dtest=my-test and more stuff")
  (should (equal
	   (maven-test--test-task)
	   "test -Dtest=my-test and more stuff")))
