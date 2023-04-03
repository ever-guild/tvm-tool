SHELL := bash

PREFIX ?= /usr/local
BINPREFIX ?= $(PREFIX)/bin

COMMANDS = \
disasm \
balance \
query

$(BINPREFIX)/tvm-%: tvm-%.sh
	cp -f $^ $@
	chmod +x $@
install: $(COMMANDS:%=$(BINPREFIX)/tvm-%)
