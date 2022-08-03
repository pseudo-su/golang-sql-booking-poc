tools/golangci-lint: tools/tools.cfg
	. ./tools/tools.cfg && curl -sfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b ./tools $${golangci_lint}

tools/plantuml.jar: tools/tools.cfg
	. ./tools/tools.cfg && curl -sfL http://sourceforge.net/projects/plantuml/files/plantuml.$${plantuml}.jar/download > ./tools/plantuml.jar

tools/migrate: tools/tools.cfg
	. ./tools/tools.cfg && curl -L https://github.com/golang-migrate/migrate/releases/download/$${golang_migrate}/migrate.darwin-amd64.tar.gz | tar xvz -C ./tools migrate
