variable "AWS_ACCESS_KEY" {
  type = string 
  
}
variable "AWS_SECRET_KEY" {
  type = string 
  
}
variable "AWS_REGION" {
  type = string
  validation {
    condition = contains(["us-east-1","us-east-1"], lower(var.AWS_REGION))
    error_message = "Unsupported AWS Region specified. Supported regions include: eastus1,eastus2 ."
  }
  
}

variable "AMIs" {
  type = map
  default = {
      us-east-1 = "ami-06b9259c69d8ed7f3"
      us-east-2 = "ami-08d980d641892da25"
      
  }
  
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "terraform_public_key.pub"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "terraform_private_key"
}
variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}
