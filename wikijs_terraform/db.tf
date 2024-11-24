resource "google_sql_database_instance" "main" {
  project          = var.project
  name             = "main-db"
  region           = var.region
  database_version = "POSTGRES_15"

  settings {
    tier = "db-f1-micro"

    ip_configuration {
      private_network = google_compute_network.vpc_network.id
      ipv4_enabled    = false # For private IP
    }
  }
}

resource "google_sql_user" "db_user" {
  project = var.project
  name     = var.db-user
  instance = google_sql_database_instance.main.name
  password = var.db-password
}

resource "google_sql_database" "wiki-db" {
  project = var.project

  name     = "wiki-db"
  instance = google_sql_database_instance.main.name
}
