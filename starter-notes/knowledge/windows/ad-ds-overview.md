# Active Directory Domain Services Overview

Active Directory Domain Services (AD DS) is a directory service that stores information about network objects and provides methods for administrators and users to access this data. It enables centralized management of user accounts, resources, and network policies through a single username and password.

## Core Components

- **Directory Data Store**: Hierarchical structure containing information about network objects including user accounts, computers, servers, volumes, and printers
- **Schema**: Set of rules defining object classes, attributes, constraints, and naming formats
- **Global Catalog**: Contains information about every object in the directory across all domains
- **Query and Index Mechanism**: Enables users and applications to publish and find directory information
- **Replication Service**: Distributes directory data across the network; all domain controllers maintain complete copies

## Security Features

- Sign-in authentication integrated with directory access
- Access control to directory objects
- Policy-based administration for complex networks
- Single credentials for resource access across the network

## Key Technologies

- [[Active Directory Structure and Storage Technologies]]
- [[Domain Controller Roles]]
- [[Active Directory Schema]]
- [[Active Directory Replication Concepts]]
- [[Active Directory Search and Publication Technologies]]
- [[DNS Group Policy Settings]]
- [[Trust Management]]

## Supported Versions

Applies to: Windows Server 2025, Windows Server 2022, Windows Server 2019, Windows Server 2016

## Tags

#ad-ds #active-directory #identity #directory-services #windows-server

---
_Ingested: 2026-04-15 20:20 | Source: https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/get-started/virtual-dc/active-directory-domain-services-overview_
