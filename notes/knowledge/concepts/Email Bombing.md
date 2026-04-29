# Email Bombing

## What it is
Imagine someone signing you up for every magazine subscription on Earth simultaneously — your mailbox fills so fast you can't find the one letter that actually matters. Email bombing (also called a **mail bomb attack**) is a DoS technique where an attacker floods a target's inbox with massive volumes of email — sometimes tens of thousands in minutes — to overwhelm the mail server, exhaust storage quotas, or bury legitimate messages from view.

## Why it matters
Email bombing is frequently used as a **smokescreen attack**: an adversary floods a victim's inbox with subscription confirmations while simultaneously making fraudulent purchases or unauthorized account changes, knowing the real alert emails will drown in the noise. In documented cases, attackers have used open subscription APIs across hundreds of legitimate websites to generate the flood without sending a single email themselves, making source-based blocking nearly useless.

## Key facts
- **Two primary types**: list-linking attacks (auto-enrolling victims in mailing lists via open APIs) and direct SMTP floods using botnets or open relays
- **DoS impact is dual**: targets both the *recipient* (inbox unusable) and potentially the *mail server* (resource exhaustion, blacklisting)
- **Mitigation controls** include rate limiting on mail servers, CAPTCHA on subscription forms, and DMARC/SPF enforcement to block spoofed flood sources
- **Detection signal**: a sudden spike of hundreds of emails per minute from diverse, legitimate-looking senders is a red flag in SIEM log analysis
- **Often paired with credential attacks**: the noise masks password reset or MFA notification emails during an active account takeover

## Related concepts
[[Denial of Service (DoS)]] [[DMARC/SPF/DKIM]] [[Social Engineering]] [[Account Takeover]] [[SIEM Log Analysis]]