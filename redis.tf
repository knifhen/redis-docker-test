# Configure the Docker provider
variable "docker_host" {
  default = "192.168.99.100"
}

provider "docker" {
    host = "tcp://${var.docker_host}:2376/"
}

# Create a container
resource "docker_container" "redis" {
	count = 6
    image = "${docker_image.redis.latest}"
    name = "redis${count.index}"
    command = ["redis-server", "/usr/local/etc/redis/redis.conf", "--port", "700${count.index}"]
    ports {
    	internal = "700${count.index}"
    	external = "700${count.index}"
    }
    ports {
    	internal = "1700${count.index}"
    	external = "1700${count.index}"
    }
    volumes {
    	container_path = "/usr/local/etc/redis/redis.conf"
    	host_path = "${path.module}/redis.conf"
    }
    network_mode = "host"
}

resource "docker_container" "setup" {
	image = "${docker_image.ruby.latest}"
	name = "setup"
	depends_on = ["docker_container.redis"]    
    command = ["./redis-trib.rb", "create", "--replicas", "1", "${var.docker_host}:7000", "${var.docker_host}:7001", "${var.docker_host}:7002", "${var.docker_host}:7003", "${var.docker_host}:7004", "${var.docker_host}:7005"]
    network_mode = "host"
}

resource "docker_image" "redis" {
    name = "redis:alpine"
}

resource "docker_image" "ruby" {
    name = "setup"
    keep_locally = true
}