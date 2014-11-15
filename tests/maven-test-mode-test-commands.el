(require 'maven-test-mode-test-fixture)

;;; Basic stuff
;;
(ert-deftest test-task-concatenates-options ()
  (let ((maven-test-test-task-options "-Dtest=my-test and more stuff"))
    (should (equal
	     (maven-test--test-task)
	     "test -Dtest=my-test and more stuff"))))

(ert-deftest test-task-concatenates-options-has-no-sideffects ()
  (should (equal
	   maven-test-test-task-options
	   "-q")))

(ert-deftest test-maven-root-dir ()
  (with-temp-buffer
    (find-file app-file)
    (should (equal
	     (maven-test-root-dir)
	     pom-dir))))

;;; Commands
;;
(ert-deftest test-all-command ()
  (with-temp-buffer
    (find-file app-file)
    (should (equal
	     (maven-test-all-command)
	     (format
	      "cd %s && mvn test -q;EC=$?; if [[ $EC != 0 && -d %starget/surefire-reports/ ]]; then cat %starget/surefire-reports/*.txt; exit $EC; fi"
	      pom-dir
	      pom-dir
	      pom-dir)))))

(ert-deftest test-file-command ()
  (with-temp-buffer
    (find-file app-test-file)
    (should (equal
	     (maven-test-file-command)
	     (format
	      "cd %s && mvn test -q -Dtest=%s;EC=$?; if [[ $EC != 0 && -d %starget/surefire-reports/ ]]; then cat %starget/surefire-reports/*.txt; exit $EC; fi"
	      pom-dir
	      (file-name-base app-test-file)
	      pom-dir
	      pom-dir)))))

(ert-deftest test-method-command-csharp-style-braces ()
  (let* ((method-name (format "%s#testWithBracesRightAfter" (file-name-base app-test-file))))
    (with-temp-buffer
      (find-file app-test-file)
      (goto-char (point-max))
      (should (equal
	       (maven-test-method-command)
	       (format
		"cd %s && mvn test -q -Dtest=%s;EC=$?; if [[ $EC != 0 && -d %starget/surefire-reports/ ]]; then cat %starget/surefire-reports/*.txt; exit $EC; fi"
		pom-dir
		method-name
		pom-dir
		pom-dir))))))

(ert-deftest test-method-command-java-style-braces ()
  (let* ((fname (expand-file-name "src/test/java/dummy/group/AppTest.java" pom-dir))
	 (fname-base (file-name-base fname))
	 (method-name (format "%s#testApp" fname-base)))
    (with-temp-buffer
      (find-file fname)
      (goto-char (point-min))
      (re-search-forward "placeholder")
      (should (equal
	       (maven-test-method-command)
	       (format
		"cd %s && mvn test -q -Dtest=%s;EC=$?; if [[ $EC != 0 && -d %starget/surefire-reports/ ]]; then cat %starget/surefire-reports/*.txt; exit $EC; fi"
		pom-dir
		method-name
		pom-dir
		pom-dir))))))

(ert-deftest test-method-command-scala-style ()
  (let* ((fname (expand-file-name "src/test/java/dummy/group/AppTest.scala" pom-dir))
	 (fname-base (file-name-base fname))
	 (method-name (format "%s#shouldReportAnError" fname-base)))
    (with-temp-buffer
      (find-file fname)
      (goto-char (point-max))
      (should (equal
	       (maven-test-method-command)
	       (format
		"cd %s && mvn test -q -Dtest=%s;EC=$?; if [[ $EC != 0 && -d %starget/surefire-reports/ ]]; then cat %starget/surefire-reports/*.txt; exit $EC; fi"
		pom-dir
		method-name
		pom-dir
		pom-dir))))))

;;; Toggle functions
;;
;; TODO: Write these tests
