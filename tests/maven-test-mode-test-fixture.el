(require 'maven-test-mode)

(defvar pom-dir
  (expand-file-name "tests/dummy/" default-directory))

(defvar app-file
  (expand-file-name "src/main/java/dummy/group/App.java" pom-dir))

(defvar app-test-file
  (expand-file-name "src/test/java/dummy/group/AppTest.java" pom-dir))

(provide 'maven-test-mode-test-fixture)
