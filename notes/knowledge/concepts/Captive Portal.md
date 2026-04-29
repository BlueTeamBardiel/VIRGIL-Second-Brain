# Captive Portal

## What it is
Like a hotel lobby that won't let you reach the elevator until you check in at the front desk, a captive portal intercepts all HTTP/HTTPS traffic from a newly connected device and redirects it to a mandatory authentication or acceptance page. It is a network access control mechanism commonly deployed on public Wi-Fi networks that forces users to complete a login, pay, or agree to terms before being granted full internet access.

## Why it matters
Attackers use rogue captive portals as a classic evil twin attack vector — standing up a fake access point with a convincing login page to harvest credentials or payment card data from users who believe they're connecting to a legitimate airport or coffee shop network. Defenders in enterprise environments use captive portals to ensure guest users accept acceptable use policies and to segment guest traffic from internal resources before granting any connectivity.

## Key facts
- Captive portals work by intercepting DNS queries or HTTP requests and returning a redirect (302) to the portal page, effectively creating a "walled garden" until authentication succeeds
- HTTPS traffic cannot be transparently intercepted without triggering certificate warnings, which is why many portals redirect HTTP first or use DNS hijacking
- Operating systems (Windows, macOS, iOS) probe known URLs (e.g., `captive.apple.com`) at connection time to detect captive portal presence automatically
- Captive portals do **not** encrypt traffic by themselves — users remain vulnerable to sniffing without a VPN even after authentication
- Evil twin attacks exploiting rogue captive portals are a tested scenario on Security+ under the "wireless attacks" domain

## Related concepts
[[Evil Twin Attack]] [[Rogue Access Point]] [[Network Access Control]] [[DNS Hijacking]] [[Man-in-the-Middle Attack]]