# TCP syslog

## What it is
Like sending a registered letter instead of dropping a postcard in the mailbox — TCP syslog guarantees your log message arrives, in order, or the sender knows it failed. Specifically, it is the transmission of syslog event messages over TCP (typically port 514 or 6514 for TLS-encrypted variants) rather than the traditional UDP protocol, providing connection-oriented, reliable log delivery.

## Why it matters
During a ransomware incident, attackers commonly attempt to destroy local logs before exfiltrating data. If syslog is running over UDP, dropped packets during a network-saturating attack mean forensic evidence simply vanishes with no warning. TCP syslog with TLS (RFC 5425) ensures that if the log stream breaks, the sending device knows immediately — and encrypted transport prevents attackers from reading or tampering with the log stream in transit.

## Key facts
- **Default port:** TCP 514 (unencrypted); TCP 6514 is the IANA-assigned port for syslog over TLS
- **Reliability advantage:** TCP's three-way handshake and acknowledgment mechanism guarantees delivery and ordering, unlike UDP syslog which is fire-and-forget
- **RFC standards:** RFC 6587 defines syslog over plain TCP; RFC 5425 defines syslog over TLS for confidentiality and integrity
- **Log integrity:** TLS transport satisfies compliance requirements (PCI-DSS, HIPAA) demanding log confidentiality and tamper evidence in transit
- **SIEM relevance:** Most enterprise SIEM collectors (Splunk, IBM QRadar, Elastic) prefer TCP/TLS syslog inputs to ensure complete ingestion pipelines without silent data loss

## Related concepts
[[UDP syslog]] [[SIEM]] [[TLS]] [[Log Management]] [[Network Security Monitoring]]