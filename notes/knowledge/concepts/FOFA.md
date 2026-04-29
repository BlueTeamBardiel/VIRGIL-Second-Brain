# FOFA

## What it is
Like Google Street View for internet-connected devices, FOFA is a Chinese-developed cyber asset search engine that continuously crawls and indexes banners, services, and metadata from publicly exposed hosts. It allows users to query the global attack surface using syntax-based filters to discover servers, IoT devices, industrial systems, and vulnerable infrastructure in real time.

## Why it matters
During threat intelligence operations, red teams and nation-state actors use FOFA to pre-position before an attack — for example, querying `app="Apache-Solr"` to instantly locate thousands of unpatched Solr instances exposed to the internet without ever touching a target network. Defenders use it for attack surface management, identifying their own exposed assets before adversaries do.

## Key facts
- FOFA is operated by Beijing Huashun Xin'an Technology and indexes hundreds of billions of data points across global IP space
- Query syntax uses fields like `ip=`, `domain=`, `title=`, `cert=`, `app=`, `country=`, and `port=` — enabling highly targeted reconnaissance
- It is functionally similar to Shodan and Censys but with stronger coverage of Asian infrastructure and Chinese-language assets
- FOFA data is frequently cited in APT threat intelligence reports as a tool used for initial reconnaissance phases (MITRE ATT&CK T1596)
- Unlike active scanning, querying FOFA is **passive OSINT** — it leaves no footprint on the target's logs, making it hard to detect

## Related concepts
[[Shodan]] [[Censys]] [[Attack Surface Management]] [[OSINT]] [[Passive Reconnaissance]]