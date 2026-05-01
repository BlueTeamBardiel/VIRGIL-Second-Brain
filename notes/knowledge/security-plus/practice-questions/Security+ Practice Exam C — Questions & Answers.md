---
exam: "C"
type: "multiple-choice"
question_count: 89
tags: [security-plus, sy0-701, practice-exam, exam-c]
---

# Security+ Practice Exam C — Questions & Answers

> **89 questions** | Organized by SY0-701 domain | Source: Professor Messer SY0-701 Practice Exams

# VIRGIL — Security+ SY0-701 Practice Exam C (Questions C1–C12)

---

### C1. Refer to the following firewall rules and categorize traffic flows as ALLOWED or BLOCKED

**Answer:** 
- ALLOWED: Use a secure terminal to connect to 10.1.10.88
- BLOCKED: Share the desktop on server 10.1.10.120
- ALLOWED: Perform a DNS query from 10.1.10.88 to 9.9.9.9
- ALLOWED: View web pages on 10.1.10.120
- BLOCKED: Authenticate to an LDAP server at 10.1.10.61
- ALLOWED: Synchronize the clock on a server at 10.1.10.17

**Domain:** 4.0 - Security Operations

**Explanation:** [[Firewall]] rules use implicit deny — only traffic explicitly matching a rule is allowed. SSH (TCP/22) to 10.1.10.88 matches Rule 1 (ALLOWED). RDP (TCP/3389) to 10.1.10.120 has no matching rule (BLOCKED). DNS (UDP/53) matches Rule 5 for any destination (ALLOWED). HTTP/HTTPS (TCP/80, 443) to 10.1.10.120 match Rules 2–3 (ALLOWED). [[LDAP]] (TCP/389) to 10.1.10.61 has no rule (BLOCKED). NTP (UDP/123) matches Rule 6 (ALLOWED).

---

### C2. Match the device to the description

**Answer:** 
- [[IPS]]: Block SQL injection over an Internet connection
- [[Proxy]]: Intercept all browser requests and cache the results
- [[Router]]: Forward packets between separate VLANs
- Load balancer: Configure a group of redundant web servers
- [[WAF]]: Evaluate the input to a browser-based application

**Domain:** 3.0 - Implementation

**Explanation:** [[IPS]] (Intrusion Prevention System) monitors and blocks exploit attempts including [[SQL Injection]]. [[Proxy]] intercepts, caches, and controls web traffic. [[Router]] forwards packets between subnets/VLANs using destination IP. Load balancers distribute traffic across redundant servers for fault tolerance. [[WAF]] (Web Application Firewall) validates input to prevent injection and [[XSS]] attacks.

---

### C3. Match the attack type to the characteristic

**Answer:**
- [[DDoS]]: A website stops responding to normal requests
- [[Replay]]: Data is captured and retransmitted to a server
- [[Rootkit]]: The malware is designed to remain hidden on a computer system
- Brute force: A list of passwords are attempted with a known username
- [[Phishing]]: An email link redirects a user to a site that requests login credentials
- [[Injection]]: Permissions are circumvented by adding additional code as application input

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** [[DDoS]] overwhelms capacity via distributed attackers. [[Replay]] captures and resends valid data. [[Rootkit]] modifies system files to hide malware. Brute force attempts password combinations systematically. [[Phishing]] uses social engineering and spoofed sites to steal credentials. [[Injection]] adds malicious code to application input to bypass security controls.

---

### C4. Match the cryptography technology to the description

**Answer:**
- Key stretching: Create a stronger key using multiple processes
- [[Steganography]]: Data is hidden within another media type
- [[Collision]]: Different inputs create the same hash
- Data masking: Sensitive data is hidden from view
- [[Asymmetric]]: A different key is used for decryption than encryption
- Salting: Information is added to make a unique hash

**Domain:** 1.0 - General Security Concepts

**Explanation:** Key stretching extends key size via multiple hashing steps. [[Steganography]] hides data in images or media. [[Collision]] occurs when two different inputs produce identical hashes (cryptographic failure). Data masking obscures sensitive info (e.g., credit cards with asterisks). [[Asymmetric]] encryption uses different public/private keys. Salting adds unique info to hashes, preventing rainbow table attacks.

---

### C5. Add the most applicable security technologies to the following scenarios

**Answer:**
- [[VPN]]: A field service engineer uses their corporate laptop at coffee shops and hotels
- [[Sandboxing]]: Software developers run a series of tests before deploying an application
- [[NGFW]]: An administrator prevents employees from visiting known-malicious web sites
- [[SD-WAN]]: Directly access cloud-based services from all corporate locations
- [[802.1X]]: Users connecting to the network should use their corporate authentication credentials

**Domain:** 3.0 - Implementation

**Explanation:** [[VPN]] encrypts all traffic on public Wi-Fi. [[Sandboxing]] isolates code testing safely. [[NGFW]] (Next-Generation Firewall) adds application-aware filtering and threat prevention. [[SD-WAN]] (Software-Defined WAN) optimizes cloud access across locations. [[802.1X]] enforces port-based network access control with centralized authentication.

---

### C6. A finance company is legally required to maintain seven years of tax records for all of their customers. Which of the following would be the BEST way to implement this requirement?

A) Automate a script to remove all tax information more than seven years old
B) Print and store all tax records in a seven-year cycle
C) Allow users to download tax records from their account login
D) Create a separate daily backup archive for all applicable tax records

**Answer: D**

**Domain:** 4.0 - Security Operations

**Explanation:** Daily backup archives ensure continuous [[Data Retention]] compliance and protection against accidental deletion. Regulatory mandates require retention capability, not destruction; automated deletion (A) risks non-compliance. Physical storage (B) is costly and impractical. User download access (C) doesn't ensure organizational compliance. Backups provide the best recovery assurance over the required timeframe.

---

### C7. A system administrator is designing a data center for an insurance company's new public cloud and would like to automatically rotate encryption keys on a regular basis. Which of the following would provide this functionality?

A) TPM
B) Key management system
C) Secure enclave
D) XDR

**Answer: B**

**Domain:** 1.0 - General Security Concepts

**Explanation:** A [[Key Management System]] (KMS) centralizes key lifecycle management: creation, rotation, association, and audit logging. [[TPM]] (Trusted Platform Module) provides device-level cryptography but lacks centralized rotation. Secure enclaves protect cryptographic operations on individual devices. [[XDR]] (Extended Detection and Response) is for threat detection, not key management.

---

### C8. A newly installed IPS is flagging a legitimate corporate application as malicious network traffic. Which of the following would be the BEST way to resolve this issue?

A) Disable the IPS signature
B) Block the application
C) Log all IPS events
D) Tune the IPS alerts

**Answer: D**

**Domain:** 4.0 - Security Operations

**Explanation:** Tuning [[IPS]] signatures/alerts adjusts detection thresholds to eliminate false positives while preserving attack detection. Disabling signatures (A) removes protection entirely. Blocking legitimate applications (B) disrupts operations. Logging alone (C) doesn't resolve the false positive. Tuning balances sensitivity and specificity.

---

### C9. A security administrator has identified an internally developed application which allows modification of SQL queries through the web-based front-end. Which of the following changes would resolve this vulnerability?

A) Store all credentials as salted hashes
B) Verify the application's digital signature
C) Validate all application input
D) Obfuscate the application's source code

**Answer: C**

**Domain:** 4.0 - Security Operations

**Explanation:** Input validation prevents [[SQL Injection]] by ensuring user input matches expected format/type before use in queries. Salted hashes (A) protect stored credentials but don't prevent injection. Digital signatures (B) verify code authenticity, not prevent injection attacks. Obfuscation (D) hides code but doesn't block malicious input. Input validation is the canonical defense against injection.

---

### C10. A system administrator is implementing a fingerprint scanner to provide access to the data center. Which of the following authentication technologies would be associated with this access?

A) Digital signature
B) Hard authentication token
C) Security key
D) Something you are

**Answer: D**

**Domain:** 4.0 - Security Operations

**Explanation:** "Something you are" is the biometric [[MFA]] factor — it relies on physical characteristics (fingerprints, facial recognition, iris scans) that uniquely identify individuals. Digital signatures (A) cryptographically sign data. Hard tokens (B) and security keys (C) are "something you have" factors. Biometrics are inherent, non-transferable authentication.

---

### C11. The IT department of a transportation company maintains an on-site inventory of chassis-based network switch interface cards. If a failure occurs, the on-site technician can replace the interface card and have the system running again in sixty minutes. Which of the following BEST describes this recovery metric?

A) MTBF
B) MTTR
C) RPO
D) RTO

**Answer: B**

**Domain:** 5.0 - Governance, Risk, and Compliance

**Explanation:** [[MTTR]] (Mean Time To Restore/Repair) measures the average time to restore functionality after failure — 60 minutes in this case. [[MTBF]] predicts time between failures. [[RPO]] (Recovery Point Objective) defines acceptable data loss. [[RTO]] (Recovery Time Objective) is the *target* time to recover; MTTR is the *actual* measured time.

---

### C12. A company maintains a server farm in a large data center. These servers are used internally and are not accessible from outside of the data center. The security team has discovered a group of servers was breached before the latest security patches were applied. Breach attempts were not logged on any other servers. Which of these threat actors would be MOST likely involved in this breach?

A) Organized crime
B) Insider
C) Nation state
D) Unskilled attacker

**Answer: B**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** Internal-only servers require physical/logical access to the data center — only an [[Insider]] threat possesses this access and knowledge of specific vulnerable systems pre-patch. Organized crime (A) lacks internal network access. Nation-state actors (C) would generate broader attack signatures. Unskilled attackers (D) cannot access internal networks or target specific unpatched systems. The precision and access pattern point directly to insider involvement.

---

**Study Notes:**
- **C1–C5:** Practical device/technology matching — focus on function (firewall rules, IPS, proxy caching, biometrics, etc.)
- **C6–C8:** Backup/retention, key management, IPS tuning — operational best practices
- **C9–C10:** Application security (input validation), authentication factors (biometric = "something you are")
- **C11–C12:** Recovery metrics ([[MTTR]] vs. [[RTO]]), threat actor attribution (insider access)

# VIRGIL Study Guide: Exam C Questions C13–C24

---

### C13. An organization has received a vulnerability scan report of their Internet-facing web servers showing multiple Sun Java Runtime Environment (JRE) vulnerabilities, but the server administrator has verified that JRE is not installed.

A) Install the latest version of JRE on the server
B) Quarantine the server and scan for malware
C) Harden the operating system of the web server
D) Ignore the JRE vulnerability alert

**Answer: D**

**Domain:** 4.0 - Security Operations

**Explanation:** This is a classic [[false positive]] — a vulnerability detection that does not represent an actual security issue. Since JRE is not installed, the vulnerability cannot exist. Installing unneeded software would increase attack surface. Once a false positive is properly researched and verified, it should be dismissed. There is no indication of malware or specific OS vulnerabilities requiring action.

---

### C14. A user downloaded and installed a utility for compressing and decompressing files, and immediately afterward the workstation's performance degraded significantly.

A) Ransomware
B) Bloatware
C) Logic bomb
D) Trojan

**Answer: D**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** A [[Trojan]] or Trojan horse is malicious software masquerading as legitimate software. The user installs it believing it will compress/decompress files, but it actually contains malware. [[Ransomware]] displays unlock messages; [[Logic bomb]]s trigger on specific events; [[Bloatware]] is pre-installed unnecessary applications. The performance degradation from hidden malicious activity is characteristic of a Trojan.

---

### C15. Which of the following is the process for replacing sensitive data with a non-sensitive and functional placeholder?

A) Steganography
B) Tokenization
C) Retention
D) Masking

**Answer: B**

**Domain:** 3.0 - Security Architecture

**Explanation:** [[Tokenization]] replaces sensitive data (e.g., credit card numbers) with tokens—functional placeholders that can be used in place of the original data while protecting the actual sensitive values. [[Steganography]] hides data within media; [[Masking]] hides data but renders it non-functional; [[Retention]] specifies storage duration, not data replacement.

---

### C16. A security administrator has installed a new firewall to protect a web server VLAN, and the application owner requires all web server sessions communicate over an encrypted channel.

A) Source: ANY, Destination: ANY, Protocol: TCP, Port: 23, Deny
B) Source: ANY, Destination: ANY, Protocol: TCP, Port: 22, Allow
C) Source: ANY, Destination: ANY, Protocol: TCP, Port: 80, Allow
D) Source: ANY, Destination: ANY, Protocol: TCP, Port: 443, Allow

**Answer: D**

**Domain:** 4.0 - Security Operations

**Explanation:** [[TLS]]/HTTPS uses TCP port 443 for encrypted web communication. Port 23 is insecure Telnet; port 22 is SSH (not for web browsers); port 80 is unencrypted HTTP. Only port 443 meets the requirement for encrypted web server sessions.

---

### C17. Which of these would be used to provide multi-factor authentication?

A) USB-connected storage drive with FDE
B) Employee policy manual
C) Just-in-time permissions
D) Smart card with picture ID

**Answer: D**

**Domain:** 4.0 - Security Operations

**Explanation:** A smart card with picture ID provides [[MFA]] by combining "something you have" (the card with embedded certificate) and "something you are" (picture ID). Often a PIN is required, adding a third factor ("something you know"). [[FDE]] encrypts data but doesn't authenticate; policy manuals are not authentication factors; [[Zero Trust|just-in-time permissions]] distribute temporary credentials but don't define authentication factors.

---

### C18. A company's network team has been asked to build an IPsec tunnel to a new business partner. Which of the following security risks would be the MOST important to consider?

A) Supply chain attack
B) Unsupported systems
C) Business email compromise
D) Typosquatting

**Answer: A**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** A direct IPsec connection to a third-party creates a trust relationship and potential attack vector. A [[Supply chain attack]] through a partner connection is a critical risk requiring [[Firewall]] monitoring and access controls. Business email compromise uses existing emails, not IPsec tunnels; typosquatting targets domain names, not direct tunnels; unsupported systems weren't mentioned as a concern here.

---

### C19. A company's human resources team maintains a list of all employees in a corporate savings plan, and a third-party financial company uses this information to manage stock investments. Which of the following would describe this financial company?

A) Processor
B) Owner
C) Controller
D) Custodian

**Answer: A**

**Domain:** 5.0 - Governance, Risk, and Compliance

**Explanation:** A data processor performs actions on data on behalf of another entity. The third-party financial company processes employee investment data. The HR team is the data controller (manages access/use); the company is the data owner (responsible for security); a custodian maintains data accuracy, privacy, and security but is not the processor in this scenario.

---

### C20. A technology company is manufacturing a military-grade radar tracking system designed to instantly identify and react to nearby unmanned aerial vehicles (UAVs) without delay.

A) RTOS
B) IoT
C) ICS
D) SDN

**Answer: A**

**Domain:** 3.0 - Security Architecture

**Explanation:** An [[RTOS]] (Real-Time Operating System) processes transactions and reacts instantly without delays or queuing—essential for military radar tracking. [[IoT]] devices focus on home automation without real-time requirements; [[ICS]] (Industrial Control Systems) manage manufacturing/power but don't inherently require RTOS; [[SDN]] (Software-Defined Networking) organizes network functions logically, unrelated to real-time processing.

---

### C21. An administrator is writing a script to convert an email message to a help desk ticket and assign the ticket to the correct department.

A) Role-based access controls
B) Federation
C) Due diligence
D) Orchestration

**Answer: D**

**Domain:** 4.0 - Security Operations

**Explanation:** [[Orchestration]] is process automation, especially automation across multiple systems. Converting emails to tickets and routing them is automated workflow coordination. [[RBAC]] controls permissions by role, not automation; [[Federation]] enables cross-system authentication; [[Due diligence]] involves third-party investigation, not internal scripting.

---

### C22. A security administrator would like a report showing how many attackers are attempting to use a known vulnerability to gain access to a corporate web server.

A) Application log
B) Metadata
C) IPS log
D) Windows log

**Answer: C**

**Domain:** 4.0 - Security Operations

**Explanation:** An [[IPS]] (Intrusion Prevention System) maintains a database of known vulnerabilities and logs malicious network traffic attempting to exploit them. This is the ideal source for attack attempt reporting. Application logs track internal functions; metadata is file/document information; Windows logs track OS events—none identify network-based vulnerability exploitation attempts.

---

### C23. During a ransomware outbreak, an organization was forced to rebuild database servers from known good backup systems. In which of the following incident response phases were these database servers brought back online?

A) Recovery
B) Lessons learned
C) Containment
D) Detection

**Answer: A**

**Domain:** 4.0 - Security Operations

**Explanation:** The [[Recovery]] phase follows containment and focuses on restoring systems to normal operation—rebuilding from backups, removing malware, fixing vulnerabilities. Detection identifies the incident; containment limits spread; lessons learned occurs post-incident. Rebuilding servers is a recovery activity.

---

### C24. A security administrator is installing a web server with a newly built operating system. Which of the following would be the best way to harden this OS?

A) Create a backup schedule
B) Install a device certificate
C) Remove unnecessary software
D) Disable power management features

**Answer: C**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** OS hardening reduces the attack surface and makes systems more resistant to attack. Removing unnecessary/unused software eliminates potential vulnerabilities and entry points. Backups support recovery but don't harden; device certificates verify ownership but don't strengthen security posture; power management settings have no security impact.

---

## Summary Table

| Question | Topic | Answer | Key Concept |
|----------|-------|--------|-------------|
| C13 | Vulnerability Scanning | D | False Positive Recognition |
| C14 | Malware Types | D | [[Trojan]] Horse |
| C15 | Data Protection | B | [[Tokenization]] |
| C16 | Firewall Rules | D | [[TLS]]/HTTPS Port 443 |
| C17 | [[MFA]] | D | Smart Card + ID |
| C18 | Third-Party Risk | A | [[Supply chain attack]] |
| C19 | Data Roles | A | Data Processor |
| C20 | OS Types | A | [[RTOS]] Real-Time |
| C21 | Automation | D | [[Orchestration]] |
| C22 | Logging | C | [[IPS]] Detection |
| C23 | Incident Response | A | Recovery Phase |
| C24 | OS Hardening | C | Reduce Attack Surface |

# VIRGIL's Formatted Question Bank — Exam C, Questions 26–37

---

### C26. An incident response team would like to validate their disaster recovery plans without making any changes to the infrastructure.

A) Tabletop exercise
B) Hot site fail-over
C) Simulation
D) Penetration test

**Answer: A**

**Domain:** 3.0 - Security Architecture

**Explanation:** A [[Tabletop Exercise]] is a walk-through discussion conducted in a conference room where disaster recovery processes are reviewed and validated without modifying any actual systems or infrastructure. This allows the team to identify gaps in planning safely. [[Hot site fail-over]] involves real system changes and operational impact. [[Simulation]] typically requires test changes to systems. [[Penetration test]]ing identifies vulnerabilities but does not evaluate disaster recovery processes.

---

### C27. A system administrator has installed a new firewall between the corporate user network and the data center network. When the firewall is turned on with the default settings, users complain the application in the data center is no longer working.

A) Create a single firewall rule with an explicit deny
B) Build a separate VLAN for the application
C) Create firewall rules that match the application traffic flow
D) Enable firewall threat blocking

**Answer: C**

**Domain:** 4.0 - Security Operations

**Explanation:** Most [[Firewall]]s use [[Implicit Deny]] as the default posture—all traffic is blocked unless explicitly permitted by a rule. To restore application functionality, administrators must create rules that match the specific traffic flows required by the application. An explicit deny rule (A) provides no additional control over the implicit deny already in place. [[VLAN]] separation (B) does not bypass firewall rules. Threat blocking (D) addresses malicious traffic detection, not legitimate application communication.

---

### C28. Which of these would be used to provide HA for a web-based database application?

A) SIEM
B) UPS
C) DLP
D) VPN concentrator

**Answer: B**

**Domain:** 3.0 - Security Architecture

**Explanation:** A [[UPS]] (Uninterruptible Power Supply) provides High Availability by ensuring continuous power delivery during outages, preventing data loss and service interruption. [[SIEM]] (Security Information and Event Management) is for log analysis and threat detection. [[DLP]] (Data Loss Prevention) prevents unauthorized data transfer. A [[VPN]] concentrator is a network endpoint device. None of the latter three provide HA functionality.

---

### C29. Each year, a certain number of laptops are lost or stolen and must be replaced by the company. Which of the following would describe the total cost the company spends each year on laptop replacements?

A) SLE
B) SLA
C) ALE
D) ARO

**Answer: C**

**Domain:** 5.0 - Governance, Risk, and Compliance

**Explanation:** [[ALE]] (Annual Loss Expectancy) calculates the total financial loss expected over one year and is the product of [[SLE]] (Single Loss Expectancy) × [[ARO]] (Annualized Rate of Occurrence). [[SLE]] measures loss from a single incident. [[SLA]] (Service Level Agreement) is a contractual commitment. [[ARO]] is the frequency of occurrence per year, not total cost.

---

### C30. A network administrator is viewing a log file from a web server showing a remote code execution exploit attempt in the URL parameters.

A) Static code analyzer
B) Input validation
C) Allow list
D) Secure cookies

**Answer: B**

**Domain:** 4.0 - Security Operations

**Explanation:** [[Input Validation]] creates strict filters on allowed data formats and values, preventing malicious code injection through URL parameters or form fields. A static code analyzer (A) reviews source code offline, not runtime attacks. An allow list (C) controls user access, not input content. [[Secure cookies]] (D) protect cookie data in transit but do not prevent code execution exploits.

---

### C31. Sam would like to send an email to Jack and have Jack verify that Sam was the sender of the email. Which of these should Sam use to provide this verification?

A) Digitally sign with Sam's private key
B) Digitally sign with Sam's public key
C) Digitally sign with Jack's private key
D) Digitally sign with Jack's public key

**Answer: A**

**Domain:** 1.0 - General Security Concepts

**Explanation:** The sender uses their own [[Private Key]] to create a [[Digital Signature]], ensuring authentication, integrity, and non-repudiation. The recipient verifies the signature using the sender's [[Public Key]]. Using a public key (B) provides no security since it is available to everyone. Jack's keys (C, D) are not accessible to Sam and would not prove Sam's identity.

---

### C32. The contract of a long-term temporary employee is ending. Which of these would be the MOST important part of the off-boarding process?

A) Perform an on-demand audit of the user's privileges
B) Archive the decryption keys associated with the user account
C) Document the user's outstanding tasks
D) Obtain a signed copy of the Acceptable Use Policies

**Answer: B**

**Domain:** 5.0 - Governance, Risk, and Compliance

**Explanation:** Archiving decryption keys prevents permanent data loss and ensures the organization retains access to the departing employee's encrypted files. Without these keys, the data becomes unrecoverable—the highest-priority outcome. Auditing privileges (A) is redundant when the account is disabled. Documenting tasks (C) is administrative but not critical. AUP signatures (D) are obtained at onboarding, not offboarding.

---

### C33. A cybersecurity analyst has been asked to respond to a denial of service attack against a web server, and the analyst has collected the log files and data from the server. Which of the following would allow a future analyst to verify the data as original and unaltered?

A) E-discovery
B) Root cause analysis
C) Legal hold
D) Data hashing

**Answer: D**

**Domain:** 4.0 - Security Operations

**Explanation:** [[Data Hashing]] creates a unique cryptographic digest of data; any modification produces a different hash, allowing verification of integrity and authenticity. This is critical in [[Digital Forensics]]. E-discovery (A) is a collection method without integrity guarantees. Root cause analysis (B) investigates causes but does not preserve data integrity. Legal hold (C) preserves data but does not verify authenticity.

---

### C34. A security administrator is reviewing authentication logs. The logs show a large number of accounts with at least three failed authentication attempts during the previous week.

A) Downgrade attack
B) Phishing
C) Injection
D) Spraying

**Answer: D**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** [[Password Spraying]] attempts a small number of guesses (e.g., 3 attempts) across many accounts to avoid triggering lockouts while maximizing the chance of finding weak passwords. A [[Downgrade Attack]] exploits cryptographic weaknesses, not brute force. [[Phishing]] harvests credentials rather than using brute force. [[Injection]] attacks insert malicious data, not perform credential attacks.

---

### C35. A security administrator has been asked to block all browsing to casino gaming websites. Which of the following would be the BEST way to implement this requirement?

A) Tune the IPS signatures
B) Block port tcp/443 on the firewall
C) Configure 802.1X for web browsing
D) Add a content filter rule

**Answer: D**

**Domain:** 4.0 - Security Operations

**Explanation:** A content filter (web filter) maintains a categorized database of websites and allows rule-based blocking by category (e.g., gambling, shopping). [[IPS]] signatures (A) detect exploits, not website categories. Blocking port 443 (B) disables all HTTPS traffic, not specific content. [[802.1X]] (C) is an authentication protocol unrelated to content filtering.

---

### C36. A company is experiencing downtime and outages when application patches and updates are deployed during the week. Which of the following would help to resolve these issues?

A) Onboarding considerations
B) Incident response policies
C) Change management procedures
D) Decentralized governance

**Answer: C**

**Domain:** 1.0 - General Security Concepts

**Explanation:** [[Change Management]] defines structured processes for implementing updates while minimizing downtime and business disruption. Best practices include testing, scheduling, rollback procedures, and stakeholder communication. Onboarding (A) addresses new employees. Incident response (B) handles security events, not planned updates. Decentralized governance (D) typically worsens coordination during changes.

---

### C37. A company is implementing a series of steps to follow when responding to a security event. Which of the following would provide this set of processes and procedures?

A) MDM
B) DLP
C) Playbook
D) Zero trust

**Answer: C**

**Domain:** 5.0 - Governance, Risk, and Compliance

**Explanation:** A [[Playbook]] is a documented set of conditional procedures and checklists for responding to specific security events (e.g., data breach, ransomware, intrusion). [[MDM]] (Mobile Device Management) manages device configuration. [[DLP]] (Data Loss Prevention) prevents data exfiltration. [[Zero Trust]] is a security philosophy, not an operational procedure set.

---

**End of Exam C Questions 26–37**

# VIRGIL's Formatted Q&A: Practice Exam C (C38–C49)

---

### C38. A transportation company maintains a scheduling application and a database in a virtualized cloud-based environment. Which of the following would be the BEST way to backup these services?

A) Journaling
B) Snapshot
C) RTOS
D) Containerization

**Answer: B**

**Domain:** 3.0 - Security Architecture

**Explanation:** [[Snapshot|Snapshots]] capture a full backup of a virtual machine plus incremental changes over time. They allow instant rollback to previous states, making them ideal for backing up VMs in cloud environments. [[Journaling]] protects file system integrity but isn't a backup mechanism. [[RTOS]] (Real-Time Operating System) is an OS type, not a backup tool. [[Containerization]] is an application deployment strategy, not a backup method.

---

### C39. In an environment using discretionary access controls, which of these would control the rights and permissions associated with a file or directory?

A) Administrator
B) Owner
C) Group
D) System

**Answer: B**

**Domain:** 4.0 - Identity and Access Management

**Explanation:** [[Discretionary Access Control|DAC]] model grants the **owner** of an object full control over its access permissions. The owner decides who can access the file and what type of access they receive. [[Mandatory Access Control|Administrators control labeling in MAC]], not DAC. Groups are used in [[Role-Based Access Control|RBAC]]. The system does not determine individual permissions in DAC.

---

### C40. A security administrator has installed a network-based DLP solution to determine if file transfers contain PII. Which of the following describes the data during the file transfer?

A) In-use
B) In-transit
C) Highly available
D) At-rest

**Answer: B**

**Domain:** 3.0 - Security Architecture

**Explanation:** Data **in-transit** describes information actively moving across the network through switches and routers. [[Data Loss Prevention|DLP]] solutions monitor data in-transit to prevent unauthorized transfer of [[PII|personally identifiable information]]. Data **in-use** resides in system memory. Data **at-rest** is stored on devices. **High availability** refers to redundancy and fault-tolerance, not data movement.

---

### C41. A medical imaging company would like to connect all remote locations together with high speed network links. The network connections must maintain high throughput rates and must always be available during working hours. In which of the following should these requirements be enforced with the network provider?

A) Service level agreement
B) Memorandum of understanding
C) Non-disclosure agreement
D) Acceptable use policy

**Answer: A**

**Domain:** 5.0 - Governance, Risk, and Compliance

**Explanation:** A [[Service Level Agreement|SLA]] is a contractual document that defines minimum terms for services, including throughput and uptime guarantees. An [[Memorandum of Understanding|MOU]] is informal and non-binding. A [[Non-Disclosure Agreement|NDA]] protects confidential information. An [[Acceptable Use Policy|AUP]] outlines employee behavior rules and does not establish service metrics.

---

### C42. A company is implementing a security awareness program for their user community. Which of the following should be included for additional user guidance and training?

A) Daily firewall exception reporting
B) Information on proper password management
C) Periodic vulnerability scanning of external services
D) Adjustments to annualized loss expectancy

**Answer: B**

**Domain:** 5.0 - Governance, Risk, and Compliance

**Explanation:** User awareness programs focus on practical security fundamentals that all employees can apply daily. Password management is a core security responsibility for every user. Daily firewall reports provide operational insight but not user guidance. Vulnerability scans validate security but don't train users. Adjusting annualized loss expectancy supports budgeting, not user training.

---

### C43. A security administrator is preparing a phishing email as part of a periodic employee security awareness campaign. The email is spoofed to appear as an unknown third-party and asks employees to immediately click a link or their state licensing will be revoked. Which of the following should be the expected response from the users?

A) Delete the message
B) Click the link and make a note of the URL
C) Forward the message to others in the department
D) Report the suspicious link to the help desk

**Answer: D**

**Domain:** 5.0 - Governance, Risk, and Compliance

**Explanation:** Users should be trained to **report suspicious content** to security/IT teams so the organization can block similar threats and investigate. Deleting avoids interaction but prevents organizational threat intelligence. Clicking unknown links is a best practice violation and invites compromise. Forwarding [[Phishing|phishing]] emails spreads the threat rather than containing it.

---

### C44. A security administrator would like to minimize the number of certificate status checks made by web site clients to the certificate authority. Which of the following would be the BEST option for this requirement?

A) OCSP stapling
B) Self-signed certificates
C) CRL
D) Wildcards

**Answer: A**

**Domain:** 1.0 - General Security Concepts

**Explanation:** [[OCSP Stapling|OCSP stapling]] embeds certificate status into the [[TLS]] handshake, eliminating the need for clients to contact the [[Certificate Authority|CA]] separately. This reduces CA queries and improves performance. A [[Certificate Revocation List|CRL]] requires direct CA access. Self-signed certificates don't change validation procedures. Wildcards enable multi-device use but don't reduce status checks.

---

### C45. A company is concerned their EDR solution will not be able to stop more advanced ransomware variants. Technicians have created a backup and restore utility to get most systems up and running less than an hour after an attack. What type of security control is associated with this restore process?

A) Directive
B) Compensating
C) Preventive
D) Detective

**Answer: B**

**Domain:** 1.0 - General Security Concepts

**Explanation:** A **compensating control** works around the limitations of a primary control by using alternative methods to achieve security objectives. The backup/restore utility compensates for the [[EDR|Endpoint Detection and Response]] tool's inability to prevent advanced [[Ransomware|ransomware]] by enabling rapid recovery. Directive controls define policies. Preventive controls block attacks. Detective controls identify ongoing attacks.

---

### C46. To upgrade an internal application, the development team provides the operations team with instructions for backing up, patching the application, and reverting the patch if needed. The operations team schedules a date for the upgrade, informs the business divisions, and tests the upgrade process after completion. Which of the following describes this process?

A) Code signing
B) Continuity planning
C) Usage auditing
D) Change management

**Answer: D**

**Domain:** 1.0 - General Security Concepts

**Explanation:** **Change management** is the formal process for planning, testing, scheduling, and communicating any modifications to the IT environment (software upgrades, patches, hardware changes). This process minimizes risk and ensures stakeholder awareness. [[Code Signing|Code signing]] verifies software integrity. [[Continuity Planning|Continuity planning]] maintains operations during disruptions. Usage auditing tracks resource consumption.

---

### C47. A company is implementing a public file-storage and cloud-based sharing service, and would like users to authenticate with an existing account on a trusted third-party web site. Which of the following should the company implement?

A) SSO
B) Federation
C) Least privilege
D) Discretionary access controls

**Answer: B**

**Domain:** 4.0 - Identity and Access Management

**Explanation:** [[Federation]] enables authentication and authorization between entities using a trusted third-party platform (e.g., logging into a service using an existing Facebook or Google account). [[Single Sign-On|SSO]] allows one login for multiple internal resources but doesn't require third-party authentication. [[Least Privilege]] limits user permissions. [[Discretionary Access Control|DAC]] controls file access by owners.

---

### C48. A system administrator is viewing this output from a file integrity monitoring report: [Repairing corrupted files in System32: kernel32.dll, netapi32.dll, user32.dll]. Which of the following malware types is the MOST likely cause of this output?

A) Ransomware
B) Logic bomb
C) Rootkit
D) Keylogger

**Answer: C**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** A [[Rootkit]] modifies core operating system files to achieve persistent, privileged access. The files listed (kernel, user, and networking libraries) are core OS components. [[Ransomware]] encrypts user data and displays warnings; it doesn't modify system DLLs. A [[Logic Bomb]] waits for a trigger event and doesn't target OS files. A [[Keylogger]] runs independently and doesn't embed in system files.

---

### C49. What type of vulnerability would be associated with this log information? `GET http://example.com/show.asp?view=../../Windows/system.ini HTTP/1.1`

A) Buffer overflow
B) Directory traversal
C) DoS
D) Cross-site scripting

**Answer: B**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** **Directory traversal** exploits improper input validation to access files outside the intended directory. The `../..` sequence moves up two parent directory levels to access `/Windows/system.ini`. A properly configured web server restricts such access. [[Buffer Overflow|Buffer overflow]] overflows memory boundaries. [[DoS]] denies service availability. [[XSS|Cross-site scripting]] injects scripts referencing untrusted third-party sites.

---

**End of Exam C Questions C38–C49**

# VIRGIL's Formatted Question Bank: C50–C61

---

### C50. A developer has created an application to store password information in a database. Which of the following BEST describes a way of protecting these credentials by adding random data to the password?

A) Hashing
B) Data masking
C) Salting
D) Asymmetric encryption

**Answer: C**

**Domain:** 3.0 - Security Architecture

**Explanation:** [[Salting]] is the process of adding random data to a password before [[hashing]] to protect stored credentials. This prevents [[Rainbow Table]] attacks and makes brute force attacks significantly harder because each password hash becomes unique, even if two users have identical passwords. Hashing alone (A) is a one-way function but doesn't add the randomization layer. Data masking (B) hides data visually (e.g., credit card display), not cryptographically. Asymmetric encryption (D) uses different keys for encryption/decryption but doesn't apply random data to hashes.

---

### C51. Which of the following processes provides ongoing building and testing of newly written code?

A) Continuous integration
B) Continuity of operations
C) Version control
D) Race condition

**Answer: A**

**Domain:** 4.0 - Security Operations

**Explanation:** [[Continuous Integration]] (CI) is a development practice where code is constantly written, tested, and merged into a central repository multiple times daily. This enables rapid feedback on code quality and security issues. Continuity of operations (B) applies to disaster/incident recovery. Version control (C) tracks file changes over time but doesn't describe the build-and-test cycle. A race condition (D) is a concurrency bug, not a development practice.

---

### C52. Which of the following BEST describes a responsibility matrix?

A) A visual summary of cloud provider accountability
B) Identification of tasks at each step of a project plan
C) A list of cybersecurity requirements based on the identified risks
D) Ongoing group discussions regarding cybersecurity

**Answer: A**

**Domain:** 3.0 - Security Architecture

**Explanation:** A responsibility matrix is a cloud-specific document that clearly defines which security controls and responsibilities belong to the cloud provider versus the customer. For example, the provider may own network infrastructure while the customer owns data security. This shared responsibility model prevents gaps and overlaps. Project task lists (B) are separate from responsibility matrices. Risk-based requirements (C) come from risk assessment, not responsibility matrices. Group discussions (D) inform risk assessment, not responsibility definitions.

---

### C53. A security administrator is implementing an authentication system for the company. Which of the following would be the best choice for validating login credentials for all usernames and passwords in the authentication system?

A) CA
B) SIEM
C) LDAP
D) WAF

**Answer: C**

**Domain:** 4.0 - Security Operations

**Explanation:** [[LDAP]] (Lightweight Directory Access Protocol) is the industry standard for centralized authentication and directory services across diverse operating systems and devices. It validates usernames and passwords against a directory store. A [[Certificate Authority]] (A) manages digital certificates, not credential validation. A [[SIEM]] (B) aggregates and correlates logs but doesn't authenticate users. A [[WAF]] (D) protects web applications from exploits but doesn't validate login credentials.

---

### C54. A technician is reviewing this information from an IPS log: MAIN_IPS: 22June2023 09:02:50 reject 10.1.111.7 Alert: HTTP Suspicious Webdav OPTIONS Method Request; Host: Server Severity: medium; Performance Impact:3; Category: info-leak; Packet capture; disable Proto:tcp; dst:192.168.11.1; src:10.1.111.7. Which of the following can be associated with this log information? (Select TWO)

A) The attacker sent a non-authenticated BGP packet to trigger the IPS
B) The source of the attack is 192.168.11.1
C) The event was logged but no packets were dropped
D) The source of the attack is 10.1.111.7
E) The attacker sent an unusual HTTP packet to trigger the IPS

**Answer: D, E**

**Domain:** 4.0 - Security Operations

**Explanation:** The "src" field in the final line clearly identifies the source as 10.1.111.7 (D). The alert message explicitly mentions "HTTP Suspicious Webdav OPTIONS Method Request," confirming an unusual HTTP packet triggered the detection (E). The destination is 192.168.11.1, not the source (B is incorrect). The first line shows "reject," meaning packets were dropped, not merely logged (C is incorrect). No BGP packets are mentioned anywhere in the log (A is incorrect).

---

### C55. A company has contracted with a third-party to provide penetration testing services. The service includes a port scan of each externally-facing device. This is an example of:

A) Initial exploitation
B) Privilege escalation
C) Known environment
D) Active reconnaissance

**Answer: D**

**Domain:** 5.0 - Governance, Risk, and Compliance

**Explanation:** [[Active Reconnaissance]] involves sending visible network traffic (like port scans) that can be logged and detected by security tools like [[IPS]]. This is distinct from passive reconnaissance, which gathers information without triggering alerts. Exploitation (A) attempts to compromise vulnerabilities, but scanning alone does not exploit anything. Privilege escalation (B) requires prior system access, which a port scan doesn't provide. A known environment (C) refers to penetration tests conducted with full documentation and knowledge of the target, but the question doesn't confirm this.

---

### C56. An access point in a corporate headquarters office has the following configuration: IP address: 10.1.10.1, Subnet mask: 255.255.255.0, DHCPv4 Server: Enabled, SSID: Wireless, Wireless Mode: 802.11n, Security Mode: WEP-PSK, Frequency band: 2.4 GHz, Software revision: 2.1, MAC Address: 60:3D:26:71:FF:AA, IPv4 Firewall: Enabled. Which of the following would apply to this configuration?

A) Invalid frequency band
B) Weak encryption
C) Incorrect IP address and subnet mask
D) Invalid software version

**Answer: B**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** [[WEP]] (Wired Equivalent Privacy) is an outdated and cryptographically broken encryption standard that should be replaced with [[WPA2]] or [[WPA3]]. This is a critical weakness in the configuration. The 2.4 GHz band (A) is valid for 802.11n. The IP address 10.1.10.1 with subnet mask 255.255.255.0 (C) is properly configured. Software revision 2.1 (D) does not inherently indicate invalidity without knowing the current recommended version.

---

### C57. An attacker has gained access to an application through the use of packet captures. Which of the following would be MOST likely used by the attacker?

A) Overflow
B) Forgery
C) Replay
D) Injection

**Answer: C**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** A [[Replay Attack]] uses previously captured network packets (credentials, tokens, or session data) to gain unauthorized access by retransmitting them. Packet captures are the primary tool for this attack. Buffer overflow (A) targets memory corruption, not packet data. [[CSRF/Forgery]] (B) exploits trust relationships and doesn't require packet captures. [[SQL Injection]] or [[XSS]] (D) involves crafting malicious input, not replaying captured packets.

---

### C58. A company is receiving complaints of slowness and disconnections to their Internet-facing web server. A network administrator monitors the Internet link and finds excessive bandwidth utilization from thousands of different IP addresses. Which of the following would be the MOST likely reason for these performance issues?

A) DDoS
B) DNS spoofing
C) RFID cloning
D) Wireless jamming

**Answer: A**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** A [[DDoS]] (Distributed Denial of Service) attack overwhelms a service by flooding it with requests from many different IP addresses, exhausting bandwidth and causing slowness or outages. This matches the symptoms exactly. [[DNS Spoofing]] (B) redirects users to fake sites but doesn't cause bandwidth exhaustion. [[RFID Cloning]] (C) duplicates RFID tags and is unrelated to web server traffic. Wireless jamming (D) disrupts wireless networks, not Internet-facing web services.

---

### C59. A company has created an itemized list of tasks to be completed by a third-party service provider. After the services are complete, this document will be used to validate the completion of the services. Which of the following would describe this agreement type?

A) SLA
B) SOW
C) NDA
D) BPA

**Answer: B**

**Domain:** 5.0 - Governance, Risk, and Compliance

**Explanation:** A [[SOW]] (Statement of Work) is a detailed, itemized list of deliverables, tasks, scope, and completion criteria. It serves as both a contract and a checklist for validating service completion. An [[SLA]] (A) specifies performance levels (uptime, response times) but not detailed task lists. An [[NDA]] (C) protects confidential information, not service deliverables. A [[BPA]] (D) governs business partnerships but doesn't itemize specific services.

---

### C60. A company is deploying a series of internal applications to different cloud providers. Which of the following connection types should be deployed for this configuration?

A) Air-gapped
B) 802.1X
C) Site-to-site IPsec VPN
D) Jump server
E) SD-WAN

**Answer: E**

**Domain:** 3.0 - Security Architecture

**Explanation:** [[SD-WAN]] (Software-Defined Wide Area Network) is designed to efficiently route traffic from users to cloud-based applications across multiple cloud providers, providing flexibility and scalability. Air-gapping (A) isolates networks entirely—the opposite of what's needed. 802.1X (B) is a port-based access control mechanism for initial network access, not cloud routing. Site-to-site IPsec VPN (C) doesn't scale well as applications move between providers. Jump servers (D) provide remote admin access but don't route user traffic to cloud apps.

---

### C61. A company is updating components within the control plane of their zero-trust implementation. Which of the following would be part of this update?

A) Policy engine
B) Subjects
C) Policy enforcement point
D) Zone configurations

**Answer: A**

**Domain:** 1.0 - General Security Concepts

**Explanation:** In a [[Zero Trust]] architecture, the **control plane** contains the [[Policy Engine]], which evaluates access decisions based on security policies and context (device posture, location, identity, etc.). Subjects (B) are users, devices, or applications that exist in the data plane. The [[Policy Enforcement Point]] (C) resides in the data plane and enforces decisions made by the policy engine. Zone configurations (D) operate in the data plane to segment trust boundaries.

---

**End of C50–C61**

# VIRGIL's Study Guide: CompTIA Security+ SY0-701
## Practice Exam C Questions C62–C73

---

### C62. Which of the following malware types would cause a workstation to participate in a DDoS?

A) Bot
B) Logic bomb
C) Ransomware
D) Keylogger

**Answer: A**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** A [[Bot|bot]] is malware that installs on a system and waits for remote instructions. Botnets consisting of thousands of compromised bots are commonly used to launch [[DDoS]] (Distributed Denial of Service) attacks. Logic bombs wait for predefined events and affect limited systems. [[Ransomware]] locks systems and prevents normal operation, not participation in DDoS. Keyloggers silently capture keystrokes for transmission to third parties, not DDoS participation.

---

### C63. Which of these are used to force the preservation of data for later use in court?

A) Chain of custody
B) Data loss prevention
C) Legal hold
D) E-discovery

**Answer: C**

**Domain:** 4.0 - Security Operations

**Explanation:** A **legal hold** is a legal technique requiring preservation of relevant information to ensure data remains accessible for litigation preparation. [[Chain of custody]] documents evidence integrity and handler access. [[DLP|Data loss prevention]] identifies and blocks transmission of sensitive data like PII but doesn't preserve data for legal purposes. E-discovery identifies and collects electronic documents but does not force preservation itself.

---

### C64. A company would like to automatically monitor and report on any movement occurring in an open field at the data center. Which of the following would be the BEST choice for this task?

A) Bollard
B) Microwave sensor
C) Access control vestibule
D) Fencing

**Answer: B**

**Domain:** 1.0 - General Security Concepts

**Explanation:** **Microwave sensors** detect movement across large open areas and can automatically alert security personnel. Bollards are barricades that prevent vehicle access but don't detect movement. Access control vestibules manage foot traffic flow into facilities. Fencing creates a perimeter barrier but provides no detection or alerting capability.

---

### C65. A company is releasing a new product, and part of the release includes the installation of load balancers to the public web site. Which of the following would best describe this process?

A) Platform diversity
B) Capacity planning
C) Multi-cloud systems
D) Permission restrictions

**Answer: B**

**Domain:** 3.0 - Implementation

**Explanation:** **Capacity planning** matches resource supply to demand. Adding load balancers increases web server capacity to handle anticipated increased product interest. Platform diversity uses different platforms for similar services. Multi-cloud systems use multiple cloud providers (not mentioned here). Permission restrictions limit access to data/resources, unrelated to server capacity expansion.

---

### C66. A system administrator would like to prove an email message was sent by a specific person. Which of the following describes the verification of this message source?

A) Non-repudiation
B) Key escrow
C) Asymmetric encryption
D) Steganography

**Answer: A**

**Domain:** 1.0 - General Security Concepts

**Explanation:** **Non-repudiation** verifies the source of data or messages using [[digital signatures]], proving who sent a message and preventing denial of sending. Key escrow involves third-party key management without providing source verification. [[Asymmetric encryption]] provides confidentiality but not proof of origin. [[Steganography]] hides data within other media without verifying message source.

---

### C67. A security administrator has created a policy to alert if a user modifies the hosts file on their system. Which of the following behaviors does this policy address?

A) Unexpected
B) Self-assessment
C) Unintentional
D) Risky

**Answer: D**

**Domain:** 5.0 - Governance, Risk, and Compliance

**Explanation:** Modifying the hosts file is categorized as **risky behavior** because it can redirect traffic to malicious sites or bypass security controls—a legitimate security concern. File editing is intentional, not unexpected or unintentional. Self-assessment refers to internal audit processes, not user file modifications.

---

### C68. A company has identified a web server data breach resulting in the theft of financial records from 150 million customers. A security update to the company's web server software was available for two months prior to the breach. Which of the following would have prevented this breach from occurring?

A) Patch management
B) Full disk encryption
C) Disabling unnecessary services
D) Application allow lists

**Answer: A**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** **Patch management** would have identified the unpatched vulnerability and provided opportunity to apply the available security update before attackers exploited it two months later. [[Full disk encryption]] protects against unauthorized storage access but doesn't prevent application vulnerabilities. Disabling unnecessary services doesn't protect critical web services. [[Application allow lists]] prevent unauthorized applications but don't protect against web service exploits.

---

### C69. During the onboarding process, the IT department requires a list of software applications associated with the new employee's job functions. Which of the following would describe the use of this information?

A) Access control configuration
B) Encryption settings
C) Physical security requirements
D) Change management

**Answer: A**

**Domain:** 5.0 - Governance, Risk, and Compliance

**Explanation:** The application list enables **access control configuration** by identifying what application and data access the new employee requires. Job-related applications don't determine encryption settings, physical security requirements, or trigger formal change management processes.

---

### C70. A system administrator has identified an unexpected username on a database server, and the user has been transferring database files to an external server over the company's Internet connection. The administrator then performed these tasks: • Physically disconnected the Ethernet cable on the database server • Disabled the unknown account • Configured a firewall rule to prevent file transfers from the server. Which of the following would BEST describe this part of the incident response process?

A) Eradication
B) Containment
C) Lessons learned
D) Preparation

**Answer: B**

**Domain:** 4.0 - Security Operations

**Explanation:** **Containment** isolates and stops rapidly spreading threats. Disconnecting the network cable, disabling the account, and blocking file transfers all isolate the compromised server and prevent further data theft. Eradication removes the compromise and restores systems. Lessons learned occurs post-incident. Preparation happens before incidents occur.

---

### C71. Which of the following would be the MOST effective use of asymmetric encryption?

A) Real-time video encryption
B) Securely store passwords
C) Protect data on mobile devices
D) Create a shared session key

**Answer: D**

**Domain:** 1.0 - General Security Concepts

**Explanation:** **Creating a shared session key** is the most effective asymmetric use case. The [[Diffie-Hellman]] algorithm combines public and private keys to derive identical session keys without transmitting the key across the network. Real-time video requires faster symmetric encryption. Password storage uses [[hashing]], not encryption. Mobile devices use efficient [[ECC|elliptic curve cryptography]] instead of slower asymmetric encryption.

---

### C72. Each salesperson in a company receives a laptop with applications and data to support their sales efforts. The IT manager would like to prevent third-parties from gaining access to this information if the laptop is stolen. Which of the following would be the BEST way to protect this data?

A) Remote wipe
B) Full disk encryption
C) Biometrics
D) VPN

**Answer: B**

**Domain:** 1.0 - General Security Concepts

**Explanation:** **Full disk encryption** stores all data on the laptop's drive as encrypted, preventing thieves without decryption credentials from reading it. Remote wipe is reactive and erases data after theft. [[Biometrics]] protect OS access but the drive can be removed and accessed from another computer. [[VPN]] encrypts network traffic but not stored data on the device.

---

### C73. A security administrator has compiled a list of all information stored and managed by an organization. Which of the following would best describe this list?

A) Sanitization
B) Metadata
C) Known environment
D) Data inventory

**Answer: D**

**Domain:** 5.0 - Governance, Risk, and Compliance

**Explanation:** A **data inventory** comprehensively lists all organizational data, including ownership, update frequency, and format. Data sanitization completely removes data for disposal/reuse. [[Metadata]] describes characteristics of other data (headers, file properties). A known environment provides testing scope details for penetration tests.

---

**END OF C62–C73**
*Study these domains: 1.0 (General Security Concepts), 2.0 (Threats, Vulnerabilities, and Mitigations), 3.0 (Implementation), 4.0 (Security Operations), and 5.0 (Governance, Risk, and Compliance)*

# VIRGIL: Your CompTIA Security+ (SY0-701) Study Guide
## Practice Exam C — Questions C74–C85

---

### C74. A security administrator would like to monitor all outbound Internet connections for malicious software.

A) Jump server
B) IPsec tunnel
C) Forward proxy
D) Load balancer

**Answer: C**

**Domain:** 3.0 - Network Security

**Explanation:** A [[Forward Proxy]] intercepts and inspects outbound traffic, making it the ideal tool for monitoring all outbound Internet connections and detecting [[Malware]]. It can filter content, block malicious domains, and identify suspicious software. A [[Jump Server]] provides administrative access, not network monitoring. An [[IPsec]] tunnel encrypts traffic but doesn't inspect it for threats. A [[Load Balancer]] distributes traffic across servers for performance, not security monitoring.

---

### C75. What type of security control would be associated with corporate security policies?

A) Technical
B) Operational
C) Managerial
D) Physical

**Answer: C**

**Domain:** 1.0 - Security Concepts

**Explanation:** [[Managerial Controls]] are governance-level controls that establish security policies, standards, and procedures. Security policies and standard operating procedures are foundational examples. [[Technical Controls]] use systems like firewalls and antivirus. [[Operational Controls]] are implemented by people (security guards, training). [[Physical Controls]] restrict physical access (doors, badge readers).

---

### C76. Which of the following would be the MOST significant security concern when protecting against organized crime?

A) Prevent users from posting passwords near their workstations
B) Require identification cards for all employees and guests
C) Maintain reliable backup data
D) Use access control vestibules at all data center locations

**Answer: C**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** Organized crime typically targets data for encryption or deletion ([[Ransomware]]). Reliable backups enable recovery without paying extortion fees, making this the most critical defense. Organized crime operates remotely, not on-site, so password posting, identification cards, and physical vestibules are far less relevant. [[Threat Intelligence]] on organized crime shows data theft and encryption as primary objectives.

---

### C77. An application team has been provided with a hardened version of Linux to use with a new application installation. Which of the following would BEST protect the application from attacks?

A) Build a backup server for the application
B) Run the application in a cloud-based environment
C) Implement a secure configuration of the web service
D) Send application logs to the SIEM via syslog

**Answer: C**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** [[Hardening]] the web service configuration—through account restrictions, file permissions, and service settings—directly prevents attacks at the source. This is a proactive defensive measure. Backups assist recovery but don't prevent attacks. Cloud deployment doesn't inherently reduce attack surface. [[SIEM]] log aggregation enables detection and response but doesn't prevent initial compromise.

---

### C78. A system administrator has configured MAC filtering on their corporate access point, but access logs show unauthorized users accessing the network.

A) Enable WPA3 encryption
B) Remove unauthorized MAC addresses from the filter
C) Modify the SSID name
D) Modify the channel frequencies

**Answer: A**

**Domain:** 4.0 - Security Operations

**Explanation:** [[MAC Address]] filtering alone is insufficient because MAC addresses can be easily spoofed; attackers capture legitimate addresses and impersonate them. [[WPA3]] with pre-shared keys or 802.1X authentication provides actual cryptographic authentication, preventing spoofed access. Removing MAC addresses worsens the problem. The [[SSID]] name and channel frequencies are not security features.

---

### C79. An application upgrade has been delayed due to a different scheduled installation of an outdated device driver. Which of the following issues would best describe this change management delay?

A) Deny list
B) Legacy application
C) Dependency
D) Restricted activity

**Answer: C**

**Domain:** 1.0 - Security Concepts

**Explanation:** A [[Dependency]] exists when one change must occur before another can proceed. The application upgrade depends on the device driver update. A deny list blocks execution. A legacy application is unsupported software. Restricted activity refers to scope limitations in change control, not sequential ordering of changes.

---

### C80. A supplicant communicates to an authenticator, which then sends an authentication request to an Active Directory database.

A) Federation
B) UTM
C) 802.1X
D) PKI

**Answer: C**

**Domain:** 3.0 - Network Security

**Explanation:** [[802.1X]] is the IEEE standard for port-based network access control ([[NAC]]). The terminology precisely matches: supplicant (client), authenticator (switch/access point), and authentication server ([[Active Directory]]). The supplicant must authenticate before gaining network access. [[Federation]] allows cross-organization authentication. [[UTM]] is an all-in-one security appliance. [[PKI]] is public-key infrastructure without NAC components.

---

### C81. A security researcher has been notified of a potential hardware vulnerability. Which of the following should the researcher evaluate as a potential security issue?

A) Firmware versions
B) Firewall configuration
C) SQL requests
D) XSS attachments

**Answer: A**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** [[Firmware]] is the software embedded in hardware devices and acts as the hardware's operating system. Hardware vulnerabilities are typically resolved through firmware updates. Firewall configuration is a software network control. [[SQL Injection]] and [[XSS]] are application/software vulnerabilities, not hardware-level issues.

---

### C82. Visitors to a corporate data center must enter through the main doors of the building. Which of the following security controls would BEST guide people to the front door?

A) Infrared sensors
B) Bollards
C) Biometrics
D) Fencing
E) Access badges
F) Video surveillance

**Answer: B, D**

**Domain:** 1.0 - Security Concepts

**Explanation:** [[Bollards]] (short posts) and [[Fencing]] are physical security controls that physically direct people by blocking unauthorized paths and funneling them toward the main entrance. Infrared sensors detect heat but don't guide people. Biometrics authenticate identity but don't direct traffic. Access badges control access but don't guide routing. Video surveillance monitors but doesn't direct movement.

---

### C83. Employees are required to authenticate each time a file share, printer, or SAN imaging system is accessed. Which of the following should minimize the number of authentication requests?

A) SSO
B) OSINT
C) MFA
D) SCAP

**Answer: A**

**Domain:** 4.0 - Security Operations

**Explanation:** [[Single Sign-On (SSO)]] authenticates a user once and grants access to multiple resources without requiring additional logins. This directly solves the problem of repeated authentications. [[OSINT]] (Open Source Intelligence) is threat reconnaissance. [[MFA]] strengthens a single authentication but doesn't reduce the number of authentications required. [[SCAP]] is a security content automation protocol unrelated to authentication reduction.

---

### C84. A company moved accounting systems with integration across organizational divisions. Which of the following ensures correct access for proper employees in each division?

A) Geolocation
B) Onboarding process
C) Account de-provisioning
D) Internal self-assessment

**Answer: D**

**Domain:** 5.0 - Identity and Access Management

**Explanation:** An internal self-assessment with audit verifies that users have correct permissions aligned with [[Least Privilege]] principles across divisions after a major system migration. Geolocation assigns permissions by location (not mentioned here). Onboarding is for new hires. De-provisioning disables departing employees' accounts—neither addresses the post-migration access verification needed.

---

### C85. An attacker has circumvented a web-based application to send commands directly to a database.

A) Downgrade
B) SQL injection
C) Cross-site scripting
D) On-path

**Answer: B**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** [[SQL Injection]] exploits poorly validated user input in web applications to bypass application logic and execute arbitrary [[SQL]] commands directly against the database. A downgrade attack forces weak cryptography. [[XSS]] executes scripts in browsers, not databases. An [[On-path]] attack intercepts data flows but doesn't directly access databases via SQL.

---

**Study Complete: C74–C85** ✓

# VIRGIL: CompTIA Security+ SY0-701 Practice Exam C (Questions C86–C90)

---

### C86. A group of business partners is using blockchain technology to monitor and track raw materials and parts as they are transferred between companies.

A) Ledger
B) HSM
C) SIEM
D) HIPS

**Answer: A**

**Domain:** 1.0 - General Security Concepts

**Explanation:** The [[Ledger]] in blockchain is a distributed, immutable record of all transactions shared among network participants. It's the core component where tracking details are stored and visible to all authorized parties. **HSM** ([[Hardware Security Module]]) handles cryptographic key storage, not transaction tracking. **SIEM** ([[Security Information and Event Management]]) consolidates security logs, not blockchain data. **HIPS** ([[Host-based Intrusion Prevention System]]) detects exploit attempts on individual devices, unrelated to blockchain monitoring.

---

### C87. A network technician at a bank noticed a significant decrease in traffic to the bank's public website and found users directed to a similar-looking site not under the bank's control.

A) DDoS
B) Disassociation attack
C) Buffer overflow
D) Domain hijacking

**Answer: D**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** [[Domain hijacking]] occurs when an attacker modifies primary [[DNS]] (Domain Name System) settings, redirecting users to attacker-controlled IP addresses. Flushing the local DNS cache and changing entries proves ineffective because the authoritative DNS records themselves have been compromised. **DDoS** (Distributed Denial of Service) blocks access entirely rather than redirecting to a fake site. **Disassociation attack** targets wireless networks, removing devices from connectivity. **Buffer overflow** is an application-level memory exploit unrelated to domain redirection.

---

### C88. A security administrator must prevent all communication between two separate applications in a data center.

A) Firewall
B) SDN
C) Air gap
D) VLANs

**Answer: C**

**Domain:** 3.0 - Security Architecture and Design

**Explanation:** An **air gap** provides complete physical separation between networks, making it the most absolute guarantee that zero communication can occur. It eliminates any risk of misconfiguration. A [[Firewall]] can be misconfigured and potentially allow unintended traffic. **SDN** ([[Software Defined Networking]]) is a network architecture model, not a segmentation security control. **VLANs** ([[Virtual Local Area Network]]) offer logical segmentation but remain on the same physical infrastructure and can be compromised or misconfigured, making them less secure than physical air-gapping.

---

### C89. A receptionist received an email from the CEO's address requesting an employee directory, but the domain and sender were not corporate.

A) Recognizing social engineering
B) Proper password management
C) Securing remote work environments
D) Understanding insider threats

**Answer: A**

**Domain:** 5.0 - Security Program Management and Oversight

**Explanation:** This is a textbook [[Phishing]]/[[Social Engineering]] attack—impersonating an authority figure (CEO) to trick the recipient into revealing sensitive information. Training in **social engineering recognition** teaches employees to identify red flags: mismatched email domains, unusual requests, and sender verification. **Password management** training addresses credential protection, not attack recognition. **Remote work security** focuses on environment controls, not identifying impersonation attacks. **Insider threat** training assumes the attacker is an employee with existing access; here, the attacker is external and impersonating leadership.

---

### C90. Which deployment model applies when a company allows employees to use their personal phones for work?

A) CYOD
B) MDM
C) BYOD
D) COPE

**Answer: C**

**Domain:** 4.0 - Security Architecture and Design

**Explanation:** **BYOD** (Bring Your Own Device) is the deployment model where employees own personal mobile devices and use them for both personal and work purposes. **CYOD** (Choose Your Own Device) requires the company to purchase devices; employees select the model. **MDM** ([[Mobile Device Management]]) is a *management tool* used across multiple deployment models, not a deployment model itself. **COPE** (Corporately Owned, Personally Enabled) means the company owns and controls the device, allowing optional personal use—the opposite of BYOD.

---

**Study Status:** Questions C86–C90 complete. Reinforce [[Blockchain]], [[DNS Attacks]], [[Network Segmentation]], [[Social Engineering]], and [[Mobile Device Deployment Models]].

---
_Ingested: 2026-04-16 20:44 | Source: professor-messer-sy0-701-comptia-security-plus-practice-exams-v18.pdf_