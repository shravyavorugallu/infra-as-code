output "node_ids"          { value = azurerm_linux_virtual_machine.compute[*].id }
output "node_names"        { value = azurerm_linux_virtual_machine.compute[*].name }
output "private_ips"       { value = azurerm_network_interface.compute[*].private_ip_address }
output "identity_principal_ids" {
  value = azurerm_linux_virtual_machine.compute[*].identity[0].principal_id
}
