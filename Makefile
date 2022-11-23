.DEFAULT: all

.PHONY: all
all: build run

.PHONY: build
build:
	docker build -t elireisman/jruby-ssl-repro:latest .

.PHONY: run
run:
	docker run -t elireisman/jruby-ssl-repro:latest
	#@docker run -it elireisman/jruby-ssl-repo:latest /bin/bash

