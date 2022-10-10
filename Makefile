TF_COMPOSE := "$(shell pwd)/terraform/docker-compose.yml"

build:
	yarn --cwd ./foobar-lambda run bundle

tf:
	docker-compose -f ${TF_COMPOSE} run --rm tf $(cmd)

build+deploy:
	yarn --cwd ./foobar-lambda run bundle
	terraform -chdir=terraform init
	terraform -chdir=terraform validate
	terraform -chdir=terraform plan --out=plan
	terraform -chdir=terraform apply plan
