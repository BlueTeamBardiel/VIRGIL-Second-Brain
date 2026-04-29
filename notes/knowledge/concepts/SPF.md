# SPF

## What it is
Think of SPF like a guest list posted outside a nightclub — only servers explicitly named on that list are allowed to send mail "from" your domain. Sender Policy Framework (SPF) is a DNS-based email authentication protocol that allows domain owners to publish a list of authorized mail servers in a TXT record. When a receiving mail server gets a message, it checks whether the sending IP matches that published list.

## Why it matters
Without SPF, an attacker can trivially send phishing emails with a spoofed "From" address like `cfo@yourcompany.com` — no infrastructure needed, just a raw SMTP connection. In a business email compromise (BEC) attack, this spoofed legitimacy tricks employees into wiring funds or surrendering credentials. A correctly configured SPF record causes receiving servers to flag or reject those spoofed messages before they reach the inbox.

## Key facts
- SPF records are published as **DNS TXT records** at the domain root (e.g., `v=spf1 include:sendgrid.net ~all`)
- The **`all` mechanism** controls strictness: `-all` (hard fail, reject), `~all` (soft fail, mark), `+all` (dangerous — allows everything)
- SPF only validates the **envelope sender (MAIL FROM)**, not the visible "From:" header — this is why SPF alone doesn't stop display-name spoofing
- SPF has a **10 DNS lookup limit**; exceeding it causes a `PermError`, effectively breaking authentication
- SPF **does not survive email forwarding** — forwarded messages often fail SPF because the forwarding server's IP isn't on the original domain's list

## Related concepts
[[DKIM]] [[DMARC]] [[Email Spoofing]] [[DNS TXT Records]] [[Business Email Compromise]]