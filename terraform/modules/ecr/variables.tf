### ECR
variable "repository_name" {
  description = "The name of the repository"
  type        = string
}

variable "scan_on_push" {
  description = "Indicates whether images are scanned after being pushed to the repository (true) or not (false)"
  type        = bool
  default     = true
}