TF_COMPOSE := "$(shell pwd)/terraform/docker-compose.yml"

build:
	yarn --cwd ./foobar-lambda run bundle

tf:
	docker-compose -f ${TF_COMPOSE} run --rm tf $(cmd)
