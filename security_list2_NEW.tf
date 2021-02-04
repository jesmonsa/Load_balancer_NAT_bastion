resource "oci_core_security_list" "ARESSSHSecurityList" {
    compartment_id = oci_identity_compartment.ARESCompartment.id
    display_name = "ARESSSHSecurityList"
    vcn_id = oci_core_virtual_network.ARESVCN.id
    
    egress_security_rules {
        protocol = "6"
        destination = "0.0.0.0/0"
    }
    
    dynamic "ingress_security_rules" {
    for_each = var.bastion_ports
    content {
        protocol = "6"
        source = "0.0.0.0/0"
        tcp_options {
            max = ingress_security_rules.value
            min = ingress_security_rules.value
            }
        }
    }

    ingress_security_rules {
        protocol = "6"
        source = var.VCN-CIDR
    }
}
