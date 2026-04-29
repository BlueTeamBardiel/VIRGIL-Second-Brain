# privilege misuse

## What it is
Like a janitor who has master keys to every room but starts rummaging through executive files on their lunch break — privilege misuse occurs when a legitimate, authorized user abuses their access rights beyond their intended scope. It's a insider threat vector where valid credentials and permissions are weaponized for unauthorized purposes, making it nearly invisible to perimeter-based defenses.

## Why it matters
In the 2020 Twitter hack, insider access was socially engineered to hijack high-profile accounts — but pure privilege misuse scenarios involve no manipulation: a database administrator quietly exfiltrating customer records using their everyday query tools. Because the activity uses authorized credentials and legitimate software, SIEM rules tuned for external attacks often generate no alerts whatsoever.

## Key facts
- Classified under **insider threats** in the MITRE ATT&CK framework; maps to tactics like Collection and Exfiltration using legitimately-held access
- **Least privilege** (PoLP) is the primary preventive control — users should have only the minimum permissions required to perform their job function
- **User and Entity Behavior Analytics (UEBA)** is the primary detective control, flagging anomalous access patterns even when credentials are valid
- Privilege misuse accounts for roughly **25-30% of data breaches** in Verizon DBIR data, consistently making it a top insider threat category
- Separation of duties (SoD) mitigates misuse by requiring multiple parties to complete sensitive operations, so no single user can act alone

## Related concepts
[[principle of least privilege]] [[insider threat]] [[user and entity behavior analytics]] [[separation of duties]] [[access control]]