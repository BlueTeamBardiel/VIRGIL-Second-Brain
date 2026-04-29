# INC Ransom

## What it is
Like a burglar who not only steals your valuables but photographs your private documents and tapes the ransom note to your front door for the neighbors to see, INC Ransom is a double-extortion ransomware group. Emerging in mid-2023, they exfiltrate sensitive data *before* encrypting victim systems, then threaten to publish stolen files on their leak site if the ransom isn't paid.

## Why it matters
In 2024, INC Ransom struck Yamaha Motor Philippines and multiple NHS Scotland health boards, exfiltrating patient records and operational data affecting hundreds of thousands of individuals. The healthcare targeting is particularly significant because HIPAA breach notification requirements force victims into a public disclosure corner — pay quietly or face regulatory exposure on top of reputational damage.

## Key facts
- **Active since July 2023**; targets span healthcare, education, manufacturing, and government sectors globally
- Uses **legitimate admin tools** for lateral movement (PsExec, AnyDesk, MEGAsync for exfiltration), making detection harder — this is a Living-off-the-Land (LotL) technique
- Initial access commonly achieved via **spear-phishing and exploitation of public-facing applications** (notably Citrix and VPN vulnerabilities)
- Operates a **dedicated leak site (DLS)** where partial data samples are posted as proof of exfiltration to pressure victims before the deadline
- Ransom demands have ranged from **$1 million to over $5 million USD**, negotiated via a Tor-based chat portal
- Encrypts files with a **custom extension (.INC)** and drops a ransom note named `INC-README.txt`

## Related concepts
[[Double Extortion Ransomware]] [[Living off the Land (LotL)]] [[Data Leak Sites]] [[Ransomware as a Service (RaaS)]] [[Incident Response]]