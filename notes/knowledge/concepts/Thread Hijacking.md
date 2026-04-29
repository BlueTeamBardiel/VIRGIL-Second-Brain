# Thread Hijacking

## What it is
Like a pickpocket slipping into a crowded subway car and stealing a passenger's jacket to impersonate them, thread hijacking occurs when an attacker takes over a legitimate, existing email conversation thread to deliver malicious content. Precisely: it is a phishing technique where an attacker gains access to real email threads (via compromised accounts or intercepted mail) and replies within that thread with malicious links, attachments, or instructions, exploiting the trust established by the prior conversation.

## Why it matters
The Emotet malware campaign famously used thread hijacking at scale — after compromising a victim's Outlook account, it would automatically reply to existing email conversations with malicious Word documents, dramatically increasing click rates because recipients saw a familiar name in a trusted conversation context. Defenders must recognize that even emails appearing within known threads from known contacts can be weaponized, making sender reputation alone an insufficient detection signal.

## Key facts
- Thread hijacking bypasses user suspicion because the malicious email shares a real subject line, real prior message history, and a known sender identity
- Emotet and Qakbot (QBot) are the two most prominent malware families documented using automated thread hijacking at scale
- Access to the thread is typically gained through a previously compromised mailbox, stolen credentials, or IMAP/Exchange access
- Defense includes analyzing email headers for mismatched sending servers (SPF/DKIM/DMARC failures) even when display names look legitimate
- This technique is classified under **Business Email Compromise (BEC)** tactics and appears in MITRE ATT&CK under **T1534 – Internal Spearphishing**

## Related concepts
[[Spear Phishing]] [[Business Email Compromise]] [[Emotet Malware]] [[DMARC]] [[Credential Theft]]