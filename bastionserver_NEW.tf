resource "oci_core_instance" "ARESBastionServer" {
  availability_domain = lookup(data.oci_identity_availability_domains.ADs.availability_domains[1], "name")
  compartment_id = oci_identity_compartment.ARESCompartment.id
  display_name = "ARESBastionServer"
  shape = var.Shapes[0]
  subnet_id = oci_core_subnet.ARESBastionSubnet.id
  source_details {
    source_type = "image"
    source_id   = lookup(data.oci_core_images.OSImageLocal.images[0], "id")
  }
  metadata = {
      ssh_authorized_keys = file(var.public_key_oci)
  }
  create_vnic_details {
     subnet_id = oci_core_subnet.ARESBastionSubnet.id
     assign_public_ip = true
  }
}

data "oci_core_vnic_attachments" "ARESBastionServer_VNIC1_attach" {
  availability_domain = lookup(data.oci_identity_availability_domains.ADs.availability_domains[1], "name")
  compartment_id = oci_identity_compartment.ARESCompartment.id
  instance_id = oci_core_instance.ARESBastionServer.id
}

data "oci_core_vnic" "ARESBastionServer_VNIC1" {
  vnic_id = data.oci_core_vnic_attachments.ARESBastionServer_VNIC1_attach.vnic_attachments.0.vnic_id
}

output "ARESBastionServer_PublicIP" {
   value = [data.oci_core_vnic.ARESBastionServer_VNIC1.public_ip_address]
}
