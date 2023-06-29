resource "aws_instance" "appserver" {
  for_each                    = toset(local.availability_zones)

  availability_zone           = each.value
  subnet_id                   = aws_subnet.private[each.value].id
  associate_public_ip_address = false
  ami                         = data.aws_ami.amazon_linux2.id
  instance_type               = var.ec2_instance_type
  user_data                   = data.cloudinit_config.user_data.rendered
  key_name                    = var.appserver_private_ssh_key_name
  vpc_security_group_ids      = [ aws_security_group.appserver.id ]
  monitoring                  = true

  tags = {
    Name        = join("_", [var.project_name, "_appserver"])
    terraform   = "true"
    environment = var.environment
    project     = var.project_name
  }
}

resource "aws_security_group" "appserver" {
  name        = join("_", [var.project_name, "_appserver_security_group"])
  description = "security group for application server"
  vpc_id      = aws_vpc.this.id

  tags = {
    Name        = join("_", [var.project_name, "_appserver_sg"])
    terraform   = "true"
    environment = var.environment
    project     = var.project_name
  }

  # Dependency is used to ensure that VPC has an Internet gateway
  depends_on  = [ aws_internet_gateway.this ]
}

data "aws_ami" "amazon_linux2" {
  owners = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = [ local.ami_name ]
  }

  filter {
    name   = "architecture"
    values = [ local.ami_architecture ]
  }

  filter {
    name   = "virtualization-type"
    values = [ var.ami_virtualization ]
  }

  owners = [ local.ami_owner_id ]
}

data "aws_ssm_parameter" "admin_public_ssh_keys" {
  for_each = toset(var.admin_public_ssh_keys)

  name = each.value
  with_decryption = true
}

# ------------------- User data for cloud-init --------------------------
# The public ssh key will added to ec2 instances using cloud-init
data "cloudinit_config" "user_data" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content      = templatefile("templates/userdata.tftpl", {
      public_ssh_keys: [ for key in data.aws_ssm_parameter.admin_public_ssh_keys: key.value]
    })
  }
}

