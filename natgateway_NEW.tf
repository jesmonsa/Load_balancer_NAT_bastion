resource "oci_core_nat_gateway" "ARESNATGateway" {
    compartment_id = oci_identity_compartment.ARESCompartment.id
    display_name = "ARESNATGateway"
    vcn_id = oci_core_virtual_network.ARESVCN.id
}
