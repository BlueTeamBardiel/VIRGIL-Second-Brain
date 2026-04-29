# Nelio AB Testing

## What it is
Like a chef serving two versions of a dish to different tables to see which gets better reviews, Nelio AB Testing is a WordPress plugin that splits website traffic between two or more page variants to measure which performs better. It is a legitimate conversion rate optimization (CRO) tool that modifies page content, headlines, and calls-to-action for different visitor segments and tracks statistical outcomes.

## Why it matters
Attackers who compromise a WordPress site with Nelio AB Testing installed can abuse its traffic-splitting functionality to serve malicious content — such as phishing forms or drive-by downloads — to a targeted percentage of visitors while keeping the legitimate page visible to others, making detection significantly harder. This technique mirrors "island hopping" supply chain attacks, where the plugin becomes the delivery mechanism rather than the payload itself. Security analysts performing CySA+ style threat hunts should flag unexpected AB test variants containing obfuscated JavaScript or external resource calls as high-priority indicators of compromise.

## Key facts
- Nelio AB Testing runs as a **WordPress plugin** (wordpress.org/plugins/nelio-ab-testing), making it subject to all WordPress attack surfaces including plugin vulnerabilities, credential stuffing, and XML-RPC abuse.
- Versions prior to **5.0.10** contained authenticated privilege escalation vulnerabilities allowing lower-privileged users to modify test configurations and inject content.
- Attackers can exploit AB testing infrastructure for **traffic splitting malware delivery**, targeting only a statistically small percentage of users to evade behavioral detection thresholds.
- Plugin files stored in `/wp-content/plugins/nelio-ab-testing/` should be monitored for **unauthorized file modification** as part of file integrity monitoring (FIM) controls.
- The plugin communicates with Nelio's external cloud API, creating a potential **data exfiltration or C2 channel** if the endpoint is spoofed or the API key is stolen.

## Related concepts
[[WordPress Security]] [[Supply Chain Attack]] [[File Integrity Monitoring]] [[Drive-by Download]] [[JavaScript Injection]]