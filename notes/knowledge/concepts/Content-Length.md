# Content-Length

## What it is
Like writing the page count on the cover of a manuscript before mailing it — the recipient knows exactly how much to read before stopping. `Content-Length` is an HTTP header field that declares, in bytes, the exact size of the message body being sent in a request or response.

## Why it matters
Attackers exploit mismatches between declared and actual `Content-Length` to perform **HTTP Request Smuggling**. By carefully crafting a request where the frontend proxy trusts `Content-Length` while the backend trusts `Transfer-Encoding: chunked` (or vice versa), an attacker can "smuggle" a hidden second request into the pipeline, potentially hijacking another user's session or bypassing access controls — a real vulnerability class that has hit major platforms including PayPal and Netflix.

## Key facts
- When `Content-Length` and `Transfer-Encoding` headers both appear in the same request, RFC 7230 says `Transfer-Encoding` takes precedence — but inconsistent server implementations create the smuggling window
- A missing or incorrect `Content-Length` in a **response** can enable **response splitting**, allowing attackers to inject fake HTTP responses
- Web Application Firewalls (WAFs) can be bypassed if they parse `Content-Length` differently than the backend application server
- `Content-Length: 0` is valid and commonly used in POST requests with no body (e.g., some REST API acknowledgments)
- Slowloris DoS attacks exploit slow delivery of body bytes relative to the declared `Content-Length`, keeping connections open and exhausting server resources

## Related concepts
[[HTTP Request Smuggling]] [[Transfer-Encoding]] [[HTTP Response Splitting]] [[Slowloris Attack]] [[WAF Bypass]]