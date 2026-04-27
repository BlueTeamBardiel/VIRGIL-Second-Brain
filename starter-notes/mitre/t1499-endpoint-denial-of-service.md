# T1499: Endpoint Denial of Service

Adversaries perform Endpoint Denial of Service (DoS) attacks to degrade or block the availability of services to users by exhausting system resources or exploiting the system to cause persistent crashes. These attacks target services like websites, email, DNS, and web applications, and can be conducted for political purposes, distraction, hacktivism, or extortion.

## Overview

Endpoint DoS differs from network DoS by targeting the endpoint itself rather than saturating the network. Attackers can target multiple layers of the application stack including the operating system, server applications (web servers, DNS servers, databases), and web-based applications. DoS attacks may originate from a single system or be distributed across multiple systems (DDoS).

## Key Techniques

- **IP Address Spoofing**: Attackers mask the source IP address to make attack traffic harder to trace and reduce the effectiveness of source-based filtering on network defense devices
- **Botnets**: Large networks of compromised systems used to generate significant distributed traffic from globally dispersed sources; can be self-built or rented
- **Traffic Manipulation**: Modifications at network gateway routers that cause legitimate clients to execute code directing network packets to targets in high volume

## Sub-techniques

- T1499.001: OS Exhaustion Flood
- T1499.002: Service Exhaustion Flood
- T1499.003: Application Exhaustion Flood
- T1499.004: Application or System Exploitation

## Metadata

- **ID**: T1499
- **Tactic**: Impact
- **Platforms**: Containers, IaaS, Linux, Windows, macOS
- **Impact Type**: Availability
- **Created**: 18 April 2019
- **Last Modified**: 24 October 2025

## Tags

#mitre-attack #t1499 #impact #denial-of-service #dos #ddos #availability

---
_Ingested: [[2026-04-15]] 22:02 | Source: https://attack.mitre.org/techniques/T1499/_
