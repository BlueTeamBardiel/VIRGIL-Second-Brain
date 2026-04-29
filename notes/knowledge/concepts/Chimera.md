# Chimera

## What it is
Like a mythological beast stitched together from lion, goat, and serpent, Chimera is a hybrid attack framework that blends multiple threat techniques into a single, cohesive campaign. Specifically, Chimera refers to a threat actor group (and their associated tactics) known for combining network intrusion, credential harvesting, and living-off-the-land techniques simultaneously to achieve long-term, stealthy persistence inside semiconductor and airline industry targets.

## Why it matters
In documented attacks against Taiwanese semiconductor firms around 2019–2020, Chimera operators breached corporate networks, then quietly pivoted to cloud collaboration tools like Google Docs and Dropbox to host command-and-control (C2) instructions — a technique that bypasses traditional network-based detection because the traffic blends in with legitimate SaaS usage. Defenders who only monitor for known malicious IP addresses would miss the C2 channel entirely, illustrating why behavioral analysis and DLP controls on cloud services are critical.

## Key facts
- Chimera is attributed to a suspected Chinese state-sponsored threat group targeting intellectual property in semiconductors and civil aviation
- Their signature tactic is **cloud service abuse for C2** — embedding commands inside legitimate Google Drive or Dropbox documents to evade firewall and IDS rules
- They leverage **stolen credentials** harvested from third-party breaches to gain initial access, bypassing the need for custom exploits
- Use of **living-off-the-land binaries (LOLBins)** such as PowerShell and CertUtil makes their activity difficult to distinguish from normal administrator behavior
- Classified as an **APT (Advanced Persistent Threat)** — their campaigns emphasize long dwell time and stealth over loud, destructive impact

## Related concepts
[[Advanced Persistent Threat]] [[Living off the Land]] [[Command and Control]] [[Credential Stuffing]] [[Cloud Security]]