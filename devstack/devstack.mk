devstack.start:
	docker-compose -f devstack/docker-compose.yml up -d --remove-orphans devstack
.PHONY: devstack.start

devstack.stop:
	docker-compose -f devstack/docker-compose.yml down --remove-orphans
.PHONY: devstack.stop

devstack.clean:
	docker-compose -f devstack/docker-compose.yml down --remove-orphans --volumes --rmi local
.PHONY: devstack.clean

devstack.restart: devstack.stop devstack.start
.PHONY: devstack.restart

devstack.recreate: devstack.clean devstack.start
.PHONY: devstack.recreate

devstack.logs:
	docker-compose -f devstack/docker-compose.yml logs --follow
.PHONY: devstack.logs
