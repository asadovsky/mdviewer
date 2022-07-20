SHELL := /bin/bash -euo pipefail
PATH := node_modules/.bin:$(PATH)
TMPDIR := $(shell mktemp -d "/tmp/XXXXXX")

.DELETE_ON_ERROR:

node_modules: package.json
	yarn install
	touch $@

dist: content.css content.js manifest.json node_modules
	@rm -rf $@
	@mkdir -p $@
	browserify content.js -d -o $@/bundle.min.js
	cp node_modules/github-markdown-css/github-markdown.css $@
	cp content.css manifest.json $@
	touch $@

mdviewer.zip: dist
	zip $@ $</*

# https://www.madboa.com/geek/openssl/#cert-self
mdviewer.crx: dist
	openssl req -x509 -nodes -days 365 -subj '/C=US/ST=California' -newkey rsa:1024 -keyout "$(TMPDIR)/mykey.pem" -out "$(TMPDIR)/mycert.pem"
	./crxmake.sh dist "$(TMPDIR)/mykey.pem"
	mv dist.crx $@

.PHONY: clean
clean:
	rm -rf dist node_modules

.PHONY: lint
lint: node_modules
	jshint .
