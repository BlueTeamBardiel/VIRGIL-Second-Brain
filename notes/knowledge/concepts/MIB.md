# MIB

## What it is
Think of a MIB like a library's card catalog — it tells you exactly what books exist, where they're shelved, and what format they're in, without containing the books themselves. A Management Information Base (MIB) is a hierarchical database schema used by SNMP (Simple Network Management Protocol) that defines the structure and meaning of network device data, using unique Object Identifiers (OIDs) to label every manageable parameter on a device.

## Why it matters
Attackers who gain access to SNMP with the default community string "public" can walk the entire MIB tree of a router or switch, harvesting interface names, IP addresses, running software versions, and network topology — all without triggering most intrusion detection systems. This reconnaissance technique (called an SNMP walk) has been used in pre-attack phases against enterprise networks to silently map infrastructure before exploitation.

## Key facts
- MIBs use a tree-structured OID namespace; for example, `1.3.6.1.2.1.1.1.0` is the sysDescr object, revealing the device's OS and version
- SNMPv1 and SNMPv2c transmit community strings (essentially passwords) in **plaintext**, making MIB access trivially interceptable via packet capture
- Default community strings "public" (read) and "private" (read/write) are present on many unpatched devices — "private" allows **writing** MIB values, potentially reconfiguring devices
- SNMPv3 introduced authentication (MD5/SHA) and encryption (DES/AES), directly addressing MIB exposure risks
- CISOs should restrict SNMP access via ACLs, disable SNMPv1/v2c, and audit which OIDs are exposed, as MIB data can reveal PII-adjacent network architecture

## Related concepts
[[SNMP]] [[Network Reconnaissance]] [[OID]] [[Community Strings]] [[SNMPv3]]