# Dropbox

## What it is
Think of Dropbox like a postal locker that both sender and recipient share a key to — files dropped in one location magically appear in another. Precisely, Dropbox is a cloud-based file synchronization and storage service that maintains a local folder mirrored to cloud storage, syncing changes across all connected devices in near real-time.

## Why it matters
Attackers frequently abuse Dropbox as a Command-and-Control (C2) channel because its traffic blends seamlessly into normal HTTPS business traffic and is rarely blocked by corporate firewalls. Malware families like DropboxC2 and early APT campaigns have used the Dropbox API to receive commands and exfiltrate stolen data, making detection difficult since defenders see only legitimate Dropbox domain traffic.

## Key facts
- Dropbox operates over HTTPS (port 443), meaning its C2 abuse evades most port-based firewall rules and mimics legitimate SaaS traffic
- OAuth tokens used to authenticate Dropbox API calls can be stolen and abused without requiring the victim's actual credentials — token theft is a primary attack vector
- Dropbox falls under the **shared responsibility model**: Dropbox secures the infrastructure; the user/organization is responsible for access controls and data classification
- Sensitive data uploaded to personal Dropbox accounts by employees is a common **data exfiltration** and **shadow IT** risk, violating DLP policies
- Forensic artifacts of Dropbox usage appear in `%APPDATA%\Dropbox` on Windows, including cached files and SQLite databases useful during incident response

## Related concepts
[[Cloud Storage Security]] [[Command and Control (C2)]] [[Data Loss Prevention (DLP)]] [[Shadow IT]] [[OAuth]]