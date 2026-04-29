# Email Protected

## What it is
Like a bouncer checking IDs at the door before letting anyone into the club, email protection is a layered set of technical controls that verify sender authenticity and filter malicious content before messages reach the inbox. Precisely, it refers to a suite of protocols and mechanisms — including SPF, DKIM, and DMARC — combined with spam/malware filtering to authenticate senders and block unwanted or dangerous email traffic.

## Why it matters
In the 2016 Podesta phishing attack, a spoofed Google security alert bypassed basic filters because the domain lacked proper DMARC enforcement, allowing attackers to impersonate legitimate senders convincingly. Proper email authentication records and gateway filtering would have flagged or quarantined the message before it reached the target. This incident illustrates why layered email protection is a critical control against business email compromise (BEC) and spear phishing.

## Key facts
- **SPF (Sender Policy Framework)** uses DNS TXT records to specify which IP addresses are authorized to send mail for a domain
- **DKIM (DomainKeys Identified Mail)** adds a cryptographic signature to email headers, allowing receivers to verify the message wasn't tampered with in transit
- **DMARC** builds on SPF and DKIM by telling receiving servers what to do when checks fail: `none`, `quarantine`, or `reject`
- Email gateways perform attachment sandboxing, URL rewriting, and reputation filtering — controls tested under CySA+ Domain 2 (Vulnerability Management)
- BEC attacks cost businesses over $2.9 billion in 2023 (FBI IC3 report), making email the single highest-impact attack vector by financial loss

## Related concepts
[[SPF Record]] [[DKIM]] [[DMARC]] [[Phishing]] [[Business Email Compromise]]