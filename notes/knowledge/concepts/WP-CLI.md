# WP-CLI

## What it is
Think of it as a TV remote for WordPress — instead of clicking through the dashboard, you issue commands directly from the terminal. WP-CLI (WordPress Command Line Interface) is an open-source tool that allows administrators to manage WordPress installations, plugins, themes, users, and databases entirely through shell commands without needing a browser or GUI.

## Why it matters
Attackers who gain shell access to a compromised web server can weaponize WP-CLI to silently create rogue administrator accounts (`wp user create attacker evil@attacker.com --role=administrator`) or install backdoored plugins without triggering normal audit logs. Defenders use it offensively in the other direction — rapidly auditing hundreds of WordPress sites in a hosting environment for outdated plugins (`wp plugin list --update=available`) or resetting all user passwords after a breach.

## Key facts
- `wp core update`, `wp plugin update --all`, and `wp theme update --all` are the primary commands for patch management — failure to automate these is a leading cause of WordPress compromise
- WP-CLI requires local file system access or SSH; it cannot be executed purely through HTTP, making it a post-exploitation tool for attackers who already have a foothold
- Running `wp user list` instantly enumerates all accounts and their roles — a critical step in privilege escalation reconnaissance
- `wp eval` and `wp eval-file` can execute arbitrary PHP code, making them highly dangerous if WP-CLI is exposed with improper file permissions
- Misconfigurations leaving `wp-cli.yml` configuration files world-readable can leak database credentials and environment details

## Related concepts
[[Privilege Escalation]] [[Web Application Hardening]] [[Remote Code Execution]] [[Post-Exploitation]] [[CMS Security]]