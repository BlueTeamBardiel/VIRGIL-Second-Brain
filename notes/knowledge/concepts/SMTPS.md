# SMTPS

## What it is
Like sealing a letter inside a tamper-evident envelope before handing it to the postal service, SMTPS wraps the entire SMTP email transmission inside a TLS tunnel from the very first byte. It is the implicit TLS variant of SMTP, operating on port 465, where encryption is mandatory and established before any mail commands are exchanged — contrasted with STARTTLS, which upgrades an existing plaintext connection opportunistically.

## Why it matters
In a man-in-the-middle attack known as STARTTLS stripping, an attacker intercepts the SMTP negotiation and removes the STARTTLS command from the server's capability list, forcing both parties to communicate in plaintext — credentials and message content exposed. SMTPS defeats this attack entirely because there is no plaintext handshake phase to strip; TLS is non-negotiable before communication begins. Organizations enforcing SMTPS on outbound mail clients eliminate an entire class of credential-harvesting attacks on corporate email.

## Key facts
- **Port 465** is the designated port for SMTPS (implicit TLS); port 587 with STARTTLS is the modern submission alternative, and port 25 is for unencrypted or opportunistic server-to-server relay
- SMTPS uses **implicit TLS**, meaning the TLS handshake occurs immediately upon connection — no STARTTLS negotiation required or possible
- STARTTLS on port 587 is vulnerable to **downgrade attacks**; SMTPS is not, because plaintext communication is never offered
- Port 465 was briefly deprecated by RFC 2487 but was **officially reassigned** to SMTPS by IANA in 2018 for message submission with implicit TLS
- For Security+/CySA+: recognizing port **465 = SMTPS**, port **993 = IMAPS**, port **995 = POP3S** follows the pattern of implicit TLS across mail protocols

## Related concepts
[[STARTTLS]] [[TLS]] [[Email Security Protocols]] [[Port Numbers]] [[Man-in-the-Middle Attack]]