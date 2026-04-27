# CISA AA17-164A: EternalBlue and WannaCry Advisory

CISA advisory addressing the [[EternalBlue]] exploit and [[WannaCry]] ransomware campaign. This advisory provides guidance on mitigation and response for organizations affected by the widespread ransomware attack leveraging [[SMB]] vulnerabilities.

## Overview
- Threat: [[WannaCry]] ransomware utilizing [[EternalBlue]] [[SMB]] exploitation
- Impact: Global ransomware campaign affecting multiple sectors
- Status: Active threat requiring immediate mitigation

## Affected Systems
- [[Windows]] systems with unpatched [[SMB]] vulnerabilities
- Systems running vulnerable versions of [[Windows 7]], [[Windows 8]], [[Windows 10]], [[Windows Server 2008]], [[Windows Server 2012]], [[Windows Server 2016]]

## Mitigation
- Apply Microsoft security patches immediately
- Disable [[SMB]] v1 protocol where possible
- Implement network segmentation
- Monitor for suspicious [[SMB]] traffic
- Maintain current backups offline

## Related CVEs
- [[CVE-2017-0144]]
- [[CVE-2017-0145]]
- [[CVE-2017-0146]]
- [[CVE-2017-0147]]
- [[CVE-2017-0148]]

## Tags
#ransomware #wannacry #eternalblue #smb #cisa #windows #incident-response

---
_Ingested: 2026-04-15 20:47 | Source: https://www.cisa.gov/news-events/cybersecurity-advisories/aa17-164a_
