# Ceph

## What it is
Think of Ceph like a RAID array that ate a distributed computing textbook — instead of striping data across drives in one box, it stripes it across hundreds of machines in a cluster. Ceph is an open-source, software-defined storage platform that provides object, block, and file storage in a single unified system, designed to run on commodity hardware with no single point of failure.

## Why it matters
In cloud and enterprise environments, Ceph clusters frequently store sensitive data including database volumes, VM disk images, and backup archives — making them high-value targets. A misconfigured Ceph dashboard (default port 8443) exposed without authentication has led to real breaches where attackers exfiltrated entire storage pools or deployed ransomware by mounting block devices. Defenders must audit Ceph's CRUSH map permissions, enforce CephX authentication, and ensure the admin keyring is never world-readable.

## Key facts
- **CephX** is Ceph's built-in authentication protocol, using shared secret keys (similar to Kerberos tickets) to authenticate clients, monitors, and OSDs — disabling it is a critical misconfiguration
- Ceph stores data as **objects in CRUSH-mapped placement groups**, meaning data location is calculated algorithmically, not looked up in a central table — eliminating a single metadata bottleneck but complicating audit trails
- The **Ceph Monitor (MON)** maintains the authoritative cluster map; compromising it gives an attacker a god-view of the entire storage topology
- Default Ceph dashboard credentials (`admin`/`admin`) and open REST API endpoints (port 8003/8080) are common targets in CTF challenges and real penetration tests
- Ceph is the default storage backend for **OpenStack** and **Kubernetes Rook**, meaning its attack surface extends to entire cloud infrastructure deployments

## Related concepts
[[Object Storage Security]] [[Software-Defined Storage]] [[Cloud Storage Misconfiguration]]