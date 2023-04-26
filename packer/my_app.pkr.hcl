packer {
  required_plugins {
    amazon = {
      version = ">= 1.1.4"
      source = "github.com/hashicorp/amazon"
    }
  }
}

locals {
  timestamp = formatdate("DD-MM-YYYY hh-mm", timestamp())
}


source "amazon-ebs" "flask-app" {
  ami_name      = "flask-app-${local.timestamp}" 

  instance_type = "t2.micro"
  region        = "us-east-1"
  ssh_username  = "ubuntu"
  subnet_id = "subnet-0be41ced52a4489bb"
  tags = {
    Env  = "dev"
    Name = "flask-app"
  }

    source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
}

build {
  sources = ["source.amazon-ebs.flask-app"]

  provisioner "file" {
    source = "../flask app"
    destination = "/home/ubuntu/flask-app"
  }

  provisioner "shell" {
    script = "scripts/script.sh"
  }


  //   provisioner "file" {
  //   source = "./flask_server.service"
  //   destination = "/tmp/flask_server.service"
  // }


  // provisioner "shell" {
  //   script = "scripts/app_config.sh"
  //   remote_folder = "../flask-app"
  // }
  
}