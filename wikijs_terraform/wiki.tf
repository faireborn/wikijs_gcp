resource "google_cloud_run_v2_service" "wikijs" {
  name     = "wikijs"
  location = var.region
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      # image = "us-docker.pkg.dev/cloudrun/container/hello"
      image = "asia-northeast1-docker.pkg.dev/testing-387914/wikijscontainer/wikijs:latest"
      ports {
        container_port = 3000
      }
      env {
        name  = "DB_TYPE"
        value = "postgres"
      }
      env {
        name  = "DB_HOST"
        value = var.db-host
      }
      env {
        name  = "DB_PORT"
        value = 5432
      }
      env {
        name  = "DB_USER"
        value = var.db-user
      }
      env {
        name  = "DB_NAME"
        value = google_sql_database.wiki-db.name
      }
      env {
        name  = "DB_PASS"
        value = var.db-password
      }
#       env {
#         name  = "DB_SSL"
#         value = "true"
#       }
      env {
        name  = "OFFLINE_ACTIVE"
        value = 1
      }
    }
    vpc_access {
      connector = google_vpc_access_connector.connector.id
      egress = "ALL_TRAFFIC"
    }
  }
}

# For public access
data "google_iam_policy" "noauth" {
  binding {
    role    = "roles/run.invoker"
    members = ["allUsers"]
  }
}

resource "google_cloud_run_v2_service_iam_policy" "policy" {
  location    = var.region
  name        = google_cloud_run_v2_service.wikijs.name
  policy_data = data.google_iam_policy.noauth.policy_data
}
