# T1491 — Defacement

Adversaries modify visual content available internally or externally to enterprise networks, affecting content integrity. Motivations include delivering messaging, intimidation, or claiming credit for intrusions; disturbing or offensive imagery may pressure compliance.

## Overview
- **ID:** T1491
- **Tactic:** [[Impact]]
- **Platforms:** ESXi, IaaS, Linux, Windows, macOS
- **Impact Type:** Integrity
- **Created:** 08 April 2019
- **Last Modified:** 24 October 2025

## Sub-techniques
- [[T1491.001]] — Internal Defacement
- [[T1491.002]] — External Defacement

## Mitigations
- **M1053 — Data Backup:** Implement IT disaster recovery plans with regular data backups stored off-system and protected from common adversary access/destruction methods.

## Detection
**DET0238 — Defacement via File and Web Content Modification Across Platforms**
- Monitor for unauthorized file changes or script injections modifying website/application content
- Detect shell access or malicious script uploads to web servers ([[Nginx]], [[Apache]], etc.)
- Identify manipulated application bundles or hosted content modifications
- Track modifications to static content on datastore-mounted paths (internal VM-hosted portals)
- Monitor compromised credentials or web application access to cloud storage ([[S3]], [[Azure Blob Storage]], [[GCP Buckets]])

## Tags
#impact #integrity #web-defacement #internal-defacement #external-defacement #mitre-attack

---
_Ingested: [[2026-04-15]] 22:02 | Source: https://attack.mitre.org/techniques/T1491/_
