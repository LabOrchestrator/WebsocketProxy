VERSION := $(shell python3 setup.py --version)

define HELP_MSG
Available Targets:
- pypi-build: Builds a pypi release.
- pypi-push-testing: Pushes a pypi release to test.pypi.org/
- pypi-push: Pushes a pypi release to pypi.org/
- git-tag: Tags the latest commit with the current version.
- git-release: Pushes all to git.
- docker-build: Builds a docker image.
- docker-push: Pushes the docker image to docker hub.
- release: Makes a release (combination of test, pypi-build, pypi-push, git-tag and git-release).
- test: Runs the unittests.
endef

export HELP_MSG


help:
	@echo "$$HELP_MSG"

pypi-build:
	rm -Rf dist/*
	python3 -m build

pypi-push-testing:
	python3 -m twine upload --repository testpypi dist/*

pypi-push:
	python3 -m twine upload --repository pypi dist/*

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

test:
	PYTHONPATH=src python3 -m unittest discover -s tests -p 'test_*.py'
