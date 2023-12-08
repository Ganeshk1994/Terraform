terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("<Path/to/credentialsJsonFile>/credentials.json")
  project = "<gcp_project_id>"
  region  = "<region>"
}

resource "google_compute_vpn_tunnel" "tunnel1" {
  name          = "customer-tunnel1"
  peer_ip       = "<35.56.34.64>"
  shared_secret = "<a secret message>"
  ike_version   = 1
  local_traffic_selector = ["<192.168.0.0/24>"]
  remote_traffic_selector = ["<172.16.0.0/24>"]

  target_vpn_gateway = google_compute_vpn_gateway.target_gateway.id

  depends_on = [
    google_compute_forwarding_rule.vpn_esp,
    google_compute_forwarding_rule.vpn_udp500,
    google_compute_forwarding_rule.vpn_udp4500,
  ]
}

resource "google_compute_vpn_gateway" "target_gateway" {
  name    = "vpn-gw-1"
  network = "hosting-test-vpc"
}

resource "google_compute_address" "vpn_static_ip" {
  name = "vpn-static-ip"
}

resource "google_compute_forwarding_rule" "vpn_esp" {
  name        = "vpn-esp"
  ip_protocol = "ESP"
  ip_address  = google_compute_address.vpn_static_ip.address
  target      = google_compute_vpn_gateway.target_gateway.id
}

resource "google_compute_forwarding_rule" "vpn_udp500" {
  name        = "vpn-udp500"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = google_compute_address.vpn_static_ip.address
  target      = google_compute_vpn_gateway.target_gateway.id
}

resource "google_compute_forwarding_rule" "vpn_udp4500" {
  name        = "vpn-udp4500"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = google_compute_address.vpn_static_ip.address
  target      = google_compute_vpn_gateway.target_gateway.id
}

resource "google_compute_route" "route1" {
  name       = "customer-vpn-route"
  network    = "hosting-test-vpc"
  dest_range = "<15.0.0.0/24>"
  priority   = 1000

  next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel1.id
}
