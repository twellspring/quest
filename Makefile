repo := rearc_quest

all: login build publish
mac: login build-mac publish

build-mac:
	docker buildx build --load --platform linux/amd64 . -t quest

build:
	docker build . -t quest

login:
	aws ecr get-login-password --region $(AWS_REGION) | \
	docker login --username AWS --password-stdin $(AWS_ACCOUNT).dkr.ecr.$(AWS_REGION).amazonaws.com

publish:
	docker tag quest:latest $(AWS_ACCOUNT).dkr.ecr.$(AWS_REGION).amazonaws.com/$(repo):latest
	docker push $(AWS_ACCOUNT).dkr.ecr.$(AWS_REGION).amazonaws.com/$(repo):latest