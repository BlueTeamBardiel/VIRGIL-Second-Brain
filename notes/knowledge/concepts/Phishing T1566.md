# Phishing T1566

## What it is
Like a fisherman casting a lure that looks like real food, an attacker crafts a message that mimics a trusted source to trick victims into taking a harmful action. Phishing (MITRE ATT&CK T1566) is an initial access technique where adversaries send deceptive communications — typically email — to manipulate targets into revealing credentials, downloading malware, or clicking malicious links. It is the most common entry point for enterprise breaches.

## Why it matters
In the 2020 SolarWinds supply chain attack, spearphishing emails were used in earlier reconnaissance phases to harvest credentials from targeted organizations. Defenders must layer email security controls — SPF, DKIM, and DMARC records — alongside user awareness training, because technical controls alone cannot stop a convincingly crafted spearphish targeting a privileged user.

## Key facts
- **T1566.001** = Spearphishing Attachment (malicious file delivered via email)
- **T1566.002** = Spearphishing Link (URL leading to credential harvester or drive-by download)
- **T1566.003** = Spearphishing via Service (LinkedIn, Teams, Slack — not email)
- Spearphishing is *targeted* (named individual/org); phishing is *bulk/untargeted* — this distinction appears on CySA+ exams
- Vishing (voice), smishing (SMS), and whaling (C-suite targeting) are related variants but have separate ATT&CK sub-technique coverage
- Detection indicators include: unexpected attachments, mismatched sender domains, urgent language, and links with URL shorteners or homograph characters (e.g., `paypa1.com`)

## Related concepts
[[Social Engineering]] [[Initial Access TA0001]] [[DMARC Email Authentication]] [[Credential Harvesting]] [[Spearphishing]]