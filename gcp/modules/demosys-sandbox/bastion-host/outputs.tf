###############################################################################
# Demo Systems Bastion Host Configuration Module
# -----------------------------------------------------------------------------
# modules/demosys-sandbox/bastion-host/outputs.tf
###############################################################################

output "outputs" {
  value = {
    bastion_instance = module.instance.outputs
  }
}
