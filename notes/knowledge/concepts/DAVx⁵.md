# DAVx⁵

## What it is
Think of it as a dedicated postal worker who knows exactly how to speak both your Android phone's language and your calendar/contacts server's language — translating between them so mail never gets lost. DAVx⁵ is an open-source CalDAV/CardDAV synchronization client for Android that bridges personal devices with self-hosted or third-party groupware servers (Nextcloud, Radicale, etc.). It operates as a sync adapter, handling authentication and encrypted data transport between the device and the server.

## Why it matters
In enterprise BYOD environments, employees may install DAVx⁵ to sync work calendars from a self-hosted Nextcloud server instead of using corporate MDM-approved solutions — creating an unmanaged data path outside IT visibility. An attacker who compromises the DAVx⁵ account credentials (often stored in Android's AccountManager) gains access to contacts, calendars, and task data, which can feed spear-phishing campaigns with precise scheduling and relationship intelligence.

## Key facts
- DAVx⁵ uses **OAuth 2.0 or HTTP Basic/Digest authentication** to connect to CalDAV/CardDAV endpoints; Basic Auth over unencrypted HTTP exposes credentials in cleartext
- Credentials are stored in Android's **AccountManager**, making them accessible to apps with `GET_ACCOUNTS` permission on older Android versions (pre-8.0)
- Because it syncs to **self-hosted servers**, it can bypass corporate DLP controls that only monitor cloud SaaS platforms like Google Workspace
- DAVx⁵ respects **TLS certificate validation** and warns users of mismatches, but users can manually accept invalid certs — a risk vector for MITM attacks
- It is **not pre-installed** and requires F-Droid or sideloading, meaning its presence on a corporate device may indicate policy violation or shadow IT

## Related concepts
[[CalDAV]] [[CardDAV]] [[OAuth 2.0]] [[Android AccountManager]] [[Shadow IT]]