include help.mk
include tools/tools.mk
include devstack/devstack.mk

deps.install: deps.app.install deps.tools.install
.PHONY: deps.install

deps.update: deps.app.update deps.tools.update
.PHONY: deps.update

deps.upgrade: deps.app.upgrade deps.tools.upgrade
.PHONY: deps.upgrade

deps.app.install:
.PHONY: deps.app.install

deps.app.update:
.PHONY: deps.app.update

deps.app.upgrade:
.PHONY: deps.app.upgrade

deps.tools.install: tools/golangci-lint tools/plantuml.jar tools/migrate
.PHONY: deps.tools.install

deps.tools.update:
.PHONY: deps.tools.update

deps.tools.upgrade:
.PHONY: deps.tools.upgrade
