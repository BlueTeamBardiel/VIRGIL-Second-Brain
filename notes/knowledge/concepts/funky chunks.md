# funky chunks

## What it is
Like a magician slipping a card into the middle of a deck where no one looks, "funky chunks" refers to the technique of embedding malicious or anomalous data segments within otherwise legitimate chunked HTTP transfer-encoded messages to confuse parsers and bypass security controls. Specifically, it exploits ambiguities in how different systems (load balancers, WAFs, back-end servers) interpret chunk boundaries and chunk extension fields in HTTP/1.1 chunked transfer encoding.

## Why it matters
In HTTP desync and request smuggling attacks, an attacker can craft a request where the front-end proxy interprets chunk boundaries one way while the back-end server reads them differently — effectively "poisoning" the back-end's request queue. This technique was demonstrated against major CDN and WAF vendors, allowing attackers to bypass security filters, hijack other users' sessions, or achieve cache poisoning at scale.

## Key facts
- Chunked Transfer Encoding (defined in RFC 7230) allows HTTP message bodies to be sent in variable-size pieces, each prefixed with its hexadecimal size.
- Chunk extensions (the `;name=value` syntax after chunk size) are legally defined but almost universally ignored — making them a prime smuggling vector.
- Funky chunk techniques commonly appear in **CL.TE** and **TE.TE** desync variants, where conflicting Content-Length vs. Transfer-Encoding headers cause parsing disagreements.
- Tools like **HTTP Request Smuggler** (a Burp Suite extension) automate detection of funky chunk vulnerabilities in web infrastructure.
- WAF bypass via funky chunks works because many WAFs normalize HTTP before inspection but forward the raw, un-normalized bytes to the origin server.

## Related concepts
[[HTTP Request Smuggling]] [[Chunked Transfer Encoding]] [[HTTP Desync Attacks]] [[WAF Bypass Techniques]] [[CL.TE Desync]]