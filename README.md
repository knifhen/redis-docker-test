# Requirements
 - docker
 - [terraform](https://www.terraform.io/downloads.html)

# Run

```
terraform plan && terraform apply
```

## docker host ip != 127.0.0.1
For example using docker-machine on a mac.

```
export TF_VAR_docker_host=192.168.99.100 && terraform plan && terraform apply
```