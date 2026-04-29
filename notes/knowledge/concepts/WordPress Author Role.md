# WordPress Author Role

## What it is
Think of it like a newspaper contributor who can write and publish their own articles, but cannot touch the printing press settings or other reporters' work. In WordPress, the Author role allows a user to create, edit, publish, and delete their *own* posts, upload files, and manage their own content — but cannot modify plugins, themes, or other users' content.

## Why it matters
The Author role becomes a critical attack surface because it permits file uploads, which can be weaponized if WordPress or a plugin fails to properly validate MIME types. An attacker who compromises or registers as an Author account can upload a malicious PHP file disguised as an image, potentially achieving Remote Code Execution (RCE) on the server — a privilege escalation from a low-trust user role to full system compromise.

## Key facts
- Author is the **third highest** WordPress role in the default hierarchy: Administrator → Editor → Author → Contributor → Subscriber
- Authors can **publish posts independently** — unlike Contributors, who require Editor/Admin approval before publication
- The file upload capability (`upload_files` capability) is the primary attack vector; Authors inherit it by default
- Exploiting Author-level XSS vulnerabilities in post content can target higher-privileged users (Editors/Admins) who review content
- Stored XSS injected by an Author into a post can **escalate to Admin privileges** if an Administrator views the malicious post in the dashboard

## Related concepts
[[Privilege Escalation]] [[Stored Cross-Site Scripting (XSS)]] [[File Upload Vulnerability]] [[Least Privilege Principle]] [[Remote Code Execution (RCE)]]