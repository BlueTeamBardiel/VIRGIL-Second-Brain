# sslstrip

## What it is
Imagine a corrupt translator at a border crossing who intercepts your letter marked "encrypt this," quietly rewrites it as plaintext, forwards it normally, and hands you back the reply — and you never knew. SSLstrip works the same way: it's a man-in-the-middle tool created by Moxie Marlinspike that silently downgrades HTTPS connections to HTTP by intercepting the initial redirect, letting the attacker read traffic the victim believed was encrypted.

## Why it matters
In a coffee shop attack scenario, an adversary runs SSLstrip alongside ARP poisoning to position themselves between a victim and the gateway. When the victim's browser follows an HTTP link to `http://bank.com` (before the HTTPS redirect fires), SSLstrip intercepts the 301/302 redirect and serves the victim a plain HTTP version of the site — capturing credentials in cleartext while maintaining a legitimate HTTPS session with the real server upstream.

## Key facts
- SSLstrip exploits the *first HTTP request* before HTTPS is established — it cannot break TLS itself; it prevents TLS from ever starting
- **HTTP Strict Transport Security (HSTS)** is the primary defense: it instructs browsers to *refuse* HTTP connections to a domain entirely, preempting the downgrade
- **HSTS Preloading** (browsers ship with a hardcoded HSTS list) defeats even the very first HTTP request, closing the remaining gap
- Requires the attacker to already be in a MITM position — commonly achieved via ARP spoofing or rogue Wi-Fi access points
- SSLstrip++ (sslstrip2) bypasses basic HSTS by stripping the `Strict-Transport-Security` header on *first visit* to domains not on the preload list

## Related concepts
[[HSTS]] [[ARP Spoofing]] [[Man-in-the-Middle Attack]] [[TLS Downgrade Attack]] [[Rogue Access Point]]