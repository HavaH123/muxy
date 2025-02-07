TEST?=./...

default: test

bin:
	@sh -c "$(CURDIR)/scripts/build.sh"

dev:
	@TF_DEV=1 sh -c "$(CURDIR)/scripts/build.sh"

package:
	@TF_DEV=1 sh -c "$(CURDIR)/scripts/package.sh"

test:
	"$(CURDIR)/scripts/test.sh"

testrace:
	go test -race $(TEST) $(TESTARGS)

updatedeps:
	go get -u github.com/mitchellh/gox
	go get -u golang.org/x/tools/cmd/stringer
	go list ./... \
		| xargs go list -f '{{join .Deps "\n"}}' \
		| grep -v github.com/havah123/muxy \
		| grep -v '/internal/' \
		| sort -u \
		| xargs go get -f -u -v

.PHONY: bin default dev test updatedeps
