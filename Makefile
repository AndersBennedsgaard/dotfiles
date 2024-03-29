.PHONY: lint

lint:
	yamllint . -c .github/yamllint-config.yaml
	ansible-lint
