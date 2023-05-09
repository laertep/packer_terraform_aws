variable "name" {
  description = "Name of the Application"
  default = "servercep"
}

variable "env" {
  description = "Environment of the Application"
  default = "prod"
}


variable "ami" {
 description = "AWS AMI to be used "
 default = "ami-002570c1649f8a588"
}

variable "instance_type" {
  description = "AWS Instance type defines the hardware configuration of the machine"
  default = "t2.micro"
}



