# M3U

## What it is
Think of M3U as a restaurant menu that lists where the kitchen keeps each dish — it doesn't contain the food itself, just the locations. Precisely, M3U (MP3 URL) is a plain-text playlist file format that contains a list of file paths or URLs pointing to media resources, originally designed for Winamp audio playlists but extended to support streaming video via M3U8 (UTF-8 encoded variant used in HLS streaming).

## Why it matters
Attackers weaponize M3U files in **Server-Side Request Forgery (SSRF)** and **credential harvesting** attacks — a malicious M3U file can reference a URL on an internal network, causing a media player to make unauthorized outbound requests and leak NTLM hashes when connecting to an attacker-controlled SMB server. In 2021, VLC and other media players were targeted with crafted M3U files that triggered buffer overflows simply by parsing malformed playlist entries, turning a "harmless" playlist into a remote code execution vector.

## Key facts
- M3U files are plain text with `.m3u` or `.m3u8` extensions; M3U8 is the basis of **HTTP Live Streaming (HLS)** used by major streaming platforms
- Extended M3U uses `#EXTM3U` header and `#EXTINF` tags; malformed tags have historically triggered parser vulnerabilities
- Media players often process M3U files **automatically** without user confirmation, making them effective phishing lure attachments
- M3U can reference **SMB paths** (`\\attacker\share\`), enabling NTLM hash capture via tools like Responder
- Because content is fetched at **parse time**, not play time, a victim never needs to click "play" for an attack to succeed

## Related concepts
[[Server-Side Request Forgery (SSRF)]] [[NTLM Hash Capture]] [[HTTP Live Streaming (HLS)]] [[Phishing Attachments]] [[Buffer Overflow]]