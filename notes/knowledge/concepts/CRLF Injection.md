# CRLF injection

## What it is
Imagine slipping a forged page into the middle of an official letter by exploiting the fact that the typist treats a special character sequence as "start a new line." CRLF injection occurs when an attacker inserts carriage return (`\r`, `0x0D`) and line feed (`\n`, `0x0A`) characters into user-supplied input that is later embedded in an HTTP header or log file, causing the parser to interpret the injected content as a new, legitimate line. This allows attackers to split responses, forge headers, or poison logs.

## Why it matters
A classic attack is **HTTP Response Splitting**: an attacker injects `\r\n\r\n` into a `Location:` redirect header, effectively terminating the original response and injecting a fully attacker-controlled second response. This can be used to perform cache poisoning against a shared proxy, causing thousands of users to receive malicious content cached as if it came from a trusted server.

## Key facts
- The characters involved are CR (`\r` / `0x0D`) and LF (`\n` / `0x0A`); HTTP/1.1 uses `\r\n` (CRLF) as the header delimiter, making these characters protocol-significant.
- **HTTP Response Splitting** is the primary exploit chain enabled by CRLF injection in web applications.
- CRLF injection in **log files** lets attackers forge log entries, covering tracks or framing other users.
- Mitigation requires **stripping or encoding** `\r` and `\n` from any user input before it is written into HTTP headers or logs — never trust raw input in header values.
- Modern frameworks (e.g., Python's `http.client`, Java's `HttpURLConnection`) have added built-in guards that throw exceptions on CRLF in headers, but legacy and custom implementations remain vulnerable.

## Related concepts
[[HTTP Response Splitting]] [[Header Injection]] [[Log Injection]]