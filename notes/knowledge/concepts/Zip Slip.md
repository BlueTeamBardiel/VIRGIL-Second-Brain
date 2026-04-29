# Zip Slip

## What it is
Imagine a moving company employee unpacking boxes and placing items wherever the label says — including "../../upstairs/medicine_cabinet" — without questioning whether that destination is safe. Zip Slip is a directory traversal vulnerability triggered during archive extraction, where maliciously crafted file paths (e.g., `../../etc/cron.d/backdoor`) inside a ZIP, TAR, JAR, or WAR file cause the extractor to write files outside the intended destination directory. If the extraction process runs with elevated privileges, an attacker can overwrite critical system files or plant executables.

## Why it matters
In 2018, security firm Snyk discovered Zip Slip affecting thousands of open-source libraries across Go, Java, JavaScript, Ruby, and Python ecosystems. An attacker could craft a malicious archive, trick a CI/CD pipeline or deployment tool into extracting it, and overwrite a startup script — gaining persistent code execution on the build server with no authentication required.

## Key facts
- **Root cause:** Archive extraction libraries that fail to sanitize or canonicalize file entry paths before writing to disk.
- **Detection signature:** Entry paths containing `../` sequences (or URL-encoded equivalents) that resolve outside the target extraction directory.
- **Fix:** Canonicalize the resolved output path and verify it starts with the intended destination prefix before writing any file.
- **Privilege escalation risk:** Severity multiplies when extraction runs as root or SYSTEM — a single overwritten sudoers or cron file can yield full compromise.
- **Common affected formats:** ZIP, TAR, GZip, TAR.GZ, bzip2, JAR, WAR — any format where the archive stores arbitrary path strings.

## Related concepts
[[Directory Traversal]] [[Path Canonicalization]] [[Arbitrary File Write]] [[Supply Chain Attack]]