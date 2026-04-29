# Sender Policy Framework

## What it is
Think of SPF like a bouncer's guest list: a domain owner publishes a list of IP addresses authorized to send email on their behalf, and receiving mail servers check whether the sender's IP is on that list before letting the message through. Technically, SPF is a DNS TXT record that specifies which mail servers are permitted to send email for a given domain. If an email arrives from an IP not on the list, the receiving server can reject, quarantine, or flag it.

## Why it matters
In a Business Email Compromise (BEC) attack, an adversary spoofs the CFO's email domain to trick an employee into wiring funds. Without SPF, the spoofed email sails through because nothing verifies the sending server is legitimate. With a properly configured SPF record, the receiving mail server checks the sending IP against the domain's authorized list and rejects the fraudulent message before it reaches the inbox.

## Key facts
- SPF records are published as **DNS TXT records** under the domain (e.g., `v=spf1 include:mailprovider.com ~all`)
- The **`~all` (softfail)** qualifier marks unauthorized senders as suspicious but still delivers the email; **`-all` (hardfail)** rejects them outright
- SPF alone **does not protect the "From:" header** visible to users — it validates the envelope sender (MAIL FROM), making DMARC necessary for full spoofing protection
- SPF has a **10 DNS lookup limit**; exceeding it causes a PermError, which can break email delivery
- SPF is one leg of the **email authentication triad**: SPF + DKIM + DMARC work together for comprehensive protection

## Related concepts
[[DMARC]] [[DKIM]] [[Email Spoofing]] [[DNS TXT Records]] [[Business Email Compromise]]