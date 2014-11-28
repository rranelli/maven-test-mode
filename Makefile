EMACS := emacs
CURL := curl --silent

S_URL=https://raw.githubusercontent.com/magnars/s.el/master/s.el

.PHONY: test

package: *.el
	@ver=`grep -o "Version: .*" maven-test-mode.el | cut -c 10-`; \
	tar cjvf maven-test-mode-$$ver.tar.bz2 --mode 644 `git ls-files '*.el' | xargs`

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
