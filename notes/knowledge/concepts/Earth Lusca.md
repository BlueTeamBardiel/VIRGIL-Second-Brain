# Earth Lusca

## What it is
Think of a locksmith who secretly makes copies of every key they cut, then returns at night to rob the houses — Earth Lusca operates the same way, quietly establishing persistence inside victim networks while conducting espionage and financially motivated crime simultaneously. Earth Lusca is a Chinese state-sponsored advanced persistent threat (APT) group, active since at least 2019, known for targeting government, media, education, and cryptocurrency organizations across Asia, Europe, and North America. They are notable for blending espionage objectives with cryptocurrency theft, suggesting both nation-state tasking and self-funding operations.

## Why it matters
In 2021, Earth Lusca exploited ProxyShell and Log4Shell vulnerabilities to compromise internet-facing servers, then deployed Cobalt Strike beacons and custom backdoors like ShadowPad and Winnti to maintain long-term access. This demonstrates how a sophisticated APT can chain public exploits with custom tooling, making detection difficult and remediation expensive — defenders who only patch known CVEs without hunting for post-exploitation artifacts will miss the breach entirely.

## Key facts
- Earth Lusca is tracked by Trend Micro and overlaps with threat clusters UNC3226 and TAG-22 identified by other vendors
- Primary initial access vectors include exploitation of public-facing applications (VPNs, Exchange servers) and spear-phishing
- Uses a two-layer infrastructure: compromised servers as "Tier 1" for victim interaction, and leased VPS servers as "Tier 2" for C2 control, complicating attribution
- Malware arsenal includes Cobalt Strike, ShadowPad, Winnti, and the custom Linux backdoor **SprySOCKS** (discovered 2023)
- Targets include COVID-19 research institutions, pro-democracy media, and cryptocurrency exchanges — indicating dual intelligence and financial motivations

## Related concepts
[[Advanced Persistent Threat (APT)]] [[ShadowPad]] [[Cobalt Strike]] [[ProxyShell]] [[Living off the Land (LotL)]]