# ATT&CK T1571

## What it is  
Think of a smuggler slipping contraband in a seemingly innocent parcel—everyone thinks it’s a harmless package. In cybersecurity, attackers exfiltrate data by embedding it within legitimate web‑service traffic (e.g., Dropbox, Google Drive, OneDrive). The data travels over normal HTTPS channels, making it hard to distinguish from legitimate usage.  

## Why it matters  
A recent ransomware campaign exfiltrated financial records by uploading them to a compromised Google Workspace account before encrypting the host. The use of a trusted cloud service masked the exfiltration from traditional network egress controls, allowing attackers to avoid detection and maintain persistence.  

## Key facts  
-