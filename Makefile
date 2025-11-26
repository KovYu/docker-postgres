CLI_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
$(eval $(sort $(subst :,\:,$(CLI_ARGS))):;@:)

ifeq ($(MAKECMDGOALS),)
PRIMARY_GOAL := help
else
PRIMARY_GOAL := $(firstword $(MAKECMDGOALS))
endif

include .env

export COMPOSE_PROJECT_NAME=${STACK_NAME}
DOCKER_COMPOSE := docker compose

#
# Development
#

ifeq ($(PRIMARY_GOAL),build)
build: ## Build docker images
	$(DOCKER_COMPOSE) build $(CLI_ARGS)
endif

ifeq ($(PRIMARY_GOAL),up)
up: ## Up the db environment
	$(DOCKER_COMPOSE) up -d --remove-orphans
endif

ifeq ($(PRIMARY_GOAL),down)
down: ## Down the db environment
	$(DOCKER_COMPOSE) down --remove-orphans
endif

ifeq ($(PRIMARY_GOAL),stop)
stop: ## Stop the db environment
	$(DOCKER_COMPOSE) stop
endif

ifeq ($(PRIMARY_GOAL),clear)
clear: ## Remove development docker containers and volumes
	$(DOCKER_COMPOSE) down --volumes --remove-orphans
endif

#
# Other
#

ifeq ($(PRIMARY_GOAL),help)
# Output the help for each task, see https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
endif
