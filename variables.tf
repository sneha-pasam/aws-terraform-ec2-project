# The size/type of the EC2 instance
variable "instance_type" {
  description = "The size of the EC2 instance."
  type        = string
  default     = "t2.micro" # Free-tier eligible instance type
}

# The AWS region where resources will be provisioned
variable "aws_region" {
  description = "The AWS region to deploy resources into."
  type        = string
  default     = "ap-south-1" # Based on your Project 1 location
}
