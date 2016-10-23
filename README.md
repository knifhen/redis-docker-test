# Requirements
 - docker
 - [terraform](https://www.terraform.io/downloads.html)

# Run

```
terraform plan && terraform apply
```

## Configure docker host ip
Solves problem with terraform
* Error pinging Docker server: Get https://127.0.0.1:2376/_ping: x509: certificate signed by unknown authority

```
export TF_VAR_docker_host=192.168.99.100
```

## Configure docker cert path
Solves problem with terraform:
Error pinging Docker server: Get http://127.0.0.1:2376/_ping: malformed HTTP response "\x15\x03\x01\x00\x02\x02"

```
DOCKER_CERT_PATH=/home/docker/.docker
```