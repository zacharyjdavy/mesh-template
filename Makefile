SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

.PHONY: init
init: runtime-init k8s-init service-mesh-init

publish-%:
	@export DOCKER_HOST=$$(limactl list docker --format 'unix://{{.Dir}}/sock/docker.sock')
	@eval $$(minikube docker-env)
	$(MAKE) -C $* containerize
	$(MAKE) -C $* publish

.PHONY: tunnel
tunnel:
	@export DOCKER_HOST=$$(limactl list docker --format 'unix://{{.Dir}}/sock/docker.sock')
	@eval $$(minikube docker-env)
	@kubectl port-forward -n istio-system service/istio-ingressgateway 8080:80

.PHONY: rm
rm: k8s-rm runtime-rm

.PHONY: runtime-init
runtime-init:
	-limactl start template://docker-rootful --name=docker --tty=false

.PHONY: k8s-init
k8s-init:
	@export DOCKER_HOST=$$(limactl list docker --format 'unix://{{.Dir}}/sock/docker.sock')
	-minikube start --driver=docker

.PHONY: service-mesh-init
service-mesh-init:
	@istioctl install --set profile=demo -y
	@kubectl label namespace default istio-injection=enabled

.PHONY: k8s-rm
k8s-rm: k8s-stop
	-minikube delete

.PHONY: runtime-rm
runtime-rm: runtime-stop
	@limactl rm docker

.PHONY: k8s-stop
k8s-stop:
	-export DOCKER_HOST=$$(limactl list docker --format 'unix://{{.Dir}}/sock/docker.sock')
	-minikube stop

.PHONY: runtime-stop
runtime-stop:
	-limactl stop docker
