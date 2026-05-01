---
exam: "B"
type: "multiple-choice"
question_count: 89
tags: [security-plus, sy0-701, practice-exam, exam-b]
---

# Security+ Practice Exam B — Questions & Answers

> **89 questions** | Organized by SY0-701 domain | Source: Professor Messer SY0-701 Practice Exams

# VIRGIL's Formatted Study Guide – Exam B Questions (B1–B13)

---

### B1. Match the certificate characteristic to the description

A) CRL — Certificate Revocation List - A list of invalidated certificates
B) OCSP — Online Certificate Status Protocol - The browser checks for a revoked certificate
C) CA — Certificate Authority - Deploy and manage certificates
D) CSR — Certificate Signing Request - Send the public key to be signed

**Answer: All match as stated**

**Domain:** 1.0 - Security Fundamentals (Objective 1.4 - Certificates)

**Explanation:** Each [[PKI]] component serves a distinct function in certificate lifecycle management:
- **[[CRL]]** is a revocation list maintained by the CA containing invalidated certificates
- **[[OCSP]]** is a protocol allowing browsers to verify certificate revocation status in real-time
- **[[CA]]** is the trusted entity that issues, manages, and revokes digital certificates
- **CSR** is the initial request containing a public key sent to the CA for signing and issuance

---

### B2. Select the best security features for each platform

A) Tablet for Field Sales: MDM integration, Full Device Encryption, Biometric authentication
B) Desktop with Browser-based Front-end: Host-based Firewall, Anti-Malware

**Answer: Tablet = MDM integration + Full Device Encryption + Biometric authentication; Desktop = Host-based Firewall + Anti-Malware**

**Domain:** 4.0 - Security Operations (Objectives 4.6 - [[MFA]], 4.1 - Wireless and Mobile Security)

**Explanation:** Mobile devices require different controls than stationary desktops:
- **Tablets** need [[MDM]] for device management, encryption for sensitive data protection at rest, and [[biometric authentication]] (face/fingerprint) as a second authentication factor
- **Desktops** benefit from host-based [[firewall]] and anti-malware software to monitor local and incoming traffic
- OSINT and infrared sensors are not applicable to these scenarios

---

### B3. Place the incident response activities in the correct order

A) Preparation
B) Detection
C) Analysis
D) Containment
E) Eradication
F) Recovery
G) Lessons learned

**Answer: Preparation → Detection → Analysis → Containment → Eradication → Recovery → Lessons learned**

**Domain:** 4.0 - Security Operations (Objective 4.8 - Incident Response)

**Explanation:** The [[Incident Response]] lifecycle follows a sequential process:
1. **Preparation** — tools, policies, and processes established before incidents occur
2. **Detection** — identifying active threats and filtering false positives
3. **Analysis** — gathering detailed evidence from alarms, alerts, and logs
4. **Containment** — preventing malicious code spread
5. **Eradication** — removing malware and patching vulnerabilities
6. **Recovery** — rebuilding systems and restoring data
7. **Lessons learned** — post-incident review to improve future response

---

### B4. Match the security technology to the implementation

A) Hashing → Store a password on an authentication server
B) Digital signature → Verify a sender's identity
C) SPF → Authenticate the server sending an email
D) Key escrow → Store keys with a third-party
E) Journaling → Prevent data corruption when a system fails
F) Obfuscation → Modify a script to make it difficult to understand

**Answer: All match as stated**

**Domain:** 1.0 - Security Fundamentals (Objective 1.4 - Encrypting Data)

**Explanation:**
- **[[Hashing]]** is one-way cryptography ideal for secure password storage
- **Digital signatures** use hashing + asymmetric encryption for integrity and non-repudiation
- **[[SPF]]** (Sender Policy Framework) authorizes email servers via DNS records
- **Key escrow** stores encryption keys with trusted third-parties for recovery purposes
- **Journaling** writes data to temporary storage before committing to prevent corruption
- **[[Obfuscation]]** obscures code to make reverse-engineering difficult

---

### B5. Select the data state that best fits the description

A) Data in-transit — All switches connected with 802.1Q trunk; Sales info uploaded via satellite; IPS identifies SQL injection attack frames
B) Data at-rest — Customer purchase info in MySQL database; Weekly backup tapes at offsite facility; User spreadsheets on cloud-based file service
C) Data in-use — Application decrypts credit card numbers; Authentication program hashes passwords; ATM validates PIN; Spreadsheet cells auto-update

**Answer: In-transit (network movement); At-rest (stored/dormant); In-use (processing in memory)**

**Domain:** 3.0 - Security Architecture (Objective 3.3 - States of Data)

**Explanation:** The three data states define security requirements:
- **Data in-transit** moves across network segments (802.1Q trunks, satellite uploads, [[IPS]] inspection)
- **Data at-rest** resides in storage (databases, backup tapes, cloud file services)
- **Data in-use** exists in active memory during processing (decryption, hashing, validation, formula calculation)

---

### B6. A security administrator has performed an audit of the organization's production web servers identifying default configurations, web services running from a privileged account, and inconsistencies with SSL certificates. Which would BEST resolve these issues?

A) Server hardening
B) Multi-factor authentication
C) Enable HTTPS
D) Run operating system updates

**Answer: A**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations (Objective 2.5 - Hardening Techniques)

**Explanation:** **[[Server hardening]]** directly addresses all identified issues:
- Removing default configurations per vendor secure configuration guides
- Restricting service privileges to least-privilege accounts
- Correcting SSL/TLS certificate inconsistencies

Why others fail:
- **[[MFA]]** adds authentication strength but doesn't fix configuration flaws
- **HTTPS/[[TLS]]** encrypts transport but doesn't resolve misconfigured certificates or privileged service accounts
- **OS updates** patch vulnerabilities but don't address configuration issues identified in the audit

---

### B7. A shipping company maintains an IPS at each warehouse to watch for suspicious traffic patterns. Which would BEST describe the security control used?

A) Deterrent
B) Compensating
C) Directive
D) Detective

**Answer: D**

**Domain:** 1.0 - Security Fundamentals (Objective 1.1 - Security Controls)

**Explanation:** An [[IPS]] (Intrusion Prevention System) is a **detective control** because it:
- Detects suspicious traffic patterns in real-time
- Alerts and logs intrusion attempts
- Can also function as **preventive** by actively blocking known attacks

Why others fail:
- **Deterrent** discourages attacks (warning signs, splash screens) without preventing access
- **Compensating** provides alternatives when attacks occur (re-imaging compromised servers)
- **Directive** offers guidelines for compliance (user training, policies)

---

### B8. The Vice President of Sales has asked the IT team to create daily backups of the sales data. The Vice President is an example of a:

A) Data owner
B) Data controller
C) Data steward
D) Data processor

**Answer: A**

**Domain:** 5.0 - Governance, Risk, and Compliance (Objective 5.1 - Data Roles and Responsibilities)

**Explanation:** A **data owner** is accountable for specific data and typically holds a senior position in the organization. The VP of Sales requesting backups demonstrates ownership authority.

Why others fail:
- **Data controller** manages data processing workflows (payroll departments)
- **Data steward** manages access rights (IT team in this example)
- **Data processor** processes data on behalf of the controller, often third-party

---

### B9. A security engineer is preparing to conduct a penetration test by reading social media posts for information about a third-party website. Which describes this practice?

A) Partially known environment
B) OSINT
C) Exfiltration
D) Active reconnaissance

**Answer: B**

**Domain:** 4.0 - Security Operations (Objective 4.3 - Threat Intelligence)

**Explanation:** **[[OSINT]]** (Open Source Intelligence) is the systematic collection of information from publicly available sources including:
- Social media posts
- Corporate websites
- Online forums
- Public databases

Why others fail:
- **Partially known environment** describes the tester's awareness level, not the information-gathering method
- **Exfiltration** is unauthorized data theft by attackers
- **Active reconnaissance** leaves detectable traces (ping scans, DNS queries); reading public posts is passive

---

### B10. A company would like to orchestrate the response when a virus is detected on company devices. Which would BEST implement this function?

A) Active reconnaissance
B) Log aggregation
C) Vulnerability scan
D) Escalation scripting

**Answer: D**

**Domain:** 4.0 - Security Operations (Objective 4.7 - Scripting and Automation)

**Explanation:** **Escalation scripting** automates and orchestrates immediate response actions when security events are detected, such as:
- Isolating infected devices
- Triggering alert notifications
- Initiating remediation workflows

Why others fail:
- **Active reconnaissance** gathers system information only; no response capability
- **Log aggregation** centralizes evidence for analysis but doesn't trigger automated response
- **Vulnerability scan** identifies weaknesses; doesn't detect active infections or execute response actions

---

### B11. A user in the accounting department received a text message from the CEO requesting payment by cryptocurrency for a tablet. Which describes this attack?

A) Brand impersonation
B) Watering hole attack
C) Smishing
D) Typosquatting

**Answer: C**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations (Objective 2.1 - [[Phishing]])

**Explanation:** **[[Smishing]]** is [[phishing]] conducted via SMS/text messaging. This attack impersonates authority (CEO) and requests unusual payment (cryptocurrency) through a mobile text.

Why others fail:
- **Brand impersonation** pretends to represent well-known companies; this targets an internal executive
- **Watering hole attack** requires victims to visit compromised websites; text-only does not
- **Typosquatting** uses misspelled domain names for redirection; not applicable to text messages

---

### B12. A company has been informed of a hypervisor vulnerability allowing users on one virtual machine to access resources on another virtual machine. Which describes this vulnerability?

A) Containerization
B) Jailbreaking
C) SDN
D) Escape

**Answer: D**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations (Objective 2.3 - Virtualization Vulnerabilities)

**Explanation:** A **VM escape** vulnerability allows processes to break out of a virtual machine and access the hypervisor or other VMs, enabling inter-VM resource access.

Why others fail:
- **Containerization** is a deployment architecture for self-contained application environments, not a vulnerability
- **Jailbreaking** removes firmware restrictions on mobile devices to enable non-approved features
- **[[SDN]]** (Software-Defined Networking) separates control and data planes for network automation; unrelated to hypervisor VM boundaries

---

### B13. While working from home, users are directed to a different website than expected when typing a web conference link. Office users have no issues. Which is the MOST likely reason?

A) Buffer overflow
B) Wireless disassociation
C) Amplified DDoS
D) DNS poisoning

**Answer: D**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations (Objective 2.4 - [[DNS]] Attacks)

**Explanation:** **[[DNS poisoning]]** redirects users to malicious sites by compromising [[DNS]] server configurations. Remote users likely use different DNS resolvers than office DNS, explaining why office users are unaffected.

Why others fail:
- **Buffer overflow** causes application crashes/errors, not website redirects
- **Wireless disassociation** (deauthentication) causes repeated disconnects, not transparent redirects
- **Amplified [[DDoS]]** causes service unavailability; the conference site remains accessible per the scenario

---

**End of Exam B Study Guide (B1–B13)**

# VIRGIL's CompTIA Security+ SY0-701 Study Guide
## Practice Exam B – Questions B14–B25

---

### B14. A company is launching a new internal application that will not start until a username and password is entered and a smart card is plugged into the computer. Which of the following BEST describes this process?

A) Federation
B) Accounting
C) Authentication
D) Authorization

**Answer: C**

**Domain:** 1.0 - Security and Risk Management

**Explanation:** [[Authentication]] is the process of proving your identity. The username/password and smart card represent two [[MFA|factors of authentication]] that verify the user is who they claim to be. Federation involves trust between organizations (incorrect). Accounting logs session activity like login time and data transferred (incorrect). Authorization assigns users to resources after authentication is complete (incorrect).

---

### B15. An online retailer is planning a penetration test as part of their PCI DSS validation. A third-party organization will be performing the test, and the online retailer has provided the Internet-facing IP addresses for their public web servers. No other details were provided. What penetration testing methodology is the online retailer using?

A) Known environment
B) Passive reconnaissance
C) Partially known environment
D) Benchmarks

**Answer: C**

**Domain:** 5.0 - Security Program Management and Operations

**Explanation:** A **partially known environment** test occurs when the tester has some information (the IP addresses) but not complete details about systems and infrastructure. A known environment provides full details (incorrect). [[Passive reconnaissance]] gathers information from public sources like social media (incorrect). Benchmarks are security best practices, not testing methodologies (incorrect).

---

### B16. A manufacturing company produces radar used by commercial and military organizations. A recently proposed policy change would allow the use of mobile devices inside the facility. Which of the following would be the MOST significant threat vector issue associated with this change in policy?

A) Unauthorized software on rooted devices
B) Remote access clients on the mobile devices
C) Out of date mobile operating systems
D) Loss of intellectual property

**Answer: D**

**Domain:** 2.0 - Architecture, Design, and Planning

**Explanation:** **Loss of intellectual property** via photos, videos, or file exfiltration is the most significant threat when mobile devices enter a facility with sensitive products. Mobile devices make data exfiltration trivially easy. Rooted/jailbroken devices pose security risks but are less critical than active IP theft (incorrect). Remote access clients and outdated OSes are concerns but do not pose the same level of immediate threat as easy data exfiltration (incorrect).

---

### B17. Which of the following would be the BEST way for an organization to verify the digital signature provided by an external email server?

A) Perform a vulnerability scan
B) View the server's device certificate
C) Authenticate to a RADIUS server
D) Check the DKIM record

**Answer: D**

**Domain:** 4.0 - Security Operations

**Explanation:** [[DKIM]] (Domain Keys Identified Mail) records are DNS entries containing the public key used to verify a mail server's digital signatures. Legitimate servers publish their public keys in DNS for third-party validation. Vulnerability scans don't verify email signatures (incorrect). Device certificates validate system trust but not email signatures (incorrect). [[RADIUS]] servers verify credentials, not digital signatures (incorrect).

---

### B18. A company is using older operating systems for their web servers and are concerned of their stability during periods of high use. Which of the following should the company use to maximize the uptime and availability of this service?

A) Cold site
B) UPS
C) Redundant routers
D) Load balancer

**Answer: D**

**Domain:** 3.0 - Implementation

**Explanation:** A **load balancer** distributes traffic across multiple servers. If one server fails, others continue operating, maximizing uptime and availability. Cold sites require infrastructure setup before use—inefficient for server resiliency (incorrect). A [[UPS]] (Uninterruptible Power Supply) handles power failures but not OS crashes (incorrect). Redundant routers improve network redundancy but won't prevent server OS failures (incorrect).

---

### B19. A user in the accounting department would like to email a spreadsheet with sensitive information to a list of third-party vendors. Which of the following would be the BEST way to protect the data in this email?

A) Full disk encryption
B) Key exchange algorithm
C) Salted hash
D) Asymmetric encryption

**Answer: D**

**Domain:** 1.0 - Security and Risk Management

**Explanation:** [[Asymmetric encryption]] uses the recipient's public key to encrypt data; only their private key can decrypt it. This method (via PGP/GPG) is ideal for email security. Full disk encryption protects stored data but not email in transit (incorrect). Key exchange algorithms facilitate secure key sharing but don't encrypt data (incorrect). [[Salted hash|Salted hashes]] provide randomization for password storage, not data confidentiality (incorrect).

---

### B20. A system administrator would like to segment the network to give the marketing, accounting, and manufacturing departments their own private network. The network communication between departments would be restricted for additional security. Which of the following should be configured on this network?

A) VPN
B) RBAC
C) VLAN
D) SDN

**Answer: C**

**Domain:** 2.0 - Architecture, Design, and Planning

**Explanation:** A [[VLAN]] (Virtual Local Area Network) logically segments a network at Layer 2. Devices in each VLAN communicate only with others in the same VLAN; routers between VLANs enforce traffic restrictions. A [[VPN]] secures remote connections, not internal network segmentation (incorrect). [[RBAC]] (Role-Based Access Control) manages OS permissions, not network segmentation (incorrect). [[SDN]] (Software Defined Networking) separates control and data planes but isn't used for basic internal segmentation (incorrect).

---

### B21. A technician at an MSP has been asked to manage devices on third-party private network. The technician needs command line access to internal routers, switches, and firewalls. Which of the following would provide the necessary access?

A) HSM
B) Jump server
C) NAC
D) Air gap

**Answer: B**

**Domain:** 3.0 - Implementation

**Explanation:** A **jump server** (also called a bastion host) is a hardened device used to securely access protected networks. The technician first connects to the jump server via SSH or [[VPN]], then "jumps" to internal devices. This is standard for MSP access to customer networks. An [[HSM]] (Hardware Security Module) manages cryptographic keys, not remote access (incorrect). [[NAC]] (Network Access Control) enforces device health checks, not remote CLI access (incorrect). An air gap is physical network isolation, not a remote access mechanism (incorrect).

---

### B22. A transportation company is installing new wireless access points in their corporate office. The manufacturer estimates the access points will operate an average of 100,000 hours before a hardware-related outage. Which of the following describes this estimate?

A) MTTR
B) RPO
C) RTO
D) MTBF

**Answer: D**

**Domain:** 5.0 - Security Program Management and Operations

**Explanation:** [[MTBF]] (Mean Time Between Failures) is the average operational time expected before a hardware failure. It's calculated from component lifespans and reliability data. [[MTTR]] (Mean Time to Repair) measures time to fix a device after failure (incorrect). [[RPO]] (Recovery Point Objective) defines acceptable data loss during recovery (incorrect). [[RTO]] (Recovery Time Objective) defines minimum time to restore service (incorrect).

---

### B23. A security administrator is creating a policy to prevent the disclosure of credit card numbers in a customer support application. Users of the application would only be able to view the last four digits of a credit card number. Which of the following would provide this functionality?

A) Hashing
B) Tokenization
C) Masking
D) Salting

**Answer: C**

**Domain:** 3.0 - Implementation

**Explanation:** **Data masking** hides sensitive data from view while the full data remains in the database. Users see only the last four digits. [[Hashing]] creates digital fingerprints; masked data shows actual card digits, not hashes (incorrect). [[Tokenization]] replaces sensitive data with a non-sensitive token, but masked data is a partial view of the real number (incorrect). [[Salting]] adds randomization to hashes for password storage, not data masking (incorrect).

---

### B24. A user is authenticating through the use of a PIN and a fingerprint. Which of the following would describe these authentication factors?

A) Something you know, something you are
B) Something you are, somewhere you are
C) Something you have, something you know
D) Somewhere you are, something you are

**Answer: A**

**Domain:** 4.0 - Security Operations

**Explanation:** A **PIN** (Personal Identification Number) is **something you know** (memorized). A **fingerprint** is **something you are** (biometric/inherent). These represent two different [[MFA|multi-factor authentication]] categories. "Somewhere you are" refers to location/GPS coordinates (incorrect). "Something you have" refers to physical tokens or apps (incorrect).

---

### B25. A security administrator is configuring the authentication process used by technicians when logging into wireless access points and switches. Instead of using local accounts, the administrator would like to pass all login requests to a centralized database. Which of the following would be the BEST way to implement this requirement?

A) COPE
B) AAA
C) IPsec
D) SIEM

**Answer: B**

**Domain:** 4.0 - Security Operations

**Explanation:** [[AAA]] (Authentication, Authorization, and Accounting) centralizes credential management in a database (typically via [[RADIUS]] or [[LDAP]]) rather than storing accounts locally on each device. Users authenticate once against the central database. [[COPE]] (Corporate-owned, personally enabled) describes device ownership models, not authentication (incorrect). [[IPsec]] provides encrypted tunnels for data protection, not authentication centralization (incorrect). [[SIEM]] (Security Information and Event Management) provides centralized logging and alerting, not authentication (incorrect).

---

**End of Exam B Chunk 2 (B14–B25)**

# VIRGIL's Security+ Study Guide: Exam B Questions B26–B37

---

### B26. A recent audit has determined that many IT department accounts have been granted Administrator access. The audit recommends replacing these permissions with limited access rights. Which of the following would describe this policy?

A) Password vaulting
B) Offboarding
C) Least privilege
D) Discretionary access control

**Answer: C**

**Domain:** 4.0 - Access Control and Identity Management

**Explanation:** [[Least Privilege]] is the foundational security principle of granting users only the minimum permissions necessary to perform their job functions. By reducing IT administrator accounts from full Administrator access to limited rights, the organization reduces the attack surface and blast radius if an account is compromised. This directly limits what an attacker can do if they gain control of that account.

Wrong answers: A) [[Password Vaulting]] securely stores credentials but doesn't enforce access restrictions. B) [[Offboarding]] is the process of removing access when employees leave. D) [[Discretionary Access Control (DAC)]] lets resource owners set permissions but doesn't define a "least privilege" policy structure.

---

### B27. A recent security audit has discovered usernames and passwords which can be easily viewed in a packet capture. Which of the following did the audit identify?

A) Weak encryption
B) Improper patch management
C) Insecure protocols
D) Open ports

**Answer: C**

**Domain:** 4.0 - Security Operations (Protocols)

**Explanation:** [[Insecure Protocols]] transmit authentication credentials and sensitive data "in the clear" (unencrypted) over the network. Protocols like Telnet, HTTP, FTP, and SMTP send credentials in plaintext, making them trivial to capture and view in packet analysis tools like Wireshark.

Wrong answers: A) Weak encryption implies some encryption exists but is broken; here there's no encryption at all. B) Patch management doesn't address protocol-level plaintext transmission. D) Open ports describe whether services are listening, not whether they encrypt data.

---

### B28. Before deploying a new application, a company is performing an internal audit to ensure all of their servers are configured with the appropriate security features. Which of the following would BEST describe this process?

A) Due care
B) Active reconnaissance
C) Data retention
D) Statement of work

**Answer: A**

**Domain:** 5.0 - Governance, Risk and Compliance

**Explanation:** [[Due Care]] refers to the organization's duty to act honestly, responsibly, and in good faith regarding internal security activities. Performing internal audits to verify security configurations is a core example of due care—proactively ensuring systems meet security standards before deployment. This is contrasted with [[Due Diligence]], which typically applies to third-party vendor assessment.

Wrong answers: B) [[Active Reconnaissance]] is pre-attack information gathering. C) [[Data Retention]] involves archiving data over time. D) [[Statement of Work (SOW)]] is a contract document for third-party services, not internal audits.

---

### B29. An organization has previously purchased insurance to cover a ransomware attack, but the costs of maintaining the policy have increased above the acceptable budget. The company has now decided to cancel the insurance policies and address potential ransomware issues internally. Which of the following would best describe this action?

A) Mitigation
B) Acceptance
C) Transference
D) Risk-avoidance

**Answer: B**

**Domain:** 5.0 - Risk Management

**Explanation:** [[Risk Acceptance]] is a deliberate business decision to assume responsibility for a risk rather than eliminate, reduce, or transfer it. By canceling the insurance and deciding to handle [[Ransomware]] incidents internally, the organization is accepting the financial and operational risk of a potential attack.

Wrong answers: A) [[Mitigation]] would mean implementing backups, air-gapped storage, and detection tools to reduce impact. C) [[Risk Transference]] means shifting the risk to a third party (what they did *before* canceling insurance). D) [[Risk Avoidance]] would require disconnecting from the Internet entirely, which is impractical.

---

### B30. Which of these threat actors would be MOST likely to install a company's internal application on a public cloud provider?

A) Organized crime
B) Nation state
C) Shadow IT
D) Hacktivist

**Answer: C**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** [[Shadow IT]] refers to unauthorized IT infrastructure or applications deployed by internal business departments outside the official IT department, often circumventing IT policies and controls. These groups might deploy company applications to public cloud providers to bypass governance, reduce costs, or accelerate projects—directly contradicting IT security policies.

Wrong answers: A) [[Organized Crime]] seeks financial gain through data theft, not application deployment. B) [[Nation State]] actors target classified government information and critical infrastructure. D) [[Hacktivist|Hacktivists]] make political statements and would publicize breaches, not quietly deploy apps.

---

### B31. An IPS report shows a series of exploit attempts were made against externally facing web servers. The system administrator of the web servers has identified a number of unusual log entries on each system. Which of the following would be the NEXT step in the incident response process?

A) Check the IPS logs for any other potential attacks
B) Create a plan for removing malware from the web servers
C) Disable any breached user accounts
D) Disconnect the web servers from the network

**Answer: D**

**Domain:** 4.0 - Security Operations (Incident Response)

**Explanation:** [[Incident Response]] follows a structured process: Preparation → **Containment** → Investigation → Eradication → Recovery → Lessons Learned. The unusual log entries suggest successful exploitation. The next critical step is **containment**—isolating the compromised systems by disconnecting them from the network to prevent lateral movement, further exfiltration, or continued command-and-control communication.

Wrong answers: A) Investigating other attacks happens *after* containment. B) [[Eradication]] (removing malware) occurs after containment and investigation. C) Account disabling is part of recovery, which comes later.

---

### B32. A security administrator is viewing the logs on a laptop in the shipping and receiving department and identifies these events: 8:55:30 AM | D:\Downloads\ChangeLog-5.0.4.scr | Quarantine Success; 9:22:54 AM | C:\Program Files\Photo Viewer\ViewerBase.dll | Quarantine Failure; 9:44:05 AM | C:\Sales\Sample32.dat | Quarantine Success. Which of the following would BEST describe the circumstances surrounding these events?

A) The antivirus application identified three viruses and quarantined two viruses
B) The host-based firewall blocked two traffic flows
C) A host-based allow list has blocked two applications from executing
D) A network-based IPS has identified two known vulnerabilities

**Answer: A**

**Domain:** 4.0 - Security Operations (Log Data)

**Explanation:** The log entries show file paths and "Quarantine" dispositions, which is characteristic of [[Antivirus]] software behavior. Quarantine means the malicious files were moved to an isolated storage area, preventing execution while preserving them for analysis. Two files were successfully quarantined; the second failed likely because ViewerBase.dll was in use by the operating system and couldn't be moved.

Wrong answers: B) [[Host-based Firewall]] logs show IP/port allow/deny decisions, not file quarantine. C) [[Allow List]] (whitelisting) stops execution; it doesn't move files to quarantine locations. D) [[IPS]] logs are network-based and show vulnerability signatures, not local file quarantine operations.

---

### B33. In the past, an organization has relied on the curated Apple App Store to avoid issues associated with malware and insecure applications. However, the IT department has discovered an iPhone in the shipping department with applications not available on the Apple App Store. How did the shipping department user install these apps on their mobile device?

A) Side loading
B) Malicious update
C) VM escape
D) Cross-site scripting

**Answer: A**

**Domain:** 2.0 - Mobile Device Vulnerabilities

**Explanation:** [[Side Loading]] is the installation of applications from sources other than an official app store. On iOS, this typically requires [[Jailbreaking]] to circumvent Apple's code signing and sandboxing restrictions. Once jailbroken, users can manually install apps without App Store curation, introducing malware and security risks.

Wrong answers: B) Malicious updates patch existing apps; they don't install new ones. C) [[VM Escape]] is unauthorized access between virtual machines on a hypervisor—unrelated to mobile app installation. D) [[Cross-Site Scripting (XSS)]] is a web browser attack; it doesn't install native apps on phones.

---

### B34. A company has noticed an increase in support calls from attackers. These attackers are using social engineering to gain unauthorized access to customer data. Which of the following would be the BEST way to prevent these attacks?

A) User training
B) Next-generation firewall
C) Internal audit
D) Penetration testing

**Answer: A**

**Domain:** 5.0 - Security Awareness and Compliance

**Explanation:** [[Social Engineering]] attacks often succeed through human manipulation—phone calls, pretexting, baiting, etc.—rather than technical exploits. [[User Training]] teaches employees to recognize and resist these tactics. Technology alone cannot stop a well-crafted social engineering call, so user awareness is the primary defense.

Wrong answers: B) [[Next-Generation Firewall (NGFW)]] protects against network and application attacks but cannot monitor phone calls or in-person interactions. C) Internal audits document problems but don't prevent attacks. D) [[Penetration Testing]] identifies vulnerabilities but doesn't actively block attacks.

---

### B35. As part of an internal audit, each department of a company has been asked to compile a list of all devices, operating systems, and applications in use. Which of the following would BEST describe this audit?

A) Attestation
B) Self-assessment
C) Regulatory compliance
D) Vendor monitoring

**Answer: B**

**Domain:** 5.0 - Governance, Risk and Compliance (Audits and Assessments)

**Explanation:** [[Self-Assessment]] is an organization evaluating its own security posture through internal review and testing. Asking departments to inventory their systems is a classic self-assessment activity—the organization is independently gathering data to understand its security environment without external auditors.

Wrong answers: A) [[Attestation]] is a formal statement or certification of compliance—typically the *final step* of an audit, not the inventory phase. C) [[Regulatory Compliance]] involves meeting external legal/regulatory requirements (PCI-DSS, HIPAA, etc.); the scenario doesn't mention regulations. D) [[Vendor Monitoring]] applies to third-party suppliers, not internal departments.

---

### B36. A company is concerned about security issues at their remote sites. Which of the following would provide the IT team with more information of potential shortcomings?

A) Gap analysis
B) Policy administrator
C) Change management
D) Dependency list

**Answer: A**

**Domain:** 1.0 - Security Fundamentals (Risk Assessment)

**Explanation:** [[Gap Analysis]] is a formal assessment comparing current security state against a desired target state. It identifies discrepancies (gaps) across people, processes, technology, and compliance—making it ideal for discovering security shortcomings at remote sites without comprehensive IT oversight.

Wrong answers: B) [[Policy Administrator]] is a [[Zero Trust]] component that generates access tokens, not a security assessment tool. C) [[Change Management]] controls deployment; it doesn't identify security gaps. D) [[Dependency List]] tracks technical dependencies for change planning, not security posture assessment.

---

### B37. An attacker has identified a number of devices on a corporate network with the username of "admin" and the password of "admin." Which of the following describes this situation?

A) Open service ports
B) Default credentials
C) Unsupported systems
D) Phishing

**Answer: B**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations (Common Threat Vectors)

**Explanation:** [[Default Credentials]] are the pre-configured usernames and passwords (often "admin"/"admin" or "admin"/"password") provided by manufacturers for initial device setup. When organizations fail to change these credentials during deployment or configuration, attackers with knowledge of the defaults can gain unauthorized access immediately—a critical vulnerability.

Wrong answers: A) [[Open Service Ports]] describe listening network services; they don't explain how credentials were discovered. C) [[Unsupported Systems]] are devices no longer patched by vendors; they may use defaults but aren't the core issue here. D) [[Phishing]] is social engineering to extract credentials; default credentials are public knowledge, not information obtained via phishing.

---

**Study Tips:**
- **Least Privilege** and **Default Credentials** are perennial Security+ topics—master both.
- **Incident Response** sequence: Containment first, investigation second, eradication/recovery last.
- **Risk Management** has four strategies: Mitigation, Transference, Acceptance, Avoidance.
- **Social Engineering** defeats technology—user training is the primary defense.
- **Self-Assessment** vs. **Attestation**: Self-assessment is the process; attestation is the formal opinion at the end.

# VIRGIL's Formatted Question Bank: Exam B, Questions B38–B49

---

### B38. A security administrator attends an annual industry convention with other security professionals from around the world. Which of the following attacks would be MOST likely in this situation?

A) Smishing
B) Supply chain
C) SQL injection
D) Watering hole

**Answer: D**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** A [[watering hole]] attack infects a third-party website or resource frequented by intended victims. An industry convention where security professionals gather represents an ideal attack vector—the attacker can compromise the convention's network or a commonly-visited resource to target multiple high-value targets in one location. [[Smishing]] is SMS-based phishing (impractical at a physical event), [[Supply chain]] attacks target manufacturing pipelines (not applicable), and [[SQL Injection]] targets databases directly rather than individuals at events.

---

### B39. A transportation company headquarters is located in an area with frequent power surges and outages. The security administrator is concerned about the potential for downtime and hardware failures. Which of the following would provide the most protection against these issues? Select TWO.

A) UPS
B) Parallel processing
C) Snapshots
D) Multi-cloud system
E) Load balancing
F) Generator

**Answer: A, F**

**Domain:** 3.0 - Security Architecture

**Explanation:** A [[UPS]] (Uninterruptible Power Supply) provides immediate backup power for a limited duration when the main power source fails, keeping systems operational during the transition. A [[Generator]] maintains uptime indefinitely as long as fuel is available, providing sustained power during extended outages. **Parallel processing** improves performance but offers no protection against power loss. **Snapshots** are VM backups useful for configuration recovery, not power resilience. **Multi-cloud systems** don't address local data center power issues. **Load balancing** distributes traffic but doesn't protect against power failures.

---

### B40. An organization has developed an in-house mobile device app for order processing. The developers would like the app to identify revoked server certificates without sending any traffic over the corporate Internet connection. Which of the following must be configured to allow this functionality?

A) CSR generation
B) OCSP stapling
C) Key escrow
D) Wildcard

**Answer: B**

**Domain:** 1.0 - General Security Concepts

**Explanation:** [[OCSP]] (Online Certificate Status Protocol) stapling allows the certificate holder to validate and store certificate revocation status internally, then "staple" this status information into the [[TLS]] handshake. This eliminates the need for clients to contact the external [[Certificate Authority|CA]] over the Internet for real-time revocation checks. A **CSR** (Certificate Signing Request) is used during initial certificate creation, not revocation checks. **Key escrow** provides third-party access to decryption keys (unrelated to revocation). A **Wildcard** certificate applies across multiple subdomains but doesn't address revocation validation.

---

### B41. A security administrator has been asked to build a network link to secure all communication between two remote locations. Which of the following would be the best choice for this task?

A) SCAP
B) Screened subnet
C) IPsec
D) Network access control

**Answer: C**

**Domain:** 3.0 - Security Architecture

**Explanation:** [[IPsec]] (Internet Protocol Security) is the standard protocol for creating encrypted [[VPN]] tunnels between remote sites or devices, securing all traffic traversing the link. [[SCAP]] (Security Content Automation Protocol) is a framework for security tool integration and vulnerability reporting, not for creating encrypted links. A **screened subnet** (DMZ) is a network architecture pattern for hosting public services, not for inter-site encryption. **Network access control** ([[NAC]]) handles device authentication and authorization at network entry, not inter-site tunneling.

---

### B42. A Linux administrator has received a ticket complaining of response issues with a database server. After connecting to the server, the administrator views this information: Filesystem Size Used Avail Use% Mounted on /dev/xvda1 158G 158G 0 100% / Which of the following would BEST describe this information?

A) Buffer overflow
B) Resource consumption
C) SQL injection
D) Race condition

**Answer: B**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** The filesystem output shows zero available space (Avail: 0, Use%: 100%), a classic indicator of **resource consumption**—the storage resource has been exhausted. This directly causes performance degradation because the system cannot write logs, temporary files, or database data. A **buffer overflow** is a memory corruption vulnerability unrelated to disk space. [[SQL Injection]] is a network-based database attack, not a storage utilization issue. A **race condition** is a concurrent programming flaw, not a storage depletion indicator.

---

### B43. Which of the following can be used for credit card transactions from a mobile device without sending the actual credit card number across the network?

A) Tokenization
B) Hashing
C) Steganography
D) Masking

**Answer: A**

**Domain:** 3.0 - Security Architecture

**Explanation:** [[Tokenization]] replaces sensitive data (like a credit card number) with a non-sensitive, single-use placeholder token. This is the standard method for NFC (Near-Field Communication) and mobile payment systems—the token is sent across the network instead of the actual card data, and the payment processor maps it back to the real account. [[Hashing]] creates an irreversible digital fingerprint and cannot be reversed to complete transactions. [[Steganography]] hides data within other media types (e.g., text in images), not suitable for payment transfers. **Data masking** obscures portions of data but cannot omit critical transaction information.

---

### B44. A security administrator receives a report each week showing a Linux vulnerability associated with a Windows server. Which of the following would prevent this information from appearing in the report?

A) Alert tuning
B) Application benchmarking
C) SIEM aggregation
D) Data archiving

**Answer: A**

**Domain:** 4.0 - Security Operations

**Explanation:** **Alert tuning** involves configuring monitoring systems to suppress false positives and irrelevant alerts. In this case, tuning would suppress the invalid alert about a Linux vulnerability on a Windows server. **Application benchmarking** establishes performance baselines but doesn't change alert rules. [[SIEM]] **aggregation** centralizes logs from multiple sources but doesn't remove invalid alerts. **Data archiving** stores historical data for compliance but doesn't suppress current alerts.

---

### B45. Which of the following would a company use to calculate the loss of a business activity if a vulnerability is exploited?

A) Risk tolerance
B) Vulnerability classification
C) Environmental variables
D) Exposure factor

**Answer: D**

**Domain:** 4.0 - Security Operations

**Explanation:** An **exposure factor** represents the percentage of value/functionality lost if a vulnerability is exploited (e.g., 50% loss if half the users are affected, 100% if the service is fully disabled). It's a core component of quantitative risk calculations. **Risk tolerance** is the amount of risk an organization accepts strategically, not a calculation method. **Vulnerability classification** assigns severity scores to known vulnerabilities but doesn't measure business impact. **Environmental variables** (production vs. test environments) inform prioritization but don't quantify loss.

---

### B46. An administrator is designing a network to be compliant with a security standard for storing credit card numbers. Which of the following would be the BEST choice to provide this compliance?

A) Implement RAID for all storage systems
B) Connect a UPS to all servers
C) DNS should be available on redundant servers
D) Perform regular audits and vulnerability scans

**Answer: D**

**Domain:** 5.0 - Governance, Risk, and Compliance

**Explanation:** Credit card storage compliance (e.g., [[PCI-DSS]]) requires ongoing monitoring, vulnerability assessment, and audits to protect sensitive cardholder data and maintain security controls. Regular **audits and vulnerability scans** directly address the core compliance requirement of preventing unauthorized access and detecting breaches. [[RAID]] ensures data availability/durability but is not a compliance requirement for credit card standards. A [[UPS]] maintains uptime but is not compliance-specific. Redundant **DNS** provides availability but isn't mandated by credit card compliance standards.

---

### B47. A company is accepting proposals for an upcoming project, and one of the responses is from a business owned by a board member. Which of the following would describe this situation?

A) Due diligence
B) Vendor monitoring
C) Conflict of interest
D) Right-to-audit

**Answer: C**

**Domain:** 5.0 - Governance, Risk, and Compliance

**Explanation:** A **conflict of interest** occurs when personal or family relationships could compromise impartial judgment in a business decision. A board member having a financial stake in a vendor responding to a company bid creates an obvious conflict of interest. **Due diligence** is the investigation process before engaging with a vendor. **Vendor monitoring** is ongoing relationship management post-engagement. **Right-to-audit** is a contractual clause granting audit access rights.

---

### B48. A company has rolled out a new application that requires the use of a hardware-based token generator. Which of the following would be the BEST description of this access feature?

A) Something you know
B) Somewhere you are
C) Something you are
D) Something you have

**Answer: D**

**Domain:** 4.0 - Security Operations

**Explanation:** A hardware token generator requires physical possession of the device to generate authentication codes—it is the "**something you have**" factor of [[MFA]]. This is distinct from "something you know" (passwords/PINs), "somewhere you are" (location-based authentication), and "something you are" ([[Biometrics]] like fingerprints or facial recognition). The security derives from the attacker needing the physical hardware.

---

### B49. A company has signed an SLA with an Internet service provider. Which of the following would BEST describe the requirements of this SLA?

A) The customer will connect to remote sites over an IPsec tunnel
B) The service provider will provide 99.99% uptime
C) The customer applications use HTTPS over tcp/443
D) Customer application use will be busiest on the 15th of each month

**Answer: B**

**Domain:** 5.0 - Governance, Risk, and Compliance

**Explanation:** An **SLA** (Service Level Agreement) is a contract defining minimum service standards the provider commits to deliver—typically including uptime percentages (e.g., 99.99%), response times, and availability metrics. **Answer A** describes how a customer uses the service (customer responsibility), not provider obligations. **Answer C** is a customer application configuration, not an SLA term. **Answer D** is customer usage pattern, not a service guarantee.

---

**End of Exam B, Questions B38–B49**

# VIRGIL Security+ Study Guide: Exam B Questions B50–B61

---

### B50. An attacker has created multiple social media accounts and is posting information in an attempt to get the attention of the media.

A) On-path
B) Watering hole
C) Misinformation campaign
D) Phishing

**Answer: C**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** [[Misinformation campaign|Misinformation campaigns]] are coordinated attacks leveraging social media and traditional media to spread false or misleading information. The attacker creates multiple accounts to amplify reach and credibility. **On-path** attacks intercept network traffic; **Watering hole** attacks compromise legitimate websites; **Phishing** uses social engineering to steal credentials—none address information spread via social media at scale.

---

### B51. Which of the following would be the BEST way to protect credit card account information when performing real-time purchase authorizations?

A) Masking
B) DLP
C) Tokenization
D) NGFW

**Answer: C**

**Domain:** 3.0 - Security Architecture and Tool Deployment

**Explanation:** [[Tokenization]] replaces sensitive data (credit card numbers) with non-sensitive tokens during transactions, preventing exposure of actual account data on the network. This is the standard for mobile and point-of-sale payments. **Masking** obscures data on displays only; **[[DLP]]** prevents data loss but doesn't protect transaction data in real-time; **NGFW** provides application control but no account protection.

---

### B52. A company must comply with legal requirements for storing customer data in the same country as the customer's mailing address.

A) Geographic dispersion
B) Least privilege
C) Data sovereignty
D) Exfiltration

**Answer: C**

**Domain:** 3.0 - Security Architecture and Tool Deployment

**Explanation:** [[Data sovereignty]] laws mandate that data must be stored and processed within specific geographic boundaries, subject to that country's laws and regulations. **Geographic dispersion** is for resilience/availability; **Least privilege** limits access rights; **Exfiltration** is unauthorized data theft—none address geographic storage mandates.

---

### B53. A company is installing access points in all of their remote sites. Which of the following would provide confidentiality for all wireless data?

A) 802.1X
B) WPA3
C) RADIUS
D) MDM

**Answer: B**

**Domain:** 4.0 - Security Operations

**Explanation:** [[WPA3]] (Wi-Fi Protected Access 3) is an encryption protocol that encrypts all data transmitted over wireless networks, providing confidentiality. **802.1X** is an authentication framework; **[[RADIUS]]** handles centralized authentication but not encryption; **MDM** manages mobile device policies—none provide wireless encryption.

---

### B54. A security administrator has found a keylogger installed in an update of the company's accounting software. Which of the following would prevent the transmission of the collected logs?

A) Prevent the installation of all software
B) Block all unknown outbound network traffic at the Internet firewall
C) Install host-based anti-virus software
D) Scan all incoming email attachments at the email gateway

**Answer: B**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** [[Keylogger|Keyloggers]] record input and exfiltrate data over the network. Blocking unknown outbound traffic at the firewall prevents the transmission phase. **Blocking software installation** prevents initial infection but not transmission; **anti-virus** may detect malware but doesn't control network traffic; **email scanning** prevents some infection vectors but allows already-installed malware to communicate.

---

### B55. A user in the marketing department is unable to connect to the wireless network after authenticating. The error message states the server credentials could not be validated.

A) The user's computer is in the incorrect VLAN
B) The RADIUS server is not responding
C) The user's computer does not support WPA3 encryption
D) The user is in a location with an insufficient wireless signal
E) The client computer does not have the proper certificate installed

**Answer: E**

**Domain:** 1.0 - General Security Concepts

**Explanation:** The error message specifically references certificate validation failure between the client and the [[RADIUS]] server. The client must have the root CA certificate installed to validate the server's certificate. If validation fails, the server certificate authority is either absent or mismatched on the client. **VLAN mismatch** wouldn't prevent authentication; **server timeout** would show differently; **WPA3 incompatibility** would fail at association, not authentication; **weak signal** wouldn't produce this validation error.

---

### B56. A security administrator has created a new policy prohibiting the use of MD5 hashes due to collision problems.

A) Two different messages have different hashes
B) The original message can be derived from the hash
C) Two identical messages have the same hash
D) Two different messages share the same hash

**Answer: D**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** A [[Hash collision|hash collision]] occurs when two different inputs produce the same hash output, violating the fundamental property that hashes should be unique per input. This compromises integrity verification. **Different messages having different hashes** is normal operation; **deriving original messages** violates one-way hashing principles (not a collision issue); **identical messages producing same hashes** is expected behavior.

---

### B57. A security administrator has been tasked with hardening internal web servers to control access from certain IP address ranges and ensure all transferred data remains confidential.

A) Change the administrator password
B) Use HTTPS for all server communication
C) Uninstall all unused software
D) Enable a host-based firewall
E) Install the latest operating system update

**Answer: B, D**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** **[[HTTPS]]** (HTTP Secure with [[TLS]]) encrypts all data in transit, ensuring confidentiality. A **host-based [[firewall]]** allows/denies traffic based on IP address ranges and ports. **Password changes** are general security hygiene but don't address IP filtering or confidentiality; **uninstalling unused software** is good hardening but doesn't meet stated goals; **OS updates** improve security but don't directly encrypt traffic or filter by IP.

---

### B58. A security administrator has identified ransomware on a database server and quarantined it. Which of the following should be followed to ensure evidence integrity?

A) E-discovery
B) Non-repudiation
C) Chain of custody
D) Legal hold

**Answer: C**

**Domain:** 4.0 - Security Operations

**Explanation:** [[Chain of custody]] maintains a documented record of evidence handling, tracking every person who accessed or interacted with evidence, preserving integrity for forensic and legal purposes. **E-discovery** is the broader process of collecting electronic documents but doesn't preserve integrity; **Non-repudiation** prevents denial of authorship; **Legal hold** preserves evidence but doesn't document handling procedures or maintain integrity.

---

### B59. Which of the following would be the BEST option for application testing in an environment completely separated from the production network?

A) Virtualization
B) VLANs
C) Cloud computing
D) Air gap

**Answer: D**

**Domain:** 3.0 - Security Architecture and Tool Deployment

**Explanation:** An [[Air gap|air-gapped network]] is physically/logically isolated with zero connectivity to other networks, providing absolute separation. **[[Virtualization]]** allows network misconfiguration; **[[VLAN|VLANs]]** can be bridged by routers; **cloud computing** typically maintains connections to other networks—all allow potential unauthorized communication paths.

---

### B60. A security engineer is planning the installation of a new IPS. The network must remain operational if the IPS is turned off or disabled.

A) Containerization
B) Load balancing
C) Fail open
D) Tunneling

**Answer: C**

**Domain:** 3.0 - Security Architecture and Tool Deployment

**Explanation:** **Fail open** configuration allows an [[IPS]] to pass traffic without blocking if the system fails or is disabled, ensuring network availability even during IPS outages. **[[Containerization]]** is application deployment; **[[Load balancing]]** distributes traffic across servers; **[[Tunneling]]** encapsulates data in other protocols—none ensure network continuity on IPS failure.

---

### B61. Which of the following describes the process of hiding data from others by embedding the data inside of a different media type?

A) Hashing
B) Obfuscation
C) Encryption
D) Masking

**Answer: B**

**Domain:** 3.0 - Security Architecture and Tool Deployment

**Explanation:** [[Obfuscation]] (including [[Steganography|steganographic techniques]]) hides data by embedding it within another media type (e.g., text within images), making it difficult to detect or understand. **[[Hash|Hashing]]** creates fingerprints for integrity, not concealment; **[[Encryption]]** scrambles data but doesn't hide it within other media; **[[Masking]]** replaces portions of data with placeholders (e.g., asterisks on receipts).

---

**End of Exam B Questions B50–B61**

# VIRGIL Study Guide: CompTIA Security+ SY0-701
## Practice Exam B, Questions B62–B73

---

### B62. Which of the following vulnerabilities would be the MOST significant security concern when protecting against a hacktivist?

A) Data center access with only one authentication factor
B) Spoofing of internal IP addresses when accessing an intranet server
C) Employee VPN access uses a weak encryption cipher
D) Lack of patch updates on an Internet-facing database server

**Answer: D**

**Domain:** 2.0 - Architecture, Design, and Strategy (Objective 2.1 - Threat Actors)

**Explanation:** Hacktivists operate from the internet and exploit publicly accessible attack surfaces. An unpatched, Internet-facing database server presents an easily exploitable [[Zero-day]] or known vulnerability that requires no physical access or internal network presence. Answers A and B require internal access (unlikely for hacktivists), while C is a weaker threat vector—capturing encrypted traffic is harder than exploiting an obvious patch gap.

---

### B63. A company is installing a security appliance to protect the organization's web-based applications from attacks such as SQL injections and unexpected input.

A) WAF
B) VPN concentrator
C) UTM
D) SASE

**Answer: A**

**Domain:** 3.0 - Implementation (Objective 3.2 - Firewall Types)

**Explanation:** A [[WAF]] (Web Application Firewall) is purpose-built to detect and block application-layer attacks including [[SQL Injection]], [[XSS]], and malformed input. A VPN concentrator manages remote access, not application attacks. A [[UTM]] provides general threat management but not specialized web app protection. [[SASE]] is a cloud-based VPN client, not a web application protector.

---

### B64. Which of the following would be the BEST way to determine if files have been modified after the forensics data acquisition process has occurred?

A) Use a tamper seal on all storage devices
B) Create a hash of the data
C) Image each storage device for future comparison
D) Take screenshots of file directories with file sizes

**Answer: B**

**Domain:** 4.0 - Security Operations (Objective 4.8 - Digital Forensics)

**Explanation:** [[Hashing]] produces a unique digital fingerprint of data; any modification produces a different hash value, instantly revealing tampering. Physical tamper seals only detect device opening, not data changes. Full imaging is slow and vulnerable to dual tampering. File sizes can change without content changes, providing no integrity verification.

---

### B65. A system administrator is implementing a password policy that would require letters, numbers, and special characters to be included in every password.

A) Length
B) Expiration
C) Reuse
D) Complexity

**Answer: D**

**Domain:** 4.0 - Security Operations (Objective 4.6 - Password Security)

**Explanation:** **Complexity** controls enforce character-type requirements (uppercase, lowercase, numbers, symbols). **Length** sets minimum character count but doesn't mandate character variety. **Expiration** forces periodic resets. **Reuse** prevents recycling old passwords. Only complexity mandates mixed character types.

---

### B66. Which of the following would a company follow to deploy a weekly operating system patch?

A) Tabletop exercise
B) Penetration testing
C) Change management
D) Internal audit

**Answer: C**

**Domain:** 1.0 - General Security Concepts (Objective 1.3 - Change Management Process)

**Explanation:** **Change management** is the formal governance process for controlled IT infrastructure modifications, including patch deployment. Tabletop exercises simulate disaster recovery scenarios. Penetration testing finds vulnerabilities. Internal audits validate compliance—none manage patch deployment workflows.

---

### B67. Which of the following would be the MOST likely result of plaintext application communication?

A) Buffer overflow
B) Replay attack
C) Resource consumption
D) Directory traversal

**Answer: B**

**Domain:** 2.0 - Architecture, Design, and Strategy (Objective 2.4 - Replay Attacks)

**Explanation:** [[Replay attack]]s require capturing unencrypted traffic to resend it. Plaintext communication makes capture trivial. [[Buffer overflow]], resource consumption, and [[Directory traversal]] attacks are independent of encryption status and don't inherently require plaintext.

---

### B68. A system administrator believes that certain configuration files on a Linux server have been modified from their original state and would like to be notified if they are changed again.

A) HIPS
B) File integrity monitoring
C) Application allow list
D) WAF

**Answer: B**

**Domain:** 4.0 - Security Operations (Objective 4.5 - Monitoring Data)

**Explanation:** **File integrity monitoring** (e.g., Tripwire, System File Checker) detects and alerts on file modifications by comparing checksums. [[HIPS]] detects exploits/intrusions, not file changes. Application allow lists only restrict execution. [[WAF]] protects web apps, not OS files.

---

### B69. A security administrator is updating the network infrastructure to support 802.1X.

A) LDAP
B) SIEM
C) SNMP traps
D) SPF

**Answer: A**

**Domain:** 4.0 - Security Operations (Objective 4.6 - Identity and Access Management)

**Explanation:** [[802.1X]] is a port-based authentication standard that requires a backend authentication server. [[LDAP]] (Lightweight Directory Access Protocol) is the standard centralized authentication service (alternatives: RADIUS, TACACS+, Kerberos). [[SIEM]] consolidates logs. [[SNMP]] sends alerts. [[SPF]] validates email senders—none support 802.1X.

---

### B70. A company owns a time clock appliance that doesn't provide access to the operating system and doesn't provide a method to upgrade the firmware.

A) End-of-life
B) ICS
C) SDN
D) Embedded system

**Answer: D**

**Domain:** 3.0 - Implementation (Objective 3.1 - Other Infrastructure Concepts)

**Explanation:** An **embedded system** is a purpose-built device with restricted OS access and limited or no firmware upgrade capability. End-of-life requires vendor discontinuation evidence. [[ICS]] (Industrial Control Systems) applies to large manufacturing/power systems, not time clocks. [[SDN]] is network architecture, not device classification.

---

### B71. A company has deployed laptops to all employees, and each laptop is enumerated during each login.

A) If the laptop hardware is modified, the security team is alerted
B) Any malware identified on the system is automatically deleted
C) Users are required to use at least two factors of authentication
D) The laptop is added to a private VLAN after the login process

**Answer: A**

**Domain:** 4.0 - Security Operations (Objective 4.2 - Asset Management)

**Explanation:** **Enumeration** catalogs hardware and software configurations; comparison against baseline detects unauthorized changes (hardware additions, removals). Malware deletion requires anti-malware engines (separate from enumeration). [[MFA]] is orthogonal to enumeration. VLAN placement requires network policies beyond enumeration.

---

### B72. A security manager believes an employee is using their laptop to circumvent corporate Internet security controls through a cellular hotspot. (Select TWO)

A) HIPS
B) UTM logs
C) Web application firewall events
D) Host-based firewall logs
E) Next-generation firewall logs

**Answer: A, D**

**Domain:** 2.0 - Architecture, Design, and Strategy (Objective 2.5 - Hardening Techniques)

**Explanation:** When bypassing corporate networks via cellular hotspot, traffic never touches network perimeter devices. Only **on-device logs** capture the rogue connection: **[[HIPS]]** and **host-based firewall logs** monitor local traffic flows. [[UTM]], [[WAF]], and next-generation firewalls sit on the network edge and miss off-network cellular traffic entirely.

---

### B73. An application developer is creating a mobile device app requiring a true random number generator and real-time memory encryption.

A) HSM
B) Secure enclave
C) NGFW
D) Self-signed certificates

**Answer: B**

**Domain:** 1.0 - General Security Concepts (Objective 1.4 - Encryption Technologies)

**Explanation:** A **secure enclave** is a hardware-based security processor on mobile/modern devices that generates cryptographic randomness, performs real-time memory encryption, and stores root [[PKI]] keys. An [[HSM]] is a networked enterprise appliance (not mobile-native). [[NGFW]] manages traffic, not cryptographic functions. Self-signed certificates only authenticate—no randomization or encryption capability.

---

**Study Notes:**
- **Key domains covered:** Threat actors, network controls ([[WAF]], [[firewall]] types), digital forensics ([[hashing]]), [[IAM]] ([[802.1X]], [[LDAP]]), endpoint security ([[HIPS]], file integrity), and cryptography.
- **Common patterns:** Questions favor practical, layered defenses over single-tool solutions.
- **Weak cipher reminder:** While B67's weak cipher is a concern, [[replay attack]]s are more directly enabled by plaintext—a direct cause vs. theoretical vulnerability.

# VIRGIL's Security+ SY0-701 Study Guide
## Exam B Questions B74–B85

---

### B74. Which of the following would be a common result of a successful vulnerability scan?

A) Usernames and password hashes from a server
B) A list of missing software patches
C) A copy of image files from a private file share
D) The BIOS configuration of a server

**Answer: B**

**Domain:** 4.0 - Security Operations

**Explanation:** [[Vulnerability scanning]] tools identify security weaknesses and missing patches by comparing installed software against known vulnerability databases. Option A is incorrect because vulnerability scans don't extract credentials or password hashes—that would require active exploitation. Option C fails because private file shares prevent unauthorized access, and scans have no permissions to access private data. Option D is wrong because BIOS configuration is protected system information not exposed by standard vulnerability scans.

---

### B75. When connected to the wireless network, users at a remote site receive an IP address which is not part of the corporate address scheme.

A) Rogue access point
B) Domain hijack
C) DDoS
D) Encryption is enabled

**Answer: A**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** A [[rogue access point]] is an unauthorized wireless access point that assigns IP addresses outside the corporate DHCP scope, causing both addressing and performance issues. Domain hijack (B) targets domain registration, not wireless addressing. [[DDoS]] (C) causes service degradation but doesn't modify IP addressing schemes. Encryption (D) adds minimal overhead and wouldn't change IP address assignment ranges.

---

### B76. A company has identified a compromised server, and the security team would like to know if an attacker has used this device to move between systems.

A) DNS server logs
B) Penetration test
C) NetFlow logs
D) Email metadata

**Answer: C**

**Domain:** 4.0 - Security Operations

**Explanation:** [[NetFlow]] provides detailed network traffic summaries showing all conversations and data flows initiated by a device, revealing lateral movement patterns. DNS logs (A) only show name resolutions and attackers may bypass DNS. A penetration test (B) identifies vulnerabilities but won't show actual attacker traffic flows. Email metadata (D) contains only email server details, not network traffic information.

---

### B77. A system administrator has protected a set of system backups with an encryption key. The system administrator used the same key when restoring files from this backup.

A) Asymmetric
B) Key escrow
C) Symmetric
D) Out-of-band key exchange

**Answer: C**

**Domain:** 1.0 - General Security Concepts

**Explanation:** [[Symmetric encryption]] uses a single shared key for both encryption and decryption. [[Asymmetric encryption]] (A) uses separate public/private key pairs. [[Key escrow]] (B) involves a third party holding decryption keys. Out-of-band key exchange (D) describes the delivery method of keys, not the encryption type itself.

---

### B78. A new malware variant takes advantage of a vulnerability in a popular email client. Once installed, the malware forwards all email attachments with credit card information to an external email address.

A) Enable MFA on the email client
B) Scan outgoing traffic with DLP
C) Require users to enable the VPN when using email
D) Update the list of malicious URLs in the firewall

**Answer: B**

**Domain:** 4.0 - Security Operations

**Explanation:** [[DLP]] (Data Loss Prevention) systems detect and block the transmission of sensitive data like credit card information by scanning outgoing traffic. [[MFA]] (A) protects authentication but won't prevent already-compromised malware from exfiltrating data. [[VPN]] (C) encrypts traffic but doesn't prevent malware from sending data once connected. URL filtering (D) won't stop email-based data exfiltration.

---

### B79. An organization has identified a security breach and has removed the affected servers from the network. Which of the following is the NEXT step in the incident response process?

A) Eradication
B) Preparation
C) Recovery
D) Detection
E) Containment

**Answer: A**

**Domain:** 4.0 - Security Operations

**Explanation:** The incident response lifecycle is: Preparation → Detection → Analysis → Containment → **Eradication** → Recovery → Lessons Learned. Containment (removing servers from the network) has already occurred, so the next phase is eradication—removing malware and breached accounts. Preparation (B) occurs before incidents. Recovery (C) comes after eradication. Detection (D) and Containment (E) have already happened.

---

### B80. A security administrator has been tasked with storing and protecting customer payment and shipping information for a three-year period. Which of the following would describe the source of this data?

A) Controller
B) Owner
C) Data subject
D) Processor

**Answer: C**

**Domain:** 5.0 - Security Program Management and Oversight

**Explanation:** A [[data subject]] is the individual whose personal data is being collected and protected (customers in this case). The data controller (A) manages data processing operations. The data owner (B) is accountable for data governance. The data processor (D) handles data on behalf of the controller.

---

### B81. Which of the following would be the main reasons why a system administrator would use a TPM when configuring full disk encryption?

A) Allows the encryption of multiple volumes
B) Uses burned-in cryptographic keys
C) Stores certificates in a hardware security module
D) Maintains a copy of the CRL
E) Includes built-in protections against brute-force attacks

**Answer: B, E**

**Domain:** 3.0 - Cryptography and PKI

**Explanation:** A [[TPM]] (Trusted Platform Module) is a dedicated hardware chip that stores burned-in cryptographic keys and provides brute-force/dictionary attack protections for full disk encryption credentials. Option A is incorrect—TPM doesn't control volume count. Option C confuses TPM with [[HSM]] (Hardware Security Module), which are separate systems. Option D is wrong—[[CRL]] (Certificate Revocation List) is maintained by Certificate Authorities, not TPM.

---

### B82. A security administrator is using an access control where each file or folder is assigned a security clearance level, such as "confidential" or "secret." The security administrator then assigns a maximum security level to each user.

A) Mandatory
B) Rule-based
C) Discretionary
D) Role-based

**Answer: A**

**Domain:** 4.0 - Security Operations

**Explanation:** [[Mandatory Access Control]] (MAC) assigns security classifications to objects and clearance levels to users; access is granted only when the user's clearance meets or exceeds the object's classification. Rule-based (B) enforces system-defined rules. [[Discretionary Access Control]] (C) lets owners assign permissions. [[Role-based Access Control]] (D) grants permissions based on organizational roles.

---

### B83. A security administrator is reviewing a report showing a number of devices on internal networks are connecting with servers in the data center network. Which of the following security systems should be added to prevent internal systems from accessing data center devices?

A) VPN
B) IPS
C) SIEM
D) ACL

**Answer: D**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** An [[ACL]] (Access Control List) on routers explicitly permits or denies traffic flows between network segments, preventing unauthorized internal access to data centers. [[VPN]] (A) secures data but doesn't control internal traffic. [[IPS]] (B) blocks known attacks but isn't designed for traffic segmentation. [[SIEM]] (C) logs and reports on events but doesn't actively control traffic.

---

### B84. A financial services company is headquartered in an area with a high occurrence of tropical storms and hurricanes. Which of the following would be MOST important when restoring services disabled by a storm?

A) Disaster recovery plan
B) Stakeholder management
C) Change management
D) Retention policies

**Answer: A**

**Domain:** 4.0 - Security Operations

**Explanation:** A [[disaster recovery plan]] provides comprehensive procedures for large-scale outages caused by natural disasters, technology failures, or human-created events. Stakeholder management (B) supports change processes but isn't the priority during recovery. Change management (C) applies to planned changes, not emergencies. Retention policies (D) govern data backup duration, not recovery procedures.

---

### B85. A user in the mail room has reported an overall slowdown of his shipping management software. An anti-virus scan did not identify any issues, but a more thorough malware scan identified a kernel driver which is not part of the original operating system installation.

A) Rootkit
B) Logic bomb
C) Bloatware
D) Ransomware
E) Keylogger

**Answer: A**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** A [[rootkit]] modifies core system files and kernel-level drivers to remain hidden from detection by standard antivirus tools—exactly matching the scenario. Logic bombs (B) wait for trigger events. [[Bloatware]] (C) is preinstalled software causing resource contention. [[Ransomware]] (D) is highly visible. Keyloggers (E) appear in process lists and generate network traffic.

---

**Study Progress:** 12/12 questions processed ✓

### B86. A virus scanner has identified a macro virus in a word processing file attached to an email. Which of the following information could be obtained from the metadata of this file?

A) IPS signature name and number
B) Operating system version
C) Date and time when the file was created
D) Alert disposition

**Answer: C**

**Domain:** 4.0 - Security Operations

**Explanation:** File [[metadata]] commonly includes creation date and time, modification timestamps, author information, and other embedded file properties. The other options are incorrect: (A) [[IPS]] signatures are generated during network detection, not stored in file metadata; (B) word processing files are OS-agnostic and don't store OS version in metadata; (D) alert disposition is created by security tools during scanning, not part of the document itself.

---

### B87. When a person enters a data center facility, they must check-in before they are allowed to move further into the building. Which of the following would BEST facilitate this process?

A) Access control vestibule
B) Air gap
C) Pressure sensors
D) Bollards

**Answer: A**

**Domain:** 1.0 - General Security Concepts

**Explanation:** An [[access control vestibule]] (also called a mantrap or airlock) is a physical security control consisting of two interlocked doors that prevents unauthorized passage. When one door unlocks, the other remains locked, forcing users to stop for check-in/check-out. (B) [[air gap]] creates network isolation, not personnel control; (C) pressure sensors detect force changes but don't manage access flow; (D) bollards channel foot traffic but aren't used for formal access control checkpoints.

---

### B88. A security administrator has discovered an employee exfiltrating confidential company information by embedding data within image files and emailing the images to a third-party. Which of the following would best describe this activity?

A) Digital signatures
B) Steganography
C) Salting
D) Data masking

**Answer: B**

**Domain:** 1.0 - General Security Concepts

**Explanation:** [[Steganography]] is the practice of hiding data within other media (images, audio, video) so that the very existence of the hidden message is concealed. The other options are incorrect: (A) [[digital signatures]] provide cryptographic authentication and non-repudiation, not data hiding; (C) [[salting]] adds random data to hashes to prevent rainbow table attacks; (D) [[data masking]] replaces sensitive information display (e.g., asterisks on credit cards) but doesn't hide data within media.

---

### B89. A third-party has been contracted to perform a penetration test on a company's public web servers. The testing company has been provided with the external IP addresses of the servers. Which of the following would describe this scenario?

A) Defensive
B) Active reconnaissance
C) Partially known environment
D) Regulatory

**Answer: C**

**Domain:** 5.0 - Security Operations

**Explanation:** A penetration test in a "partially known environment" (also called gray-box testing) provides the tester with limited information upfront—in this case, the external IPs but not detailed internal architecture. The other options are incorrect: (A) "defensive" refers to blue team activities detecting attacks in real-time; (B) active [[reconnaissance]] is the information-gathering phase performed by attackers/testers, but providing IPs directly skips reconnaissance; (D) regulatory describes compliance-driven testing requirements, not the testing methodology.

---

### B90. Which of the following would be the best way to describe the estimated number of laptops that might be stolen in a fiscal year?

A) ALE
B) SLE
C) ARO
D) MTTR

**Answer: C**

**Domain:** 5.0 - Security Operations

**Explanation:** [[ARO]] (Annualized Rate of Occurrence) quantifies how many times a risk event is expected to occur per year (e.g., 7 laptop thefts annually). The other options are incorrect: (A) [[ALE]] (Annual Loss Expectancy) = SLE × ARO, expressing total monetary impact annually; (B) [[SLE]] (Single Loss Expectancy) represents the cost of one occurrence (e.g., $1,000 per stolen laptop); (D) [[MTTR]] (Mean Time to Repair) measures recovery time after system failures, not risk frequency.

---
_Ingested: 2026-04-16 20:41 | Source: professor-messer-sy0-701-comptia-security-plus-practice-exams-v18.pdf_