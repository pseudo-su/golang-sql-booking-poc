include tools/tools.mk

### Dependencies - manage project and tool dependencies

## Install dependencies
deps.install: deps.app.install deps.tools.install
.PHONY: deps.install

## Update dependencies
deps.update: deps.app.update deps.tools.update
.PHONY: deps.update

## Upgrade dependencies
deps.upgrade: deps.app.upgrade deps.tools.upgrade
.PHONY: deps.upgrade

## Install app dependencies
deps.app.install:
	# Golang dependencies (go.mod, go.sum)
	go mod download
.PHONY: deps.app.install

## Update app dependencies
deps.app.update:
	# Golang dependencies (go.mod, go.sum)
	go get ./...
	go mod tidy
.PHONY: deps.app.update

## Upgrade app dependencies
deps.app.upgrade:
	# Golang dependencies (go.mod, go.sum)
	go get -u ./...
	go mod tidy
.PHONY: deps.app.upgrade

## Install tool dependencies
deps.tools.install: tools/golangci-lint tools/plantuml.jar tools/migrate
.PHONY: deps.tools.install

## Update tool dependencies
deps.tools.update:
.PHONY: deps.tools.update

## Upgrade tool dependencies
deps.tools.upgrade:
.PHONY: deps.tools.upgrade

### Verify - Code verifiation and static analysis

## Run code verification
verify:
	# Golang static analysis
	./tools/golangci-lint run -v ./...
.PHONY: verify

## Run code verifiation and automatically apply fixes where possible
verify.fix:
	./tools/golangci-lint run --fix ./...
.PHONY: verify.fix

## Verify empty commit diff after codegen
verify.empty-git-diff:
	./scripts/verify-empty-git-diff.sh
.PHONY: verify.empty-git-diff

### Test

## Run unit tests
test.unit:
	go test -v -p 5 -count=1 ./internal/...
.PHONY: test.unit

## Run integration tests
test.integration:
	echo "TODO: Add integration tests"
.PHONY: test.integration

### Code generation

## Run all code generation
codegen: codegen.docs codegen.go
.PHONY: codegen

## Run docs code generation
codegen.docs:
	./scripts/generate-docs.sh
.PHONY: codegen.docs

## Run Golang code generation
codegen.go:
	go generate ./...
.PHONY: codegen.go
