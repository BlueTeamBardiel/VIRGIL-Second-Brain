# URL-based access control

## What it is
Like a bouncer checking whether your wristband color matches the VIP section you're trying to enter — except the wristband is just the URL path you typed. URL-based access control restricts user access to resources by inspecting the requested URL and comparing it against authorization rules before allowing entry. It operates at the application layer, often enforced by web servers, reverse proxies, or middleware configurations.

## Why it matters
In 2020, a misconfigured URL access control rule on a healthcare portal allowed unauthenticated users to access `/admin/patient-records` simply by typing the path directly — bypassing a login form that was only enforced on the homepage. This is called a **forced browsing** or **direct object reference** attack, where the protection lives only in the navigation links, not in the server-side enforcement logic. Proper URL-based controls must validate authorization on *every request*, not just the entry point.

## Key facts
- URL-based access control is a form of **authorization**, not authentication — it governs what authenticated (or unauthenticated) users can reach
- **Security-by-obscurity** is not access control — hiding a URL like `/internal/report_2024.pdf` provides zero protection if the server doesn't enforce authorization on that path
- Misconfigured URL access controls are categorized under **OWASP A01: Broken Access Control**, the top web application vulnerability class
- Enforcement must occur **server-side**; client-side checks (hidden buttons, disabled links) are trivially bypassed
- Common implementation vectors include `.htaccess` rules (Apache), `web.config` (IIS), and middleware route guards in frameworks like Spring Security or ASP.NET

## Related concepts
[[Broken Access Control]] [[Forced Browsing]] [[Insecure Direct Object Reference]] [[Least Privilege]] [[Authentication vs Authorization]]