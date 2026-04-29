# Open Source

## What it is
Like a recipe published in a cookbook — anyone can read it, cook from it, improve it, or spot that it calls for spoiled milk. Open source software is code made publicly available under licenses that allow anyone to inspect, modify, and distribute it. Unlike proprietary "black-box" software, the entire codebase is transparent and community-auditable.

## Why it matters
In 2021, the Log4Shell vulnerability (CVE-2021-44228) was discovered in Log4j, an open source Java logging library embedded in thousands of enterprise products. Because the code was public, researchers could rapidly analyze the flaw — but attackers could do the same, and mass exploitation began within hours of disclosure. The transparency cuts both ways: faster patches, but also a published roadmap for attackers.

## Key facts
- Open source licenses (MIT, GPL, Apache) grant usage rights but vary in copyleft obligations — GPL requires derivative works to remain open source
- "Many eyes" principle: public code theoretically gets more security scrutiny, but only if someone is actually looking (Heartbleed lived in OpenSSL for 2 years)
- Software Composition Analysis (SCA) tools scan codebases for known vulnerable open source components — directly tested on CySA+
- SBOM (Software Bill of Materials) is a formal inventory of open source components in a product, now mandated by US Executive Order 14028
- CVE/NVD databases heavily track open source vulnerabilities because the code is inspectable and reproducible

## Related concepts
[[Software Composition Analysis]] [[CVE]] [[Supply Chain Attack]] [[SBOM]] [[Patch Management]]