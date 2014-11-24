EMACS := emacs
CURL := curl --silent

S_URL=https://raw.githubusercontent.com/magnars/s.el/master/s.el

.PHONY: test

elpa: *.el
	@version=`grep -o "Version: .*" maven-test-mode.el | cut -c 10-`; \
	dir=maven-test-mode-$$version; \
	mkdir -p "$$dir"; \
	cp -r maven-test-mode.el maven-test-mode-$$version; \
	echo "(define-package \"maven-test-mode\" \"$$version\" \
	\"Utilities for running maven tests\")" \
	> "$$dir"/maven-test-mode-pkg.el; \
	tar cvf maven-test-mode-$$version.tar "$$dir"

test: .downloads
	${EMACS} -Q --batch -L .  -L ./tests \
		-l tests/maven-test-mode-test-fixture \
		-l tests/maven-test-mode-test-helpers \
		-l tests/maven-test-mode-test-commands \
		-l tests/maven-test-mode-test-toggle \
		--eval "(ert-run-tests-batch-and-exit '(not (tag interactive)))"

.downloads:
	${CURL} ${S_URL} > s.el
	touch .downloads

clean:
	@rm -rf maven-test-mode-*/ maven-test-mode-*.tar *.elc
