# Pharming

## What it is
Imagine someone secretly replaced every road sign in your city so that the sign pointing to "City Hall" now directs you to a fake building that looks identical — that's pharming. It's an attack that redirects legitimate DNS queries to malicious IP addresses, sending users to fraudulent websites even when they type the correct URL, without any need for the victim to click a suspicious link.

## Why it matters
In 2007, attackers compromised DNS servers serving millions of users in Brazil, redirecting traffic from a major bank's legitimate domain to a cloned phishing site that harvested credentials at scale. Unlike phishing, victims had no behavioral red flag to detect — they typed the right address and got the wrong destination, making pharming particularly dangerous for financial institutions and their customers.

## Key facts
- **Two primary methods:** DNS cache poisoning (corrupting a DNS server's cache with false records) and host file modification (editing the local `hosts` file on a victim's machine via malware)
- **DNS cache poisoning** exploits the DNS resolution process before the user's browser even makes a request — no user interaction required after infection
- **DNSSEC (DNS Security Extensions)** is the primary mitigation, using cryptographic signatures to validate DNS responses and detect tampering
- Pharming differs from phishing in that phishing requires a victim to click a malicious link; pharming works silently against correctly typed URLs
- Indicators of pharming include SSL certificate warnings, unexpected certificate changes, or mismatched HTTPS padlocks on familiar sites

## Related concepts
[[DNS Cache Poisoning]] [[Phishing]] [[DNSSEC]] [[Man-in-the-Middle Attack]]