variable "GOOGLE_REGION" {
  type        = string
#  default     = "us-central1-a"
  description = "GCP region name"
}

variable "GKE_NUM_NODES" {
  type        = string
  description = "Initial number of GKE cluster nodes"

}

variable "GKE_MACHINE_TYPE" {
  type        = string
#  default     = "e2-micro"
  description = "GKE VM types"

}