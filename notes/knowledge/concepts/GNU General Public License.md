# GNU General Public License

## What it is
Like a recipe that anyone can cook from — but only if they agree to also share any improved version of the recipe — the GNU General Public License (GPL) is a "copyleft" software license that grants users freedom to run, study, modify, and distribute software, provided that all derivative works carry the same license terms. It was created by Richard Stallman in 1989 to ensure software freedom cannot be stripped away by proprietary forks.

## Why it matters
In security contexts, GPL compliance is a real attack surface for organizations: companies shipping embedded devices (routers, IoT hardware) with GPL-licensed firmware (like Linux) are legally required to release source code, meaning adversaries can audit that exact codebase for unpatched vulnerabilities. Conversely, defenders benefit because open source code enables community-driven security review — the same transparency that exposes flaws also enables rapid, coordinated patching (as seen with Linux kernel CVEs).

## Key facts
- **GPL v2 vs v3**: GPLv3 (2007) added explicit patent retaliation clauses and anti-tivoization provisions, preventing hardware from blocking modified software from running
- **Copyleft requirement**: Any software that incorporates GPL code and is *distributed* must also be released under the GPL — this is the "viral" or "copyleft" property
- **SaaS loophole**: Running GPL software as a network service (SaaS) does *not* trigger distribution requirements — the GNU Affero GPL (AGPL) closes this gap
- **Supply chain risk**: Failure to comply with GPL obligations can result in legal injunctions forcing a product off the market — a non-technical business continuity threat
- **FOSS in security tools**: Many critical security tools (Metasploit framework core, Wireshark, nmap) are GPL-licensed, meaning organizations can inspect and validate their exact behavior

## Related concepts
[[Open Source Software Security]] [[Software Supply Chain Risk]] [[License Compliance]] [[Vulnerability Disclosure]]