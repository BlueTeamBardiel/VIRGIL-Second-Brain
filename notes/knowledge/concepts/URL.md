# URL

## What it is
Think of a URL like a postal address for the internet — it tells your browser exactly which building (domain), which floor (path), and which apartment (parameters) to visit. Technically, a Uniform Resource Locator is a standardized string that specifies the location of a resource on a network, composed of a scheme, authority, path, query, and fragment.

## Why it matters
Attackers weaponize URL structure through **URL manipulation attacks** — for example, changing `https://bank.com/account?id=1042` to `?id=1043` to access another user's account (an Insecure Direct Object Reference). Defenders must validate and sanitize every URL parameter server-side, never trusting client-supplied input to determine what data gets returned.

## Key facts
- **Structure breakdown:** `scheme://userinfo@host:port/path?query#fragment` — each component is a distinct attack surface (e.g., credential stuffing via userinfo, subdomain takeover via host)
- **URL encoding** uses `%XX` hex notation (e.g., space = `%20`); attackers use double-encoding (`%2520`) to bypass input filters that only decode once
- **Open redirects** occur when a URL parameter like `?redirect=https://evil.com` isn't validated, enabling phishing via trusted domain names
- **IDN homograph attacks** exploit internationalized domain names using look-alike Unicode characters (e.g., `pаypal.com` with a Cyrillic "а") to deceive users
- HTTP vs HTTPS is declared in the **scheme** component — a missing or downgraded scheme is a vector for SSL stripping attacks

## Related concepts
[[DNS]] [[HTTP Methods]] [[Input Validation]] [[Phishing]] [[SSL Stripping]]