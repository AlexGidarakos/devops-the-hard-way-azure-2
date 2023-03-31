# Start section: network.tf variables
# Azure VNET Address Space
network_address_space = "192.168.0.0/16"

# AKS Subnet Address Name
aks_subnet_address_name = "aks"

# AKS Subnet Address Space
aks_subnet_address_prefix = "192.168.0.0/24"

# Subnet Address Name
subnet_address_name = "appgw"

# Subnet Address Space
subnet_address_prefix = "192.168.1.0/24"
# End section: network.tf variables

# Start section: aks.tf variables
kubernetes_version = "1.23.12"
agent_count        = 3
vm_size            = "Standard_DS2_v2"
ssh_public_key     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDrt/GYkYpuQYRxM3lgjOr3Wqx8g5nQIbrg6Mr53wZGb35+ft+PibDMqxXZ7xq7fC3YuLnnO022IPgEjkF9fP03ZmfUeLjJJvw8YcutN9DD/2cx93BpKFPNUsqEB+za1iJ16kMsCojy35c1R64O+rw20D6iP96rmDAyIc5FR03y00eyAzQ8vo7/u9+VPwpdGEI7QCokZROcj6iNVz1V/1t6G4AEufPLokdj8J0gla/dN+tvnSLRQVBTDiD4jmVGImpWFqqKaH6R9SSXmRzj0uhvJUmSiZAZCb1caPEYgPEvNITuGQFdykPoY/4Z/3B+x/ipEQbWy8yL7bDFSXZTYhVKlPVyPbUtN5QFt7QtCtg84xDAZ6GA6AnONTtMxX2jvdzB9yh1ZsteNrOZ/Jo3ecuie573syQfG23Tu6qTqak8O7ZTOLY9iPx2ego3KvTWH/Q3lIvjnlpfCQtFtSgkNxjalMBk+NwwEgZHWRREOHwJmQIKVN0gSitN1KXobrqwxNk= tamops@Synth"

addons = {
  oms_agent                   = true
  ingress_application_gateway = true
}
# End section: aks.tf variables
