# grep

## What it is
Like a metal detector sweeping a beach for coins, `grep` scans through text and surfaces only the lines matching a pattern you define. It is a command-line utility on Unix/Linux systems that searches files or standard input for strings or regular expressions, printing every matching line to output.

## Why it matters
During incident response, analysts use `grep` to tear through thousands of lines of web server logs in seconds — for example, `grep -i "union select" /var/log/apache2/access.log` instantly surfaces potential SQL injection attempts without opening a single file manually. Attackers also abuse `grep` post-compromise to harvest credentials from config files, hunting for strings like "password" or "api_key" across an entire filesystem.

## Key facts
- `-r` (recursive) flag searches all files within a directory tree, making it lethal for credential harvesting: `grep -r "password" /var/www/`
- `-i` makes searches case-insensitive, critical for catching evasion attempts like `PASSWORD`, `Password`, or `pAsSwOrD`
- `-v` inverts the match — returns lines that do NOT match — useful for filtering out noise (e.g., removing known-good IPs from logs)
- `-E` enables extended regular expressions (ERE), allowing complex pattern matching like `grep -E "([0-9]{1,3}\.){3}[0-9]{1,3}" logfile` to extract IP addresses
- `-c` counts matching lines rather than printing them — useful for quantifying how many events occurred during a specific attack window

## Related concepts
[[Log Analysis]] [[Regular Expressions]] [[Incident Response]] [[Command Line Forensics]] [[SIEM]]