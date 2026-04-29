# web servers

## What it is
Think of a web server like a librarian who sits at a desk all day — when you hand them a request slip (HTTP GET), they fetch the exact document and hand it back. Precisely: a web server is software (Apache, Nginx, IIS) that listens on TCP port 80 (HTTP) or 443 (HTTPS), accepts client requests, and returns resources like HTML, images, or API responses.

## Why it matters
In 2021, a misconfigured Apache web server at a financial firm exposed a `/admin` directory with directory listing enabled, allowing attackers to enumerate backup files containing plaintext credentials. Hardening web servers — disabling directory listing, removing default pages, applying strict file permissions — is a frontline defense against reconnaissance and data exposure.

## Key facts
- Default ports: HTTP = TCP 80, HTTPS = TCP 443; running on non-standard ports (e.g., 8080, 8443) doesn't provide real security, only minor obscurity
- Common web servers: Apache (`.htaccess` config), Nginx (reverse proxy favorite), Microsoft IIS (Windows-integrated, uses `web.config`)
- Attack surface includes HTTP methods — `PUT` and `DELETE` should be disabled unless explicitly required; leaving them enabled can allow file upload or deletion
- Banner grabbing (via `curl -I` or Netcat) reveals server type and version, enabling targeted exploits — always suppress or falsify server headers in production
- Web server logs (access.log, error.log) are primary forensic sources for detecting SQLi attempts, directory traversal (`../`), and 4xx/5xx error spikes indicating enumeration

## Related concepts
[[HTTP and HTTPS]] [[TLS/SSL]] [[directory traversal]] [[reverse proxy]] [[web application firewall]]