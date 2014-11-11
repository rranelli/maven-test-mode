(require 'maven-test-mode)

(ert-deftest test-task-concatenates-options ()
  (setq maven-test-test-task-options "-Dtest=my-test and more stuff")
  (should (equal
	   (maven-test--test-task)
	   "test -Dtest=my-test and more stuff")))

(ert-deftest test-task-concatenates-options-has-no-sideffects ()
  (should (equal
	   maven-test-test-task-options
	   "-q")))

(ert-deftest test-all-command ()
  (should (equal
	   (maven-test-all-command)
	   "cd ~/code/engsoft-progressoes/ && mvn test -q;EC=$?; if [[ $EC != 0 && -d ~/code/engsoft-progressoes/target/surefire-reports/ ]]; then cat ~/code/engsoft-progressoes/target/surefire-reports/*.txt; exit $EC; fi")))
