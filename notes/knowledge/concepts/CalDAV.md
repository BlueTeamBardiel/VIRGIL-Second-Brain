# CalDAV

## What it is
Think of CalDAV as a shared whiteboard for calendars — anyone with the right key can read, write, or erase appointments across the network in real time. Precisely, CalDAV (Calendaring Extensions to WebDAV) is an internet standard protocol (RFC 4791) that allows clients to access and manage calendar data stored on a remote server using HTTP/HTTPS as the transport layer.

## Why it matters
In 2019, researchers demonstrated that misconfigured CalDAV servers — particularly older macOS Server and open-source Nextcloud instances — exposed calendar data without authentication, leaking meeting titles, attendee lists, and location data that attackers could use for spear-phishing or executive targeting. Defenders should ensure CalDAV endpoints require mutual authentication and are not publicly enumerable, since calendar metadata alone can reveal organizational structure and travel schedules.

## Key facts
- CalDAV extends **WebDAV** (itself an extension of HTTP), meaning it inherits HTTP verbs like GET, PUT, DELETE, and adds REPORT for calendar queries
- Data is stored and transmitted in **iCalendar (.ics) format**, making it human-readable and trivially parseable if intercepted over plain HTTP
- Default ports: **80 (HTTP)** and **443 (HTTPS)**; some implementations also use **8008** or **8443**
- Authentication options include **Basic Auth** (dangerous over HTTP), **Digest Auth**, and **OAuth 2.0** — Basic over cleartext is a critical misconfiguration
- CalDAV servers expose a **well-known URI** (`/.well-known/caldav`) for autodiscovery, which can be fingerprinted during reconnaissance

## Related concepts
[[WebDAV]] [[iCalendar]] [[CardDAV]] [[HTTP Authentication]] [[Information Disclosure]]