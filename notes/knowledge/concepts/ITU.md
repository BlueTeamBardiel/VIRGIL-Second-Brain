# ITU

## What it is
Think of it as the United Nations specifically for telecommunications — a global referee that sets the rules so a phone call from Tokyo can reach Toronto without chaos. The International Telecommunication Union (ITU) is a specialized UN agency responsible for coordinating international standards, radio spectrum allocation, and satellite orbits for telecommunications and information technologies. Its X-series and T-series recommendations (like X.509 for digital certificates) directly underpin modern security infrastructure.

## Why it matters
When you validate a TLS certificate in your browser, you're relying on the X.509 standard — an ITU-T recommendation. If ITU standards weren't universally adopted, an attacker could exploit inconsistent certificate handling across different national implementations, enabling certificate spoofing or man-in-the-middle attacks against cross-border communications. Nation-state actors also engage in ITU processes to influence standards in ways that could embed surveillance-friendly weaknesses.

## Key facts
- ITU-T (Telecommunication Standardization Sector) produces the **X.509** standard, which defines the format for public key certificates used in PKI, TLS, and S/MIME
- The **X.800** series defines a security architecture for OSI, covering authentication, access control, non-repudiation, and confidentiality frameworks
- ITU operates through three sectors: **ITU-T** (standards), **ITU-R** (radio/spectrum), and **ITU-D** (development)
- ITU-T **X.500** defines the Directory Services framework that X.509 was built upon — understanding this lineage helps explain certificate hierarchy design
- The ITU Global Cybersecurity Index (GCI) benchmarks countries' national cybersecurity posture — relevant context for geopolitical risk assessments in enterprise security planning

## Related concepts
[[X.509]] [[PKI]] [[TLS]] [[Certificate Authority]] [[OSI Model]]