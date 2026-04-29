# hostname verification

## What it is
Like checking that the name on a hotel room key matches the room number on the door — not just that the key works — hostname verification confirms that a TLS certificate's stated identity actually matches the server you're connecting to. Specifically, it's the process of comparing the server's presented certificate (Common Name or Subject Alternative Names) against the DNS hostname the client used to initiate the connection.

## Why it matters
In 2012, researchers discovered that many Android banking apps accepted any valid TLS certificate regardless of hostname, making them trivially vulnerable to man-in-the-middle attacks — an attacker with a cert for `evil.com` could intercept traffic destined for `bank.com`. This class of bug is so common that OWASP lists broken hostname verification as a top mobile security failure, enabling credential theft even over "encrypted" connections.

## Key facts
- Hostname verification is **separate** from certificate chain validation — a cert can be legitimately signed by a trusted CA but still be for the wrong host
- Correct verification checks the **Subject Alternative Name (SAN)** field first; Common Name (CN) is deprecated for this purpose per RFC 2818
- Wildcard certificates (`*.example.com`) match only **one subdomain level** — `sub.example.com` yes, `a.sub.example.com` no
- Developers disabling hostname verification (e.g., `setHostnameVerifier(ALLOW_ALL_HOSTNAME_VERIFIER)`) is a frequent source of critical mobile app vulnerabilities
- TLS libraries like Java's JSSE perform hostname verification **after** the handshake; skipping it silently accepts any cert from any domain

## Related concepts
[[TLS handshake]] [[certificate validation]] [[man-in-the-middle attack]] [[Subject Alternative Name]] [[certificate pinning]]