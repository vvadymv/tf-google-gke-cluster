resource "google_container_cluster" "this" {
  name = var.GKE_NAME
  location = var.GOOGLE_REGION

  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection = false
}

resource "google_container_node_pool" "main" {
  name       = "main"
  project    = google_container_cluster.this.project
  cluster    = google_container_cluster.this.name
  location   = google_container_cluster.this.location
  node_count = var.GKE_NUM_NODES

  node_config {
    machine_type = var.GKE_MACHINE_TYPE
    disk_size_gb = 50
  }
}