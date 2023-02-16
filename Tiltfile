docker_build('httpbin:latest', './httpbin')
k8s_yaml('./httpbin/manifest.yml')
local_resource("tunnel", cmd="make tunnel")
