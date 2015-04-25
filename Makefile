SHELL := /bin/bash -euo pipefail
PATH := $(shell pwd):node_modules/.bin:$(PATH)
TMPDIR := $(shell mktemp -d "/tmp/XXXXXX")

.DELETE_ON_ERROR:

node_modules: package.json
	npm prune
	npm install
	touch $@

# https://www.madboa.com/geek/openssl/#cert-self
mdviewer.crx:
	openssl req -x509 -nodes -days 365 -subj '/C=US/ST=California' -newkey rsa:1024 -keyout "$(TMPDIR)/mykey.pem" -out "$(TMPDIR)/mycert.pem"
	crxmake.sh $(shell pwd) "$(TMPDIR)/mykey.pem"

.PHONY: lint
lint:
	jshint .
