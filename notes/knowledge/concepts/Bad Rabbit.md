# Bad Rabbit

## What it is
Like a wolf dressed in a sheepskin Adobe Flash installer, Bad Rabbit is ransomware that tricks users into downloading it willingly. It is a 2017 self-propagating ransomware strain that used a fake Flash Player update delivered via drive-by download, then spread laterally across networks using SMB and stolen credentials harvested by a Mimikatz-like credential dumper.

## Why it matters
In October 2017, Bad Rabbit crippled Ukrainian infrastructure targets including Odessa International Airport and the Kyiv Metro, demonstrating that ransomware can simultaneously extort individuals and disrupt critical public services. Defenders who had disabled SMBv1 and enforced application whitelisting significantly reduced lateral movement, showing how layered controls limit blast radius even when initial infection occurs.

## Key facts
- **Initial vector:** Fake Adobe Flash update hosted on compromised legitimate websites (watering hole attack), requiring user interaction to execute
- **Propagation method:** Used SMB for lateral movement combined with a built-in list of common weak credentials — no EternalBlue exploit required (unlike NotPetya)
- **Encryption:** Encrypted files AND overwrote the MBR (Master Boot Record) using the legitimate DiskCryptor tool, preventing boot-up
- **Ransom demand:** Approximately 0.05 Bitcoin with a countdown timer, delivered via a Tor-hosted payment page
- **Attribution:** Linked to the Sandworm APT group (Russia), the same actors behind NotPetya and the Ukrainian power grid attacks

## Related concepts
[[NotPetya]] [[Ransomware]] [[Drive-by Download]] [[Watering Hole Attack]] [[Lateral Movement]] [[Mimikatz]]