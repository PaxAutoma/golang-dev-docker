REPO=paxautoma/golang-dev
VERSION=latest
IMG=$(REPO):$(VERSION)

all:
	docker build -t $(IMG) .

publish:
	docker push $(IMG)
