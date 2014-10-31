elpa: *.el
	@version=`grep -o "Version: .*" maven-test-mode.el | cut -c 10-`; \
	dir=maven-test-mode-$$version; \
	mkdir -p "$$dir"; \
	cp -r maven-test-mode.el maven-test-mode-$$version; \
	echo "(define-package \"maven-test-mode\" \"$$version\" \
	\"Utilities for running maven tests\")" \
	> "$$dir"/maven-test-mode-pkg.el; \
	tar cvf maven-test-mode-$$version.tar "$$dir"

clean:
	@rm -rf maven-test-mode-*/ maven-test-mode-*.tar *.elc
