# WiFi Pineapple

## What it is
Like a fake vending machine placed in an airport that accepts your dollar, dispenses nothing, and photographs your face — a WiFi Pineapple is a rogue access point device that impersonates legitimate networks to intercept wireless traffic. It's a purpose-built penetration testing tool by Hak5 that automates evil twin attacks, captures credentials, and performs man-in-the-middle attacks against unsuspecting clients.

## Why it matters
In a real-world scenario, a red teamer walks into a corporate lobby, drops a Pineapple in their bag, and watches as employee laptops automatically reconnect to it — because it broadcasts the same SSIDs their devices have previously trusted. The device silently strips HTTPS via SSLstrip and logs every credential entered, all without the victim seeing any visible warning.

## Key facts
- Uses **probe request harvesting**: devices broadcast previously connected SSIDs, and the Pineapple responds to all of them, triggering automatic association
- Operates in two attack modes: **passive reconnaissance** (monitoring) and **active impersonation** (evil twin/rogue AP)
- The **PineAP suite** is its core engine — handles deauthentication, SSID spoofing, and client association logging
- Runs **OpenWRT Linux**, making it fully scriptable and extensible with modules for DNS spoofing, credential capture, and traffic analysis
- Directly relevant to **Security+ domain**: Threats, Attacks and Vulnerabilities — specifically wireless attack types (evil twin, deauth, rogue AP)

## Related concepts
[[Evil Twin Attack]] [[Man-in-the-Middle Attack]] [[Rogue Access Point]] [[Deauthentication Attack]] [[SSLstrip]]