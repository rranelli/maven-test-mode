(require 'maven-test-mode-test-fixture)

(ert-deftest test-is-test-file-p-true ()
  (with-temp-buffer
    (find-file app-test-file)
    (should (maven-test-is-test-file-p))))

(ert-deftest test-is-test-file-p-false ()
  (with-temp-buffer
    (find-file app-file)
    (should-not (maven-test-is-test-file-p))))

(ert-deftest test-target-filename-from-class ()
  (with-temp-buffer
    (find-file app-file)
    (should (equal
	     app-test-file
	     (maven-test-toggle-get-target-filename)))))

(ert-deftest test-target-filename-from-test ()
  (with-temp-buffer
    (find-file app-test-file)
    (should (equal
	     app-file
	     (maven-test-toggle-get-target-filename)))))

(ert-deftest test-maven-test-root-dir ()
  (with-temp-buffer
    (find-file app-test-file)
    (should (equal
	     pom-dir
	     (maven-test-root-dir)))))

(ert-deftest test-toggle-same-window ()
  (with-temp-buffer
    (find-file app-file)
    (maven-test-toggle-between-test-and-class)
    (should (equal
	     (buffer-file-name)
	     app-test-file))))

(ert-deftest test-toggle-other-window ()
  (with-temp-buffer
    (find-file app-file)
    (maven-test-toggle-between-test-and-class-other-window)
    (should (equal
	     (buffer-file-name)
	     app-test-file))
    (other-window -1)
    (should (equal
	     (buffer-file-name)
	     app-file))))

(provide 'maven-test-mode-test-toggle)
;;; maven-test-mode-test-toggle.el ends here.
