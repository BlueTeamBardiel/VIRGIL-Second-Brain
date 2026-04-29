# QGIS Server

## What it is
Think of it as a restaurant kitchen that takes geographic data orders from the dining room (clients) and sends back fully cooked map images — you never see the raw ingredients. QGIS Server is an open-source geospatial server that publishes map layers and spatial data as OGC-compliant web services (WMS, WFS, WCS, WMTS), built on the QGIS rendering engine. It runs as a FastCGI/FCGI application behind a web server like Apache or Nginx, exposing geographic datasets over HTTP.

## Why it matters
QGIS Server instances exposed to the internet without authentication have been leveraged by attackers to extract sensitive infrastructure data — pipeline routes, utility grids, and government facility locations — through unauthenticated WFS `GetFeature` requests that dump raw spatial datasets in GeoJSON or GML format. Defenders must audit OGC endpoint exposure and enforce authentication layers at the reverse proxy level, since QGIS Server itself ships with no built-in access control by default.

## Key facts
- **Default no-auth posture**: QGIS Server does not enforce authentication natively; access control must be implemented at the web server (Apache/Nginx) or via a middleware layer like GeoServer's security subsystem equivalent.
- **OGC attack surface**: WFS `GetFeature` and WMS `GetMap` requests can be manipulated to trigger excessive data exfiltration or server-side resource exhaustion (XML bomb via malformed filter parameters).
- **CVE exposure**: Older versions carry vulnerabilities including path traversal and SSRF via crafted layer source parameters pointing to internal network resources.
- **Sensitive data risk**: Spatial data classification is often overlooked; QGIS Server can inadvertently expose PII, critical infrastructure maps, or military assets if project files are misconfigured.
- **Log forensics**: Attacker enumeration of available layers is visible in FastCGI logs via repeated `GetCapabilities` requests — a key CySA+ detection pattern.

## Related concepts
[[Web Services Security]] [[Server-Side Request Forgery (SSRF)]] [[Information Disclosure Vulnerabilities]]