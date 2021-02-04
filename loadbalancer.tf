resource "oci_load_balancer" "ARESPublicLoadBalancer" {
  shape          = "100Mbps"
  compartment_id = oci_identity_compartment.ARESCompartment.id 
  subnet_ids     = [
    oci_core_subnet.ARESLBSubnet.id
  ]
  display_name   = "ARESPublicLoadBalancer"
}

resource "oci_load_balancer_backendset" "ARESPublicLoadBalancerBackendset" {
  name             = "ARESPublicLBBackendset"
  load_balancer_id = oci_load_balancer.ARESPublicLoadBalancer.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port     = "80"
    protocol = "HTTP"
    response_body_regex = ".*"
    url_path = "/"
  }
}


resource "oci_load_balancer_listener" "ARESPublicLoadBalancerListener" {
  load_balancer_id         = oci_load_balancer.ARESPublicLoadBalancer.id
  name                     = "ARESPublicLoadBalancerListener"
  default_backend_set_name = oci_load_balancer_backendset.ARESPublicLoadBalancerBackendset.name
  port                     = 80
  protocol                 = "HTTP"
}


resource "oci_load_balancer_backend" "ARESPublicLoadBalancerBackend1" {
  load_balancer_id = oci_load_balancer.ARESPublicLoadBalancer.id
  backendset_name  = oci_load_balancer_backendset.ARESPublicLoadBalancerBackendset.name
  ip_address       = oci_core_instance.ARESWebserver1.private_ip
  port             = 80 
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "ARESPublicLoadBalancerBackend2" {
  load_balancer_id = oci_load_balancer.ARESPublicLoadBalancer.id
  backendset_name  = oci_load_balancer_backendset.ARESPublicLoadBalancerBackendset.name
  ip_address       = oci_core_instance.ARESWebserver2.private_ip
  port             = 80
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}


output "ARESPublicLoadBalancer_Public_IP" {
  value = [oci_load_balancer.ARESPublicLoadBalancer.ip_addresses]
}

