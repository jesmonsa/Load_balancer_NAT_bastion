resource "oci_core_subnet" "ARESBastionSubnet" {
  cidr_block = "10.0.3.0/24"
  display_name = "ARESBastionSubnet"
  dns_label = "ARESN3"
  compartment_id = oci_identity_compartment.ARESCompartment.id
  vcn_id = oci_core_virtual_network.ARESVCN.id
  route_table_id = oci_core_route_table.ARESRouteTableViaIGW.id
  dhcp_options_id = oci_core_dhcp_options.ARESDhcpOptions1.id
  security_list_ids = [oci_core_security_list.ARESSSHSecurityList.id]
}


