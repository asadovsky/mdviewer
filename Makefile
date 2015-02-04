SHELL := /bin/bash -euo pipefail
PATH := $(shell pwd):$(PATH)
TMPDIR := $(shell mktemp -d "/tmp/XXXXXX")

# https://www.madboa.com/geek/openssl/#cert-self
mdviewer.crx:
	openssl req -x509 -nodes -days 365 -subj '/C=US/ST=California' -newkey rsa:1024 -keyout "$(TMPDIR)/mykey.pem" -out "$(TMPDIR)/mycert.pem"
	crxmake.sh $(shell pwd) "$(TMPDIR)/mykey.pem"

lint:
	jshint .

.PHONY: lint
