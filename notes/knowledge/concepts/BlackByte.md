# BlackByte

## What it is
Like a burglar who doesn't just rob your house but changes the locks and leaves a ransom note, BlackByte is a ransomware-as-a-service (RaaS) operation that encrypts victim data AND exfiltrates it for double extortion. It is a sophisticated ransomware family first observed in 2021, operated by a financially motivated threat group that recruits affiliates through underground forums.

## Why it matters
In February 2022, the FBI and USSS issued a joint advisory warning that BlackByte had compromised at least three critical U.S. infrastructure sectors, including government facilities and financial services. Defenders must focus on patching ProxyShell vulnerabilities (CVE-2021-34473) immediately, as BlackByte actively exploited these Microsoft Exchange flaws to gain initial access before deploying ransomware payloads.

## Key facts
- **Initial access vector:** Heavily exploited ProxyShell (Exchange Server vulnerabilities CVE-2021-34473, CVE-2021-34523, CVE-2021-31207) for entry
- **Double extortion model:** Exfiltrates data before encryption, then threatens to publish on a "leak site" if ransom isn't paid
- **Defense evasion:** Uses a vulnerable driver technique (Bring Your Own Vulnerable Driver / BYOVD) to disable security tools, including EDR solutions
- **Encryption quirk:** Early variants used a hardcoded symmetric key, allowing researchers to release a free decryptor — later versions corrected this flaw
- **RaaS structure:** Operates with core developers and recruited affiliates who keep ~80% of ransom payments, lowering the barrier for less-skilled attackers

## Related concepts
[[Ransomware-as-a-Service]] [[Double Extortion]] [[ProxyShell]] [[BYOVD Attack]] [[Lateral Movement]]