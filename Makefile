.DEFAULT_GOAL := help

.PHONY: help ## stole from Todd, i don't bash this good
help:
	@printf "\033[96mMAKE STUFF\033[0m\n\n" 
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

.PHONY: production
production: ## build for production
	@./src/build

.PHONY: development
development: ## build for local viewing
	@./src/build local

