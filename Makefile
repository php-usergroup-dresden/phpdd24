.SILENT:
.PHONY: help

# Based on https://gist.github.com/prwhite/8168133#comment-1313022

## This help screen
help:
	printf "Available commands\n\n"
	awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "\033[33m%-40s\033[0m %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

## Install bundler
bundler-install:
	gem install bundler
.PHONY: bundler-install

## Update Bundler
bundler-update:
	gem update bundler
.PHONY: bundler-update

## Update rubygems
gems-update:
	gem update --system
.PHONY: gems-update

## Update bundle packages
update: bundler-update gems-update
	bundle update github-pages
.PHONY: update

## Install bundle packages
install: bundler-install bundler-update gems-update
	bundle install
.PHONY: install

## Build website
build:
	bundle exec jekyll build
.PHONY: build

## Serve website
serve:
	bundle exec jekyll serve
.PHONY: serve