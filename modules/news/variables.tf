variable "prefix_name" {
  description = ""
  type        = string
  validation {
    condition     = var.prefix_name != null
    error_message = "Input cannot be empty!"
  }
}

variable "replicas"{
  description = "Pods replicas number."
  type        = number
  default     = 3
}

variable "rolling_update"{
  description = "Pods replicas number."
  type        = map(string)
  default     = {
    max_surge       = "2"
    max_unavailable = "1"
  }
}

variable "image" {
  description = "Pods container name"
  type        = map(string)
  default     = {
    name  = "128684785872.dkr.ecr.us-east-1.amazonaws.com/news-feed-news"
    tag   = "latest"
  }
}

variable "ingress_annotations" {
  description = ""
  type        = map(string)
  default     = {
    #load-balancer-name            = local.load_balancer_name
    scheme                        = "internet-facing"
    healthcheck-protocol          = "HTTP"
    healthcheck-path              = "/index.php"
    healthcheck-interval-seconds  = "15"
    healthcheck-timeout-seconds   = "5"
    healthy-threshold-count       = "2"
    unhealthy-threshold-count     = "2"
    success-codes                 = "200"
  }
}

variable "tags" {
  description = ""
  type        = map(string)
  validation {
    condition = var.tags != null
    error_message = "Input cannot be empty!"
  }
}