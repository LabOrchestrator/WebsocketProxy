VERSION := $(shell python3 setup.py --version)


pypi-build:
	rm -Rf dist/*
	python3 -m build

pypi-push-testing:
	python3 -m twine upload --repository testpypi dist/*

pypi-push:
	python3 -m twine upload --repository pypi dist/*

install-dev:
	python3 -m pip install --upgrade build
	python3 -m pip install --upgrade twine

git-tag:
	git tag "v$(VERSION)"

git-release:
	git push
	git push --tags

docker-build:
	docker build -t biolachs2/lab_orchestrator_ws_proxy:v$(VERSION) .
	docker build -t biolachs2/lab_orchestrator_ws_proxy:latest .

docker-push:
	docker push biolachs2/lab_orchestrator_ws_proxy:v$(VERSION)
	docker push biolachs2/lab_orchestrator_ws_proxy:latest

release: docker-build pypi-build git-tag docker-push pypi-push git-release

