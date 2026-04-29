# DirectoryPress

## What it is
Like a bulletin board at a community center that anyone can pin flyers to — DirectoryPress is a WordPress plugin that creates searchable, user-submitted business or member directories on websites. Precisely, it is a WordPress directory listing plugin that allows frontend form submissions, enabling visitors to add, edit, and manage directory entries without backend access.

## Why it matters
Plugins like DirectoryPress that accept unauthenticated or low-privilege user input are historically prime targets for injection and file upload attacks. An attacker could exploit a vulnerable version to submit a malicious listing containing stored XSS payloads, which then execute in the browser of any admin who reviews pending submissions — effectively hijacking administrator sessions without ever touching the login page.

## Key facts
- DirectoryPress is a **third-party WordPress plugin**, meaning it exists outside WordPress core and receives independent security patches — a common blind spot in patch management programs.
- Stored **Cross-Site Scripting (XSS)** is the most common vulnerability class found in directory-style plugins accepting frontend submissions.
- Vulnerable plugin versions may also permit **unauthorized file uploads**, potentially enabling webshell deployment if upload directories lack proper MIME-type validation.
- WordPress plugins collectively represent one of the largest attack surfaces for web application compromises — over **90% of hacked WordPress sites** involve vulnerable plugins or themes, not core WordPress.
- Defense-in-depth controls include: input sanitization/output encoding, strict file upload whitelisting, and using a **Web Application Firewall (WAF)** with WordPress-specific rulesets.

## Related concepts
[[Cross-Site Scripting (XSS)]] [[File Upload Vulnerabilities]] [[WordPress Attack Surface]] [[Third-Party Component Risk]] [[Web Application Firewall]]