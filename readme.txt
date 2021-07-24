****3 tier architecture deployment using terraform****
Deployed resource group
Deployed virtual network under the resource group.
Deployed 4 subnets within vnet for web tier,app tier, data tier and management server respectively.
Deployed Virtual machines with Availability set configured for each 3 tiers.
Deployed management server for user management.
Configured NIC and NSG rules for the each subnet.
Configured external load balancer with backend address pool for public access of application.
Configured internal load balancer with backend address pool for communication between web and app tiers.
