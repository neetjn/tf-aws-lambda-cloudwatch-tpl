TF_COMPOSE := "$(shell pwd)/terraform/docker-compose.yml"

# experimental dockerized terraform
tf:
	docker-compose -f ${TF_COMPOSE} run --rm tf $(cmd)

# build lambda from source
build:
	yarn --cwd ./foobar-lambda run build

# create terraform plan
plan:
	terraform -chdir=terraform init
	terraform -chdir=terraform validate
	terraform -chdir=terraform plan --out=terraform.plan

# run terraform plan
deploy:
	terraform -chdir=terraform apply terraform.plan
