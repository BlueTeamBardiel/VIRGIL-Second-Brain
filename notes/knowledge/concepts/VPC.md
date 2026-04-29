# VPC

## What it is
Think of a VPC like renting a walled-off floor in a shared office skyscraper — you get your own locked corridors, private rooms, and controlled reception desk, even though the building's foundation is shared with hundreds of other tenants. A Virtual Private Cloud (VPC) is a logically isolated network segment within a public cloud provider (AWS, Azure, GCP) where you define your own IP ranges, subnets, route tables, and network gateways. It gives you the illusion and security properties of a private data center while running on shared physical infrastructure.

## Why it matters
In 2019, Capital One suffered a massive breach partly because a misconfigured WAF inside their AWS VPC allowed an attacker to exploit SSRF — querying the internal metadata service and exfiltrating IAM credentials. Proper VPC segmentation (restricting outbound traffic from sensitive subnets, blocking metadata endpoint access) would have contained the blast radius significantly. This is why security professionals treat VPC architecture as a first-order security control, not an afterthought.

## Key facts
- **Subnets determine exposure**: Public subnets have routes to an Internet Gateway; private subnets do not — workloads should default to private unless explicitly requiring inbound internet access.
- **Security Groups vs. NACLs**: Security Groups are stateful and apply at the instance level; Network Access Control Lists (NACLs) are stateless and apply at the subnet level — both are VPC controls.
- **VPC Peering** connects two VPCs privately but is non-transitive — VPC A peered with B and C does NOT mean B and C can talk through A.
- **VPC Flow Logs** capture IP traffic metadata (not payload) and are critical for network forensics and anomaly detection in cloud environments.
- **Default VPCs** in AWS are insecure by design — they place instances in public subnets with auto-assigned public IPs, violating least exposure principles.

## Related concepts
[[Cloud Security]] [[Network Segmentation]] [[Security Groups]] [[SSRF]] [[Zero Trust Architecture]]