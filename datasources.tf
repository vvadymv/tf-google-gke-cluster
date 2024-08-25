data "google_compute_instance_group" "node_instance_group" {
#  self_link = module.gke_cluster.managed_instance_group_urls[0]
  self_link = google_container_cluster.this.node_pool[0].managed_instance_group_urls[0]
}

resource "null_resource" "wait_for_instance_group" {
  depends_on = [data.google_compute_instance_group.node_instance_group]

  # Add a dummy trigger to force recreation when instances change
  triggers = {
    instance_count = length(data.google_compute_instance_group.node_instance_group.instances)
  }
}

data "google_compute_instance" "nodes" {
  for_each  = toset(data.google_compute_instance_group.node_instance_group.instances[*])
  self_link = each.key

  # Add dependency to ensure it waits for the null_resource
  depends_on = [null_resource.wait_for_instance_group]
}