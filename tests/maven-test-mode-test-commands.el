;;; Code:
(require 'maven-test-mode-test-fixture)

;;
;;; Compilation Commands
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
	      "cd %s && mvn test -q -Dtest='%s';EC=$?; if [[ $EC != 0 && -d %starget/surefire-reports/ ]]; then cat %starget/surefire-reports/*.txt; exit $EC; fi"
	      pom-dir
	      (file-name-base app-test-file)
	      pom-dir
	      pom-dir)))))

(ert-deftest test-method-command-csharp-style-braces ()
  (let* ((method-name (format
		       "%s#testWithBracesRightAfter"
		       (file-name-base app-test-file))))
    (with-temp-buffer
      (find-file app-test-file)
      (goto-char (point-max))
      (should (equal
	       (maven-test-method-command)
	       (format
		"cd %s && mvn test -q -Dtest='%s';EC=$?; if [[ $EC != 0 && -d %starget/surefire-reports/ ]]; then cat %starget/surefire-reports/*.txt; exit $EC; fi"
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
		"cd %s && mvn test -q -Dtest='%s';EC=$?; if [[ $EC != 0 && -d %starget/surefire-reports/ ]]; then cat %starget/surefire-reports/*.txt; exit $EC; fi"
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
		"cd %s && mvn test -q -Dtest='%s';EC=$?; if [[ $EC != 0 && -d %starget/surefire-reports/ ]]; then cat %starget/surefire-reports/*.txt; exit $EC; fi"
		pom-dir
		method-name
		pom-dir
		pom-dir))))))

(ert-deftest test-method-command-kotlin-style-no-spaces ()
  (let* ((fname (expand-file-name "src/test/java/dummy/group/AppTest.kt" pom-dir))
	       (fname-base (file-name-base fname))
	       (method-name (format "%s#testNoSpaces" fname-base)))
    (with-temp-buffer
      (find-file fname)
      (goto-char (point-min))
      (re-search-forward "testNoSpaces")
      (should (equal
	             (maven-test-method-command)
	             (format
		            "cd %s && mvn test -q -Dtest='%s';EC=$?; if [[ $EC != 0 && -d %starget/surefire-reports/ ]]; then cat %starget/surefire-reports/*.txt; exit $EC; fi"
		            pom-dir
		            method-name
		            pom-dir
		            pom-dir))))))

(ert-deftest test-method-command-kotlin-style-no-spaces-no-brace ()
  (let* ((fname (expand-file-name "src/test/java/dummy/group/AppTest.kt" pom-dir))
	       (fname-base (file-name-base fname))
	       (method-name (format "%s#testNoSpacesNoBrace" fname-base)))
    (with-temp-buffer
      (find-file fname)
      (goto-char (point-min))
      (re-search-forward "testNoSpacesNoBrace")
      (should (equal
	             (maven-test-method-command)
	             (format
		            "cd %s && mvn test -q -Dtest='%s';EC=$?; if [[ $EC != 0 && -d %starget/surefire-reports/ ]]; then cat %starget/surefire-reports/*.txt; exit $EC; fi"
		            pom-dir
		            method-name
		            pom-dir
		            pom-dir))))))

(ert-deftest test-method-command-kotlin-style-with-spaces ()
  (let* ((fname (expand-file-name "src/test/java/dummy/group/AppTest.kt" pom-dir))
	       (fname-base (file-name-base fname))
	       (method-name (format "%s#test with spaces" fname-base)))
    (with-temp-buffer
      (find-file fname)
      (goto-char (point-min))
      (re-search-forward "test with spaces")
      (should (equal
	             (maven-test-method-command)
	             (format
		            "cd %s && mvn test -q -Dtest='%s';EC=$?; if [[ $EC != 0 && -d %starget/surefire-reports/ ]]; then cat %starget/surefire-reports/*.txt; exit $EC; fi"
		            pom-dir
		            method-name
		            pom-dir
		            pom-dir))))))

(ert-deftest test-method-command-kotlin-style-with-spaces-no-brace ()
  (let* ((fname (expand-file-name "src/test/java/dummy/group/AppTest.kt" pom-dir))
	       (fname-base (file-name-base fname))
	       (method-name (format "%s#test with spaces and no braces" fname-base)))
    (with-temp-buffer
      (find-file fname)
      (goto-char (point-min))
      (re-search-forward "test with spaces and no braces")
      (should (equal
	             (maven-test-method-command)
	             (format
		            "cd %s && mvn test -q -Dtest='%s';EC=$?; if [[ $EC != 0 && -d %starget/surefire-reports/ ]]; then cat %starget/surefire-reports/*.txt; exit $EC; fi"
		            pom-dir
		            method-name
		            pom-dir
		            pom-dir))))))
