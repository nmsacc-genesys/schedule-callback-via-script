terraform {
  required_providers {
    genesyscloud = {
      source = "mypurecloud/genesyscloud"
    }
  }
}

provider "genesyscloud" {
  sdk_debug = true
}

# Looks up the id of the queue so we can associate it with the script
data "genesyscloud_routing_queue" "queue" {
  name = var.queue_name
}

# Add a Script
resource "genesyscloud_script" "script" {
  script_name       = "Schedule Callback"
  filepath          = "${path.module}/schedule-callback-script.json"
  substitutions = {
    name      = "Schedule Callback"
    queue_id  = data.genesyscloud_routing_queue.queue.id
    org_id    = var.org_id
  }
}