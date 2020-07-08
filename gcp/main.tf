resource "google_container_cluster" "no-labels-cluster" {
  name = "cluster"
  location = "us-central1"

  node_pool {
    node_config {
      machine_type = "n1-standard-1"
    }
  }
}

resource "google_container_node_pool" "no-labels-pool" {
  name = "nodepool1"
  location = "us-central1"
  cluster = google_container_cluster.no-labels-cluster.name
  
  initial_node_count = 1

  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster" "existing-labels-cluster" {
  name = "cluster2"
  location = "us-central1"
  
  initial_node_count = 1
}

resource "google_container_node_pool" "existing-labels-pool" {
  name = "nodepool2"
  location = "us-central1"
  cluster = google_container_cluster.existing-labels-cluster.name
  

  node_config {
    machine_type = "n1-standard-1"
    labels = {
      foo = "bar"
    }
  }
}
