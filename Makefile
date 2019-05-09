.PHONY:	byo test

byo:
	@docker image build -t rawkode/telegraf:byo .

test:
	@docker image build --tag rawkode/telegraf:mine --file Dockerfile.test --build-arg VERSION=1.10 .

