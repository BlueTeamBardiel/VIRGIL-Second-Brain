# Ember Bear

## What it is
Like a state-sponsored carpenter who breaks into your house not just to steal blueprints but to leave the doors unlocked for the next crew, Ember Bear is a Russian GRU-linked APT group (also tracked as UAC-0056, Saint Bear, and DEV-0586) known for destructive cyberattacks paired with data theft operations. They are distinguished by their dual mission: espionage combined with deployment of destructive wipers.

## Why it matters
In January–February 2022, Ember Bear targeted Ukrainian government organizations by deploying WhisperGate, malware disguised as ransomware that actually overwrote the Master Boot Record and destroyed files permanently. This attack demonstrated how nation-state actors use fake ransomware as a cover story to mask pure destruction—a key pattern defenders must recognize because the remediation path (restore from backup) differs from true ransomware (negotiate/decrypt).

## Key facts
- **Attribution**: Linked to Russia's GRU Unit 161, active since at least 2021, primarily targeting Ukraine and NATO-aligned nations
- **WhisperGate**: Their signature malware—a two-stage wiper masquerading as ransomware; Stage 1 corrupts MBR, Stage 2 destroys files using a fake ransomware note
- **Initial Access TTPs**: Spearphishing, stolen credentials, and exploitation of internet-facing applications (MITRE ATT&CK T1190)
- **Defacement + Destruction**: Ember Bear combined website defacement ("be afraid") with wiper deployment simultaneously—psychological operation layered on top of technical destruction
- **CISA Advisory**: Joint advisory AA22-057A from CISA/FBI specifically warned critical infrastructure operators about Ember Bear TTPs ahead of Russian military operations in Ukraine

## Related concepts
[[WhisperGate]] [[Advanced Persistent Threat]] [[Destructive Malware]] [[Nation-State Actors]] [[MITRE ATT&CK]]