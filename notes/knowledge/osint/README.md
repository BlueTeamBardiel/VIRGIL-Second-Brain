# OSINT — Open Source Intelligence for IT Professionals
> Everything your target left public. Most organizations leave too much.

OSINT is intelligence gathered from publicly available sources — no hacking required, no laws broken. It's used by penetration testers for reconnaissance, by threat intel analysts to track threat actors, by HR for background checks, and by attackers to build targeting packages before a phishing campaign. Understanding OSINT makes you better at defense: you'll know what attackers can see about your organization before they show up.

---

## Legal Framework: Passive vs Active

**Passive reconnaissance (OSINT):** You observe publicly available data without touching the target's systems. Legal everywhere. Google search, WHOIS lookup, Shodan query, LinkedIn browse — all passive.

**Active reconnaissance:** You send packets to the target — port scans, web crawling, banner grabbing. This may violate computer access laws depending on jurisdiction and authorization. Never do active recon against systems you don't own or have written permission to test.

**The gray zone:** Some tools (Shodan, Censys) scan the entire internet and cache results. Querying them for a target's IP is technically passive (you're querying Shodan's database, not the target). But the original data was gathered by active scanning of their infrastructure. Legally passive, but understand what you're looking at.

---

## Categories of OSINT

### People Intelligence

**LinkedIn:** Job history, skills, endorsements, colleagues, org chart. Useful for:
- Identifying key personnel (IT admin, CFO — who to target in spear phishing)
- Understanding technology stack from job postings and employee skills
- Finding names + emails for social engineering targeting

**Social media:** Facebook (personal info), Twitter/X (opinions, travel, routine), Instagram (location data in metadata). EXIF data in photos can reveal GPS coordinates of where images were taken.

**Data breach databases:**
- [HaveIBeenPwned](https://haveibeenpwned.com) — check if an email was in a known breach
- Dehashed (paid) — search breach data by email, name, IP, password hash
- IntelX — breach data, dark web, leaked documents

**Voter records:** Publicly available in many US states. Contains name, address, DOB, party affiliation.

---

### Organization Intelligence

**WHOIS:** Domain registration data. Registrant name, org, email, nameservers, registration/expiry dates.
```bash
whois example.com
whois 192.168.1.1      # IP WHOIS — find owning org
```

**DNS records:** Enumerate a target's infrastructure.
```bash
# Basic DNS lookups
nslookup example.com
dig example.com ANY
dig example.com MX      # mail servers
dig example.com TXT     # SPF, DKIM, verification tokens
dig example.com NS      # nameservers

# Zone transfer (if misconfigured — reveals all subdomains)
dig axfr @ns1.example.com example.com

# Subdomain enumeration
# Tools: amass, subfinder, dnsrecon
dnsrecon -d example.com -t brt -D /usr/share/wordlists/dnsmap.txt
```

**Job postings (tech stack enumeration):** "Required: Splunk Enterprise, CrowdStrike Falcon, AWS, Terraform" tells an attacker exactly what systems to research exploits for. A full job req is essentially a technology inventory.

---

### Infrastructure Intelligence

**Shodan** — the search engine for internet-connected devices.
```
# Find web servers at a company
org:"Target Company" http.title:"Dashboard"

# Find open RDP ports
port:3389 org:"Target Company"

# Find industrial control systems
product:"Siemens" country:US

# Default credentials
"default password" port:80

# Find exposed cameras
product:"Webcam" country:US has_screenshot:true
```

Shodan indexes banners, certificates, and metadata from every port it scans. It shows you open ports, running services, SSL certificates, and sometimes full HTTP response bodies — without touching the target.

**Censys** — similar to Shodan, different data. Better for certificate analysis and TLS fingerprinting.

**Certificate Transparency Logs — crt.sh:**
Certificate authorities must log every cert to public CT logs. `crt.sh` lets you search them. Reveals all subdomains that have ever had a certificate issued.

```bash
# Find all subdomains of example.com that have certs
curl -s "https://crt.sh/?q=%.example.com&output=json" | jq '.[].name_value' | sort -u
```

**BGP/ASN data:** Find all IP ranges owned by an organization.
```bash
# Find ASN for a company
whois -h whois.radb.net -- '-i origin AS12345'

# Tools: bgp.he.net, team-cymru.com/IP-ASN-mapping
```

**Wayback Machine (archive.org):** Old versions of websites. Useful for finding:
- Removed pages that revealed internal structure
- Old job postings naming specific vendors
- Previous employee directories
- Development/staging subdomains that were temporarily public

---

### Document Intelligence

**Google Dorking** — Advanced Google search operators (see section below).

**Metadata in documents:** PDFs, Word docs, images often contain metadata (author, creation software, GPS coordinates, edit history). Hidden by most modern tools, but not always stripped.

```bash
# Extract metadata from any file
exiftool document.pdf
exiftool photo.jpg      # may include GPS coordinates

# Strip metadata before publishing
exiftool -all= document.pdf    # removes all metadata
mat2 document.pdf              # alternative tool
```

---

## Google Dorking Cheat Sheet

Google's search operators let you target specific data on specific sites. Used aggressively in bug bounties and pen testing reconnaissance.

| Operator | Example | Finds |
|---|---|---|
| `site:` | `site:example.com` | Only results from that domain |
| `filetype:` | `filetype:pdf site:example.com` | Specific file types |
| `inurl:` | `inurl:admin` | URL contains "admin" |
| `intitle:` | `intitle:"index of"` | Page title contains phrase |
| `intext:` | `intext:"confidential"` | Page body contains phrase |
| `cache:` | `cache:example.com` | Google's cached copy |
| `-` | `site:example.com -www` | Exclude results |

**High-value dorks:**

```
# Exposed credentials
filetype:txt "password" site:example.com
filetype:env "DB_PASSWORD"
filetype:sql "INSERT INTO users"

# Open directory listings
intitle:"index of" site:example.com
intitle:"index of /" "parent directory"

# Login pages
inurl:admin OR inurl:login OR inurl:portal site:example.com
inurl:"/wp-admin" site:example.com

# Config files
filetype:xml "connectionString" site:example.com
filetype:conf site:example.com

# Exposed documents
filetype:xls OR filetype:xlsx "confidential" site:example.com
filetype:pdf "internal use only" site:example.com

# Webcams and devices
intitle:"webcam" inurl:view/index.shtml
```

**GHDB (Google Hacking Database):** exploit-db.com/google-hacking-database — thousands of documented dorks, categorized by type (files containing passwords, vulnerable servers, etc.).

---

## Key OSINT Tools

| Tool | Cost | Best For |
|---|---|---|
| **Maltego Community** | Free (limited transforms) | Visual relationship mapping — connect people, domains, IPs, emails |
| **theHarvester** | Free | Email/subdomain/employee enumeration from multiple sources |
| **Recon-ng** | Free | Modular framework, like Metasploit for OSINT |
| **SpiderFoot** | Free/paid | Automated OSINT aggregation — runs many sources at once |
| **OSINT Framework** | Free (directory) | Web directory of OSINT tools by category |
| **Shodan** | Free (limited) / paid | Internet-wide device/service scanning data |
| **crt.sh** | Free | Certificate transparency — subdomain discovery |
| **Wayback Machine** | Free | Historical website snapshots |
| **exiftool** | Free | File metadata extraction |
| **Maltego** | Free community / paid | Graph-based OSINT visualization |

### theHarvester Quick Reference
```bash
# Enumerate emails and subdomains for a domain
theHarvester -d example.com -b all

# Specific sources
theHarvester -d example.com -b google,linkedin,shodan

# Output to file
theHarvester -d example.com -b all -f results.html
```

---

## OSINT for Help Desk: Practical Applications

### Caller Identity Verification
Before resetting a password or granting access over the phone, a quick LinkedIn search can verify:
- Does this person actually work at this company?
- Does their claimed role match what they're asking for?
- Is their profile recently created with no history? (Red flag for social engineering)

### Understanding Your Own Attack Surface
Run OSINT on your own organization periodically:
- `crt.sh` search for your domain → unexpected subdomains?
- `site:yourcompany.com filetype:pdf` → documents you didn't mean to publish?
- `shodan.io` search for your IP ranges → open ports you didn't know about?
- WHOIS for all your domains → anything expiring soon?

### Social Engineering Defense
When a caller claims urgency ("I'm at the airport, locked out of my email for an important meeting"), that pressure is a technique. OSINT tells you what attackers already know — which makes you better at recognizing when someone's building a story from publicly available facts about your executives.

---

## Tags
`[[OSINT]]` `[[Social Engineering]]` `[[Phishing]]` `[[Reconnaissance]]` `[[Google Dorking]]` `[[Shodan]]` `[[DNS]]` `[[CySA+]]` `[[Penetration Testing]]`