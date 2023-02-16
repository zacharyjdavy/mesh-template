SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

.PHONY: containerize
containerize:
	@docker build . --tag httpbin:latest

.PHONY: publish
publish:
	@kubectl apply -f manifest.yml
