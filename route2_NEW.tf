resource "oci_core_route_table" "ARESRouteTableViaNAT" {
    compartment_id = oci_identity_compartment.ARESCompartment.id
    vcn_id = oci_core_virtual_network.ARESVCN.id
    display_name = "ARESRouteTableViaNAT"
    route_rules {
        destination = "0.0.0.0/0"
        destination_type  = "CIDR_BLOCK"
        network_entity_id = oci_core_nat_gateway.ARESNATGateway.id
    }
}

