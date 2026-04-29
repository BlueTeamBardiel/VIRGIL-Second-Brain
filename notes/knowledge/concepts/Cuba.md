# Cuba

## What it is
Like a locksmith who breaks into your house, steals your valuables, *and* demands rent to give them back — Cuba is a ransomware-as-a-service (RaaS) operation that combines data exfiltration with encryption extortion. First observed around 2019, it targets critical infrastructure sectors and uses a double-extortion model where stolen data is threatened for public release if ransom is unpaid.

## Why it matters
In 2022, the FBI and CISA issued a joint advisory warning that Cuba ransomware had compromised over 100 organizations worldwide, collecting more than $60 million in ransom payments. Defenders studying this campaign learned the critical importance of monitoring for living-off-the-land binaries (LOLBins) like `cmd.exe` and `PowerShell`, as Cuba operators heavily abuse legitimate tools to evade detection during lateral movement.

## Key facts
- Cuba ransomware is distributed through the **Hancitor malware loader**, often delivered via phishing emails with malicious document attachments
- Operators exploit **unpatched vulnerabilities** in Microsoft Exchange (including ProxyLogon/ProxyShell) and abuse legitimate remote management tools like **Remote Desktop Protocol (RDP)**
- Uses **double-extortion**: files are both encrypted AND exfiltrated; stolen data is published on a dedicated leak site called "Cuba" if ransom is refused
- Appended file extension on encrypted files is **`.cuba`** — a simple but forensically useful indicator of compromise (IOC)
- FBI/CISA advisory (December 2022) classified Cuba as a significant threat to **critical infrastructure**, including financial, government, and healthcare sectors

## Related concepts
[[Ransomware-as-a-Service]] [[Double Extortion]] [[Hancitor]] [[Living-off-the-Land Attacks]] [[Indicators of Compromise]]