# ASP

## What it is
Think of ASP like a waiter who takes your order (HTTP request), runs to the kitchen (server-side scripting engine), and brings back a custom meal (dynamic HTML) — rather than just handing you a pre-made sandwich. Active Server Pages (ASP) is Microsoft's legacy server-side scripting framework that executes VBScript or JScript on the web server to dynamically generate HTML responses before sending them to the client. It runs on IIS (Internet Information Services) and was largely superseded by ASP.NET.

## Why it matters
Classic ASP applications are notorious attack surfaces because they frequently concatenate user input directly into SQL queries, enabling SQL injection. A poorly written ASP login page might construct `SELECT * FROM users WHERE username='` + Request("user") + `'`, allowing an attacker to inject `' OR '1'='1` and bypass authentication entirely — a vulnerability that still appears in legacy enterprise systems running Windows Server environments.

## Key facts
- ASP files use the `.asp` extension and execute on the server via IIS before any content reaches the browser
- Default scripting language is VBScript; classic ASP has no built-in parameterized query support, making SQLi almost inevitable in naive code
- ASP runs in the context of the IIS worker process; misconfigured permissions can allow attackers to read sensitive server files or escalate privileges
- Uploading a malicious `.asp` webshell to a vulnerable IIS server gives an attacker remote command execution — a common post-exploitation technique
- Classic ASP is distinct from ASP.NET; ASP.NET uses compiled code and has stronger built-in security controls like request validation and managed memory

## Related concepts
[[SQL Injection]] [[Web Shell]] [[IIS Security]] [[Server-Side Scripting]] [[Input Validation]]