# OpenStack

## What it is
Think of OpenStack like a city zoning board that hands out plots of land, water pipes, and road access — except the "city" is a data center and the plots are virtual machines, storage volumes, and network segments. OpenStack is an open-source cloud management platform that orchestrates compute (Nova), networking (Neutron), storage (Cinder/Swift), and identity (Keystone) services to build private and hybrid cloud environments.

## Why it matters
In 2022, threat actors compromised misconfigured OpenStack metadata services to steal instance credentials via SSRF (Server-Side Request Forgery) attacks — by querying `http://169.254.169.254/`, attackers retrieved API tokens and escalated privileges across the entire tenant. Defenders must restrict metadata endpoint access and enforce strict security group rules to prevent lateral movement between tenants in multi-tenant deployments.

## Key facts
- **Keystone** is the identity and authentication service — compromising it means compromising the entire cloud; it issues tokens used by all other OpenStack components
- **Security groups** in OpenStack function like stateful firewall rules applied per-instance; misconfigured groups are a leading cause of east-west exposure between tenants
- **Tenant/Project isolation** is logical, not physical — a hypervisor escape vulnerability (e.g., VENOM CVE-2015-3456) can break isolation between tenants on the same host
- **Metadata service** at `169.254.169.254` is an IMDS (Instance Metadata Service) endpoint — a classic SSRF pivot target to steal ephemeral credentials
- OpenStack uses **role-based access control (RBAC)** enforced by Keystone; the default "admin" role has cloud-wide scope, making it a high-value privilege escalation target

## Related concepts
[[Cloud Security]] [[Hypervisor Security]] [[SSRF]] [[Instance Metadata Service]] [[Multi-Tenancy]]