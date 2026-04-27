---
exam: "A"
type: "multiple-choice"
question_count: 90
tags: [security-plus, sy0-701, practice-exam, exam-a]
---

# Security+ Practice Exam A — Questions & Answers

> **90 questions** | Organized by SY0-701 domain | Source: Professor Messer SY0-701 Practice Exams

# VIRGIL: CompTIA Security+ SY0-701 Study Guide
## Practice Exam A – Questions A1–A12

---

### A1. Match the description with the most accurate attack type.

**Matching:**
- Attacker obtains bank account number and birth date by calling the victim → **Vishing**
- Attacker accesses a database directly from a web browser → **Injection**
- Attacker intercepts all communication between a client and a web server → **On-path**
- Multiple attackers overwhelm a web server → **DDoS**
- Attacker obtains a list of all login credentials used over the last 24 hours → **Keylogger**

**Answer:** Vishing, Injection, On-path, DDoS, Keylogger

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** 
- [[Vishing]] is [[Phishing]] over voice/telephone—an effective social engineering vector for extracting personal information like bank account numbers and birth dates.
- [[SQL Injection]] is an attack that sends SQL commands through vulnerable web applications to directly access databases.
- **On-path attacks** (formerly MITM) position attackers between two devices to intercept and modify real-time communication.
- [[DDoS]] uses multiple coordinated attackers to overwhelm services; [[Denial of Service|DoS]] is single-source, DDoS is distributed.
- **Keyloggers** (hardware or software) capture all keyboard input, screenshots, and media, then covertly exfiltrate to the attacker.

---

### A2. Select the BEST security control for each location.

**Matching:**
- Outside Building (Parking and Visitor drop-off) → **Fencing & Lighting**
- Reception (Building lobby) → **Security guard & Access control vestibule**
- Data Center Door (Entrance from inside building) → **Access badge & Biometrics**
- Server Administration (Authentication to server console in data center) → **Authentication token**

**Answer:** Fencing & Lighting, Security guard & Access control vestibule, Access badge & Biometrics, Authentication token

**Domain:** 1.0 - General Security Concepts

**Explanation:**
- **Fencing & Lighting** provide perimeter control and deter unauthorized vehicle/foot traffic; improves visibility and safety.
- **Security guards** verify authorization at first entry point; **access control vestibules** manage flow and prevent tailgating.
- **Access badges** control physical entry; **biometrics** (fingerprint, handprint) add a second factor to prevent badge sharing/theft.
- **Authentication tokens** (along with username/password) provide [[MFA]] for console access, preventing unauthorized server administration even if physical access is gained.

---

### A3. Select the most appropriate security category.

**Matching:**
- A guard checks the identification of all visitors → **Operational**
- All returns must be approved by a Vice President → **Managerial**
- A generator is used during a power outage → **Physical**
- Building doors can be unlocked with an access card → **Physical**
- System logs are transferred automatically to a SIEM → **Technical**

**Answer:** Operational, Managerial, Physical, Physical, Technical

**Domain:** 1.0 - General Security Concepts

**Explanation:**
- **Operational controls** rely on people/processes (guards, awareness training, procedures).
- **Managerial controls** address policy, procedure, and administrative design/implementation.
- **Physical controls** limit physical access (badges, fences, locks, generators for business continuity).
- **Technical controls** use systems/automation ([[Firewall]], [[IDS]]/[[IPS]], [[SIEM]], access controls, encryption).

---

### A4. Match the appropriate authentication factor to each description.

**Matching:**
- Your phone receives a text message with a one-time passcode → **Something you have**
- You enter your PIN to make a deposit into an ATM → **Something you know**
- You can use your fingerprint to unlock the door to the data center → **Something you are**
- Your login will not work unless you are connected to the VPN → **Somewhere you are**

**Answer:** Something you have, Something you know, Something you are, Somewhere you are

**Domain:** 4.0 - Security Operations

**Explanation:**
- **Something you have:** Physical possession of a device receiving OTP ([[MFA]] second factor).
- **Something you know:** Secret memorized data (PIN, password, passphrase).
- **Something you are:** Biometric characteristics (fingerprint, iris, face recognition).
- **Somewhere you are:** Location-based authentication (VPN connection, geofencing, network segment membership).

---

### A5. Configure the following stateful firewall rules.

**Matching:**
- Block HTTP sessions between Web Server (10.1.1.2) and Database Server (10.2.1.20) → **Rule 1: Source 10.1.1.2, Destination 10.2.1.20, TCP, Port 80, Block**
- Allow Storage Server (10.2.1.33) to transfer files to Video Server (10.1.1.7) over HTTPS → **Rule 2: Source 10.2.1.33, Destination 10.1.1.7, TCP, Port 443, Allow**
- Allow Management Server (10.2.1.47) to use secure terminal on File Server (10.1.1.3) → **Rule 3: Source 10.2.1.47, Destination 10.1.1.3, TCP, Port 22, Allow**

**Answer:** Rule 1 (Block), Rule 2 (Allow), Rule 3 (Allow)

**Domain:** 3.0 - Security Implementation

**Explanation:**
- Rule 1 blocks HTTP (TCP/80) from Web Server to Database Server to prevent direct DB queries from the DMZ.
- Rule 2 allows HTTPS (TCP/443) from Storage Server (internal) to Video Server (DMZ) for secure file transfer.
- Rule 3 allows SSH (TCP/22) from Management Server to File Server for secure terminal/console access.
- A **stateful [[Firewall]]** automatically handles return traffic without requiring separate rules; only the initiating direction needs explicit configuration.

---

### A6. A company has hired a third-party to gather information about the company's servers and data. This third-party will not have direct access to the company's internal network, but they can gather information from any other source. Which of the following would BEST describe this approach?

A) Vulnerability scanning
B) Passive reconnaissance
C) Supply chain analysis
D) Regulatory audit

**Answer: B**

**Domain:** 5.0 - Security Program Management and Oversight

**Explanation:**
- **[[Passive reconnaissance]]** gathers intelligence from open sources (public websites, social media, WHOIS, DNS records, corporate filings) without direct contact or probing of the target.
- **Vulnerability scanning** is active—it directly queries systems to identify weaknesses.
- **Supply chain analysis** evaluates supplier/vendor security, not the company's own servers.
- **Regulatory audit** requires detailed internal access and formal compliance verification.

---

### A7. A company's email server has received an email from a third-party, but the origination server does not match the list of authorized devices. Which of the following would determine the disposition of this message?

A) SPF
B) NAC
C) DMARC
D) DKIM

**Answer: C**

**Domain:** 4.0 - Security Operations

**Explanation:**
- **[[DMARC]]** (Domain-based Message Authentication, Reporting & Conformance) specifies what to do with emails that fail authentication checks: accept, quarantine, or reject.
- **[[SPF]]** (Sender Policy Framework) lists authorized mail servers for a domain; validates sender identity but doesn't define message disposition.
- **[[NAC]]** (Network Access Control) restricts network access to authorized devices; unrelated to email filtering.
- **[[DKIM]]** (DomainKeys Identified Mail) validates digitally signed emails but does not determine how receiving servers handle them.

---

### A8. Which of these threat actors would be MOST likely to attack systems for direct financial gain?

A) Organized crime
B) Hacktivist
C) Nation state
D) Shadow IT

**Answer: A**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:**
- **Organized crime** threat actors are primarily motivated by profit (ransomware, theft, fraud, extortion, credential sales).
- **Hacktivists** pursue political/social agendas, not revenue.
- **Nation states** are already well-funded; objectives focus on espionage, sabotage, or geopolitical influence, not profit.
- **Shadow IT** refers to unauthorized organizational systems/apps built outside official IT channels—not an external threat actor.

---

### A9. A security administrator has examined a server recently compromised by an attacker, and has determined the system was exploited due to a known operating system vulnerability. Which of the following would BEST describe this finding?

A) Root cause analysis
B) E-discovery
C) Risk appetite
D) Data subject

**Answer: A**

**Domain:** 4.0 - Security Operations

**Explanation:**
- **Root cause analysis (RCA)** identifies the ultimate reason an incident occurred (e.g., unpatched vulnerability). This enables future prevention.
- **E-discovery** is the legal/forensic collection and production of electronic evidence; not focused on incident causation.
- **Risk appetite** is organizational tolerance for risk before mitigation—unrelated to breach investigation.
- **Data subject** refers to individuals whose personal data is involved (GDPR term)—not part of RCA.

---

### A10. A city is building an ambulance service network for emergency medical dispatching. Which of the following should have the highest priority?

A) Integration costs
B) Patch availability
C) System availability
D) Power usage

**Answer: C**

**Domain:** 3.0 - Security Implementation

**Explanation:**
- **System availability** is critical for emergency services; 24/7 uptime can directly impact lives.
- **Integration costs**, while important, are secondary to life-saving functionality.
- **Patch availability**, though essential for security, must be balanced against availability; patches can be applied during maintenance windows.
- **Power usage** is a minor consideration compared to continuous operation and redundancy needs (UPS, generators, failover systems).

---

### A11. A system administrator receives a text alert when access rights are changed on a database containing private customer information. Which of the following would describe this alert?

A) Maintenance window
B) Attestation and acknowledgment
C) Automation
D) External audit

**Answer: C**

**Domain:** 5.0 - Security Program Management and Oversight

**Explanation:**
- **Automation** performs compliance checks and generates alerts without manual intervention, enabling real-time detection of unauthorized configuration changes.
- **Maintenance window** schedules planned system downtime/changes; not related to alerting.
- **Attestation and acknowledgment** is formal signed verification of compliance status (end-of-period); not an automated alert.
- **External audit** is a third-party review; an automated system alert is not an audit.

---

### A12. A security administrator is concerned about the potential for data exfiltration using external storage drives. Which of the following would be the BEST way to prevent this method of data exfiltration?

A) Create an operating system security policy to block the use of removable media
B) Monitor removable media usage in host-based firewall logs
C) Only allow applications that do not use removable media
D) Define a removable media block rule in the UTM

**Answer: A**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:**
- **Operating system security policies** can disable USB ports or prevent file writes to removable media, providing preventive (not just detective) controls.
- **Host-based firewalls** monitor network traffic flows, not hardware access or USB device connections.
- **Applications** do not control removable media access—file system/OS policies do.
- **UTM** (Unified Threat Management) inspects network traffic patterns and content; it does not manage individual computer hardware interfaces or removable drive access.

---

**End of Exam A Questions A1–A12**

# VIRGIL: CompTIA Security+ SY0-701 Study Guide
## Practice Exam A – Questions A13–A24

---

### A13. A company creates a standard set of government reports each calendar quarter. Which of the following would describe this type of data?

A) Data in use
B) Obfuscated
C) Trade secrets
D) Regulated

**Answer: D**

**Domain:** 3.0 - Security Architecture

**Explanation:** Government reports are subject to legal and regulatory requirements governing data disclosure. [[Regulated data]] refers to information controlled by laws and compliance frameworks. Data in use describes active processing in memory (RAM, CPU registers); government reports are static documents. [[Obfuscation]] makes data difficult to understand—government reports are meant to be comprehensible. Trade secrets are proprietary business information not shared externally, whereas government reports are specifically created for external governmental entities.

---

### A14. An insurance company has created a set of policies to handle data breaches. The security team has been given this set of requirements based on these policies...

A) Restrict login access by IP address and GPS location
B) Require government-issued identification during the onboarding process
C) Add additional password complexity for accounts that access data
D) Conduct monthly permission auditing
E) Consolidate all logs on a SIEM
F) Archive the encryption keys of all disabled accounts
G) Enable time-of-day restrictions on the authentication server

**Answer: A, E, G**

**Domain:** 4.0 - Access Control, Identity, and Physical Security

**Explanation:** The three correct answers directly address the stated requirements:
- **A (IP/GPS location):** Prevents data access outside the country (geographic restriction)
- **E ([[SIEM]]):** Consolidates logs from all devices into a single database and generates audit reports
- **G (Time-of-day restrictions):** Blocks access outside normal working hours and reports violations

B, C, D, and F are security best practices but are not required by the stated policy requirements. B (ID verification) and C (password complexity) are general controls. D (monthly auditing) is not specified in requirements. F (archiving encryption keys) addresses data recovery for disabled accounts, not the breach-handling policies described.

---

### A15. A security engineer is viewing this record from the firewall logs: UTC 04/05/2023 03:09:15809 AV Gateway Alert 136.127.92.171 80 -> 10.16.10.14 60818...

A) The victim's IP address is 136.127.92.171
B) A download was blocked from a web server
C) A botnet DDoS attack was blocked
D) The Trojan was blocked, but the file was not

**Answer: B**

**Domain:** 4.0 - Security Operations

**Explanation:** The log entry shows traffic flowing from port 80 (HTTP web server port) on 136.127.92.171 to port 60818 on the internal device 10.16.10.14. This indicates a file download from an external web server that was intercepted. [[Trojan]] malware is commonly delivered via file downloads, and the [[AV Gateway]] blocked it before execution.

**Why others fail:**
- A: The arrow notation shows attacker IP → victim IP. 136.127.92.171 is the attacker/external server; 10.16.10.14 is the victim.
- C: [[DDoS]] attacks don't typically use Trojan delivery mechanisms; this is a single file transfer.
- D: The Trojan and the infected file are the same entity—they cannot be separated.

---

### A16. A user connects to a third-party website and receives this message: Your connection is not private. NET::ERR_CERT_INVALID. Which of the following attacks would be the MOST likely reason for this message?

A) Brute force
B) DoS
C) On-path
D) Deauthentication

**Answer: C**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** An [[on-path attack]] (formerly MITM—man-in-the-middle) involves an attacker intercepting traffic between the client and legitimate server. The attacker cannot present a valid [[TLS]] certificate for a third-party domain, causing the browser to display a certificate validation error.

**Why others fail:**
- A: [[Brute force]] targets password authentication, not certificate validity.
- B: [[DoS]] causes service unavailability/timeout errors, not certificate warnings.
- D: Deauthentication attacks occur on wireless networks and cause disconnects, not certificate errors.

---

### A17. Which of the following would be the BEST way to provide a website login using existing credentials from a third-party site?

A) Federation
B) 802.1X
C) EAP
D) SSO

**Answer: A**

**Domain:** 4.0 - Identity and Access Management

**Explanation:** [[Federation]] allows users to authenticate using credentials from one organization/system to access resources in another organization/system. It enables cross-organizational trust and credential sharing.

**Why others fail:**
- B: [[802.1X]] is a network access control protocol; it requires additional federation components to work across organizations.
- C: [[EAP]] (Extensible Authentication Protocol) is an authentication framework used in network access but doesn't provide cross-organizational federation.
- D: [[SSO]] (Single Sign-On) allows one authentication to access multiple services *within the same organization*, not across third-party systems.

---

### A18. A system administrator is working on a contract that will specify a minimum required uptime for a set of Internet-facing firewalls. The administrator needs to know how often the firewall hardware is expected to fail between repairs. Which of the following would BEST describe this information?

A) MTBF
B) RTO
C) MTTR
D) RPO

**Answer: A**

**Domain:** 5.0 - Governance, Risk, and Compliance

**Explanation:** [[MTBF]] (Mean Time Between Failures) predicts the average interval between hardware/system failures. It answers "how often does equipment fail?" This is essential for uptime contracts and hardware reliability planning.

**Why others fail:**
- B: [[RTO]] (Recovery Time Objective) defines the timeframe to restore service *after* failure.
- C: [[MTTR]] (Mean Time to Restore) measures the average repair time once a failure is detected.
- D: [[RPO]] (Recovery Point Objective) specifies the maximum acceptable data loss (time-based).

---

### A19. An attacker calls into a company's help desk and pretends to be the director of the company's manufacturing department. The attacker states that they have forgotten their password and they need to have the password reset quickly for an important meeting. What kind of attack would BEST describe this phone call?

A) Social engineering
B) Supply chain
C) Watering hole
D) On-path

**Answer: A**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** This is [[social engineering]] using [[impersonation]] to exploit principles of authority (claiming to be a director) and urgency (important meeting) to manipulate the help desk into bypassing security controls.

**Why others fail:**
- B: [[Supply chain]] attacks target vendors, equipment, or materials—not help desk phone calls.
- C: [[Watering hole]] attacks compromise third-party websites to infect visitors; not a direct phone attack.
- D: [[On-path attack]] requires passive/active traffic interception, not direct impersonation.

---

### A20. Two companies have been working together for a number of months, and they would now like to qualify their partnership with a broad formal agreement between both organizations. Which of the following would describe this agreement?

A) SLA
B) SOW
C) MOA
D) NDA

**Answer: C**

**Domain:** 5.0 - Governance, Risk, and Compliance

**Explanation:** An [[MOA]] (Memorandum of Agreement) is a formal document where both parties agree to a broad set of partnership goals, objectives, and general terms. It establishes mutual understanding at a high level.

**Why others fail:**
- A: [[SLA]] (Service Level Agreement) specifies minimum service requirements and performance metrics; more specific than an MOA.
- B: [[SOW]] (Statement of Work) provides detailed deliverables and tasks (e.g., "install and configure firewall"); too granular for initial partnership qualification.
- D: [[NDA]] (Non-Disclosure Agreement) is a confidentiality contract; this scenario doesn't emphasize privacy concerns.

---

### A21. Which of the following would explain why a company would automatically add a digital signature to each outgoing email message?

A) Confidentiality
B) Integrity
C) Authentication
D) Availability

**Answer: B**

**Domain:** 1.0 - General Security Concepts

**Explanation:** [[Digital signatures]] provide [[integrity]] by allowing recipients to verify that message content has not been altered since signing. Using [[PKI]] cryptography, the signature proves the data is unchanged.

**Why others fail:**
- A: [[Confidentiality]] (privacy) requires encryption, not digital signatures.
- C: While signatures can provide sender identity verification, [[authentication]] via username/password is the primary authentication mechanism; digital signatures' main purpose here is integrity.
- D: [[Availability]] ensures authorized users can access data; digital signatures don't affect availability.

---

### A22. The embedded OS in a company's time clock appliance is configured to reset the file system and reboot when a file system error occurs. On one of the time clocks, this file system error occurs during the startup process and causes the system to constantly reboot. Which of the following BEST describes this issue?

A) Memory injection
B) Resource consumption
C) Race condition
D) Malicious update

**Answer: C**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** A [[race condition]] occurs when two competing processes (file system check vs. reboot trigger) occur nearly simultaneously, causing an unintended outcome. The OS attempts to reboot *before* the file system error can be fixed, perpetuating a reboot loop.

**Why others fail:**
- A: [[Memory injection]] is a malware technique that injects code into running processes; not relevant here.
- B: [[Resource consumption]] would indicate low memory/storage—the appliance would become unresponsive but doesn't fit the constant reboot behavior.
- D: [[Malicious update]] refers to software patches containing unwanted code; this is a genuine file system error, not a compromised patch.

---

### A23. A recent audit has found that existing password policies do not include any restrictions on password attempts, and users are not required to periodically change their passwords. Which of the following would correct these policy issues? (Select TWO)

A) Password complexity
B) Password expiration
C) Password reuse
D) Account lockout
E) Password managers

**Answer: B, D**

**Domain:** 4.0 - Access Control, Identity, and Physical Security

**Explanation:** 
- **B (Password expiration):** Forces periodic password changes, addressing the lack of mandatory password renewal.
- **D (Account lockout):** Disables accounts after a predefined number of failed login attempts, providing the missing restriction on password attempts.

**Why others fail:**
- A: [[Password complexity]] makes passwords harder to crack but doesn't address the two stated issues (periodic changes or attempt restrictions).
- C: Password reuse restrictions prevent cycling back to old passwords; doesn't address the stated problems.
- E: [[Password managers]] securely store credentials but don't enforce policy constraints like expiration or lockout.

---

### A24. What kind of security control is associated with a login banner?

A) Preventive
B) Deterrent
C) Corrective
D) Detective
E) Compensating
F) Directive

**Answer: B**

**Domain:** 1.0 - General Security Concepts

**Explanation:** A login banner is a [[deterrent control]]. It does not block or prevent attacks but discourages unauthorized access by warning intruders of monitoring, legal consequences, and authorized-use-only policies.

**Why others fail:**
- A: [[Preventive controls]] physically block access (e.g., locks, firewalls).
- C: [[Corrective controls]] mitigate damage after an incident occurs (e.g., backups, incident response).
- D: [[Detective controls]] identify and record intrusion attempts (e.g., [[IDS]], [[SIEM]]).
- E: [[Compensating controls]] restore functionality after an attack via alternative means (e.g., redundant systems).
- F: [[Directive controls]] rely on user compliance through policy/guidelines; weaker than deterrent controls.

---

**END OF A13–A24**

# VIRGIL Study Guide: Exam A, Questions A25–A36

---

### A25. An internal audit has discovered four servers that have not been updated in over a year, and it will take two weeks to test and deploy the latest patches. Which of the following would be the best way to quickly respond to this situation in the meantime?

A) Purchase cybersecurity insurance
B) Implement an exception for all data center services
C) Move the servers to a protected segment
D) Hire a third-party to perform an extensive audit

**Answer: C**

**Domain:** 4.0 - Security Operations

**Explanation:** Moving unpatched servers to an isolated [[Network Segmentation|protected segment]] provides immediate risk mitigation while patches are being tested. This implements [[Zero Trust]] principles by containing potential threats. A) Insurance doesn't prevent compromise. B) Broad security exceptions are dangerous and contradict least privilege. D) Audits take too long for a two-week window.

---

### A26. A business manager is documenting a set of steps for processing orders if the primary Internet connection fails. Which of these would BEST describe these steps?

A) Platform diversity
B) Continuity of operations
C) Cold site recovery
D) Tabletop exercise

**Answer: B**

**Domain:** 3.0 - Security Architecture

**Explanation:** [[Continuity of Operations]] (COOP) planning documents alternative procedures to maintain business functions during outages. A) Platform diversity addresses OS vulnerabilities, not connection failures. C) Cold sites require too much setup time; hot/warm sites are better. D) Tabletop exercises *simulate* recovery scenarios; they don't document actual procedures.

---

### A27. A company would like to examine the credentials of each individual entering the data center building. Which of the following would BEST facilitate this requirement?

A) Access control vestibule
B) Video surveillance
C) Pressure sensors
D) Bollards

**Answer: A**

**Domain:** 1.0 - General Security Concepts

**Explanation:** An [[Access Control Vestibule]] (mantrap/airlock) is a physical security control that creates a confined space to validate credentials before granting access. B) Surveillance monitors but doesn't verify credentials. C) Pressure sensors detect movement, not credentials. D) Bollards restrict vehicle access, not personnel validation.

---

### A28. A company stores some employee information in encrypted form, but other public details are stored as plaintext. Which of the following would BEST describe this encryption strategy?

A) Full-disk
B) Record
C) Asymmetric
D) Key escrow

**Answer: B**

**Domain:** 1.0 - General Security Concepts

**Explanation:** [[Record-level Encryption]] (column-level) encrypts specific database fields while leaving others as plaintext—ideal for mixed sensitivity data. A) Full-disk encryption protects *all* data, leaving none as plaintext. C) Asymmetric encryption is a cryptographic method, not a storage strategy. D) Key escrow manages key storage, not which data gets encrypted.

---

### A29. A company would like to minimize database corruption if power is lost to a server. Which of the following would be the BEST strategy to follow?

A) Encryption
B) Off-site backups
C) Journaling
D) Replication

**Answer: C**

**Domain:** 3.0 - Security Architecture

**Explanation:** [[Journaling]] writes transactions to a temporary log before committing to the database. If power fails, incomplete transactions are rolled back, preventing corruption. A) Encryption provides confidentiality, not integrity during power loss. B) Backups enable recovery *after* corruption occurs. D) Replication copies corrupted data to another system.

---

### A30. A company is creating a security policy for corporate mobile devices:
• All mobile devices must be automatically locked after a predefined time period.
• The location of each device needs to be traceable.
• All of the user's information should be completely separate from company data.
Which of the following would be the BEST way to establish these security policy rules?

A) Segmentation
B) Biometrics
C) COPE
D) MDM

**Answer: D**

**Domain:** 4.0 - Security Operations

**Explanation:** [[MDM]] (Mobile Device Manager) is a centralized platform that enforces device lock policies, geolocation tracking, and data compartmentalization across multiple devices. A) Segmentation describes data separation but doesn't enforce policies. B) Biometrics is one authentication layer, not a policy framework. C) COPE (Corporately Owned, Personally Enabled) is a device ownership model, not a management solution.

---

### A31. A security engineer runs a monthly vulnerability scan. The scan doesn't list any vulnerabilities for Windows servers, but a significant vulnerability was announced last week and none of the servers are patched yet. Which of the following best describes this result?

A) Exploit
B) Compensating controls
C) Zero-day attack
D) False negative

**Answer: D**

**Domain:** 4.0 - Security Operations

**Explanation:** A [[False Negative]] occurs when a detection tool fails to identify an existing vulnerability. The scan missed a known, unpatched flaw. A) An exploit is an active attack, not a scan result. B) Compensating controls mitigate vulnerabilities that can't be patched immediately. C) A [[Zero-day]] is an unknown vulnerability; this one is publicly announced.

---

### A32. An IT help desk is using automation to improve the response time for security events. Which of the following use cases would apply to this process?

A) Escalation
B) Guard rails
C) Continuous integration
D) Resource provisioning

**Answer: A**

**Domain:** 4.0 - Security Operations

**Explanation:** Automation can detect security alerts and automatically escalate tickets to the incident response team without manual intervention. B) Guard rails validate user input in applications. C) [[Continuous Integration]] automates code testing/deployment. D) Resource provisioning automates user account/permission creation during onboarding—not security event handling.

---

### A33. A network administrator would like each user to authenticate with their corporate username and password when connecting to the company's wireless network. Which of the following should the network administrator configure on the wireless access points?

A) WPA3
B) 802.1X
C) PSK
D) MFA

**Answer: B**

**Domain:** 3.0 - Security Architecture

**Explanation:** [[802.1X]] is a port-based network access control protocol that uses a centralized authentication server (RADIUS) to validate individual user credentials. A) [[WPA3]] is wireless encryption; it doesn't provide per-user authentication. C) [[PSK]] (Pre-Shared Key) uses one shared password for all users. D) [[MFA]] adds a second factor but doesn't itself provide individual credential authentication.

---

### A34. A company's VPN service performs a posture assessment during the login process. Which of the following mitigation techniques would this describe?

A) Encryption
B) Decommissioning
C) Least privilege
D) Configuration enforcement

**Answer: D**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** A posture assessment evaluates device configuration (patches, antivirus, firewall status, etc.) before [[VPN]] access is granted—enforcing baseline security standards. A) [[Encryption]] secures data in transit, not configuration validation. B) Decommissioning removes systems from service. C) [[Least Privilege]] limits user permissions, not device configurations.

---

### A35. A user has assigned individual rights and permissions to a file on their network drive. The user adds three additional individuals to have read-only access to the file. Which of the following would describe this access control model?

A) Discretionary
B) Mandatory
C) Attribute-based
D) Role-based

**Answer: A**

**Domain:** 4.0 - Security Operations

**Explanation:** [[Discretionary Access Control]] (DAC) allows resource owners to freely assign permissions to other users. B) [[Mandatory Access Control]] assigns access based on fixed security labels, not owner discretion. C) [[Attribute-based Access Control]] combines multiple attributes (role, department, etc.) in policies. D) [[Role-based Access Control]] assigns permissions by job role, not individual files.

---

### A36. A remote user has received a text message with a link to login and confirm their upcoming work schedule. Which of the following would BEST describe this attack?

A) Brute force
B) Watering hole
C) Typosquatting
D) Smishing

**Answer: D**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** [[Smishing]] (SMS [[Phishing]]) tricks users via text messages into clicking malicious links or providing credentials. A) [[Brute force]] attacks try multiple password combinations. B) [[Watering hole]] attacks compromise legitimate websites to infect visitors. C) [[Typosquatting]] exploits domain name misspellings.

---

**Study tip:** Notice how A25–A30 test *defensive controls* (segmentation, policies, encryption), A31–A34 cover *detection and response* (false negatives, automation), and A35–A36 test *access control* and *social engineering*. These align with the four major exam domains.

# VIRGIL's Formatted Q&A: Practice Exam A (A37–A48)

---

### A37. A company is formalizing the design and deployment process used by their application programmers. Which of the following policies would apply?

A) Business continuity
B) Acceptable use policy
C) Incident response
D) Development lifecycle

**Answer: D**

**Domain:** 5.0 - Governance, Risk, and Compliance

**Explanation:** A [[Software Development Lifecycle]] (SDLC) policy formally defines the procedures for design, development, testing, deployment, and maintenance of applications. Business continuity plans address unavailable systems, not development processes. [[Acceptable Use Policy]] covers proper use of company assets. [[Incident Response]] procedures address security incidents, not development workflows.

---

### A38. A security administrator has copied a suspected malware executable from a user's computer and is running the program in a sandbox. Which of the following would describe this part of the incident response process?

A) Eradication
B) Preparation
C) Recovery
D) Containment

**Answer: D**

**Domain:** 4.0 - Security Operations

**Explanation:** [[Containment]] involves isolating threats to prevent spread while enabling safe analysis. Running [[Malware]] in a sandbox exemplifies this isolation. Eradication removes malware completely (re-imaging systems). Preparation occurs before incidents are discovered. Recovery restores systems after incidents conclude.

---

### A39. A server administrator at a bank has noticed a decrease in the number of visitors to the bank's website. Additional research shows that users are being directed to a different IP address than the bank's web server. Which of the following would MOST likely describe this attack?

A) Deauthentication
B) DDoS
C) Buffer overflow
D) DNS poisoning

**Answer: D**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** [[DNS Poisoning]] modifies [[DNS]] server records to redirect clients to attacker-controlled IP addresses. Deauthentication attacks target wireless networks. [[DDoS]] causes service unavailability rather than redirection. [[Buffer Overflow]] exploits application memory and doesn't redirect traffic.

---

### A40. Which of the following considerations are MOST commonly associated with a hybrid cloud model?

A) Microservice outages
B) IoT support
C) Network protection mismatches
D) Containerization backups

**Answer: C**

**Domain:** 3.0 - Security Architecture

**Explanation:** Hybrid cloud environments combine multiple cloud providers, creating complexity in consistent security policy application. Different authentication methods and user permissions across providers commonly create [[Network]] protection mismatches. Microservices, [[IoT]], and containerization are not specific to hybrid cloud models.

---

### A41. A company hires a large number of seasonal employees, and their system access should normally be disabled when the employee leaves the company. The security administrator would like to verify that their systems cannot be accessed by any of the former employees. Which of the following would be the BEST way to provide this verification?

A) Confirm that no unauthorized accounts have administrator access
B) Validate the account lockout policy
C) Validate the offboarding processes and procedures
D) Create a report that shows all authentications for a 24-hour period

**Answer: C**

**Domain:** 5.0 - Governance, Risk, and Compliance

**Explanation:** Offboarding procedures formally disable employee accounts. Validating these processes through account audits—comparing active accounts to active employees—confirms former employees lack access. Administrator audits don't verify all disabled accounts. Account lockout policies apply to valid accounts, not disabled ones. Authentication reports are too large to identify former employee access attempts effectively.

---

### A42. Which of the following is used to describe how cautious an organization might be to taking a specific risk?

A) Risk appetite
B) Risk register
C) Risk transfer
D) Risk reporting

**Answer: A**

**Domain:** 5.0 - Governance, Risk, and Compliance

**Explanation:** [[Risk Appetite]] describes organizational tolerance for risk-taking—whether conservative or expansionary. A [[Risk Register]] documents project-specific risks. [[Risk Transfer]] shifts risk to third parties (e.g., insurance). [[Risk Reporting]] formally documents risks for management decision-making.

---

### A43. A technician is applying a series of patches to fifty web servers during a scheduled maintenance window. After patching and rebooting the first server, the web service fails with a critical error. Which of the following should the technician do NEXT?

A) Contact the stakeholders regarding the outage
B) Follow the steps listed in the backout plan
C) Test the upgrade process in the lab
D) Evaluate the impact analysis associated with the change

**Answer: B**

**Domain:** 1.0 - General Security Concepts

**Explanation:** The [[Change Management]] backout plan provides procedures for reverting to previous configurations when errors occur. Stakeholder notification occurs after the maintenance window concludes. Lab testing happens before the maintenance window, not during crisis response. Impact analysis is completed before change approval.

---

### A44. An attacker has discovered a way to disable a server by sending specially crafted packets from many remote devices to the operating system. When the packet is received, the system crashes and must be rebooted to restore normal operations. Which of the following would BEST describe this attack?

A) Privilege escalation
B) SQL injection
C) Replay attack
D) DDoS

**Answer: D**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** [[DDoS]] (Distributed Denial of Service) overwhelms services using packets from multiple devices to render systems unavailable. [[Privilege Escalation]] exceeds user permissions. [[SQL Injection]] targets databases via application vulnerabilities. [[Replay Attack]] captures and retransmits previously recorded data.

---

### A45. A data breach has occurred in a large insurance company. A security administrator is building new servers and security systems to get all of the financial systems back online. Which part of the incident response process would BEST describe these actions?

A) Lessons learned
B) Containment
C) Recovery
D) Analysis

**Answer: C**

**Domain:** 4.0 - Security Operations

**Explanation:** [[Recovery]] restores systems and services to normal operations after [[Incident Response]]. Lessons learned reviews occur post-incident. [[Containment]] isolates threats during incidents. Analysis investigates log files and alerts during the incident.

---

### A46. A network team has installed new access points to support an application launch. In less than 24 hours, the wireless network was attacked and private company information was accessed. Which of the following would be the MOST likely reason for this breach?

A) Race condition
B) Jailbreaking
C) Impersonation
D) Misconfiguration

**Answer: D**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** [[Misconfiguration]] of access points commonly creates security gaps (weak authentication, open SSIDs, default credentials). [[Race Condition]] occurs when concurrent processes lack synchronization. [[Jailbreaking]] modifies mobile device firmware. [[Impersonation]] involves identity spoofing, not configuration flaws.

---

### A47. An organization has identified a significant vulnerability in an Internet-facing firewall. The firewall company has stated the firewall is no longer available for sale and there are no plans to create a patch for this vulnerability. Which of the following would BEST describe this issue?

A) End-of-life
B) Improper input handling
C) Improper key management
D) Incompatible OS

**Answer: A**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** [[End-of-Life]] describes products no longer supported by manufacturers—no patches, updates, or security fixes are released. Improper input handling relates to application security validation. [[Improper Key Management]] concerns cryptographic operations. Incompatible OS issues don't apply to purpose-built [[Firewall]] devices.

---

### A48. A company has decided to perform a disaster recovery exercise during an annual meeting with the IT directors and senior directors. A simulated disaster will be presented, and the participants will discuss the logistics and processes required to resolve the disaster. Which of the following would BEST describe this exercise?

A) Capacity planning
B) Business impact analysis
C) Continuity of operations
D) Tabletop exercise

**Answer: D**

**Domain:** 3.0 - Security Architecture

**Explanation:** A [[Tabletop Exercise]] allows disaster recovery teams to discuss and plan response procedures in a low-cost, discussion-based format without executing full-scale drills. [[Capacity Planning]] determines resource requirements. [[Business Impact Analysis]] quantifies impact during planning phases. [[Continuity of Operations]] provides backup operational procedures.

---

**END OF CHUNK: A37–A48 ✓**

# VIRGIL: Security+ SY0-701 Study Guide
## Practice Exam A – Questions A49–A60

---

### A49. A security administrator needs to block users from visiting websites hosting malicious software.

A) Honeynet
B) Data masking
C) DNS filtering
D) Data loss prevention

**Answer: C**

**Domain:** 4.5 - Web Filtering

**Explanation:** [[DNS filtering]] uses a database of known malicious websites to resolve an incorrect or null IP address, preventing users from accessing them. A honeynet is a decoy network for attracting attackers, not blocking traffic. [[Data masking]] hides data through substitution and encryption but doesn't block network access. [[DLP]] identifies and blocks private information transfer but doesn't prevent malware site access.

---

### A50. A system administrator has been called to a system with a malware infection and has imaged the operating system to a known-good version.

A) Lessons learned
B) Recovery
C) Detection
D) Containment

**Answer: B**

**Domain:** 4.8 - Incident Response

**Explanation:** The **recovery phase** involves returning systems and data to their pre-incident state, which often requires deleting all data and reinstalling a known-good operating system. Detection identifies the malware; containment isolates the system to prevent spread; lessons learned occurs in post-incident review.

---

### A51. A company has placed a SCADA system on a segmented network with limited access from the rest of the corporate network.

A) Load balancing
B) Least privilege
C) Data retention
D) Hardening

**Answer: D**

**Domain:** 4.1 - Hardening Targets

**Explanation:** [[Hardening]] for industrial SCADA systems includes network segmentation, additional [[Firewall]] controls, and access control lists. Load balancing distributes transactions across multiple systems. [[Least privilege]] defines minimum rights for specific tasks (not mentioned here). Data retention concerns long-term storage.

---

### A52. An administrator views a security log showing multiple failed password attempts for root from a single IP address over several seconds.

A) Spraying
B) Downgrade
C) Brute force
D) DDoS

**Answer: C**

**Domain:** 4.9 - Log data

**Explanation:** A [[brute force]] attack discovers passwords by attempting numerous combinations until a match is found. The log shows 400+ attempts from one IP. **Spraying** limits attempts to avoid alerts/lockouts. **Downgrade** forces insecure encryption. **DDoS** involves many devices causing outage (single IP observed here).

---

### A53. During morning login, a user's laptop was moved to a private VLAN and security updates were automatically installed.

A) Account lockout
B) Configuration enforcement
C) Decommissioning
D) Sideloading

**Answer: B**

**Domain:** 2.5 - Mitigation Techniques

**Explanation:** **Configuration enforcement** performs posture assessment at login to verify security controls. Non-compliant devices are quarantined and missing updates installed. Account lockout involves authentication failures. Decommissioning permanently removes devices. Sideloading installs software on mobile devices via third-party sources.

---

### A54. Which of the following describes two-factor authentication?

A) A printer uses a password and a PIN
B) The door to a building requires a fingerprint scan
C) An application requires a pseudo-random code
D) A Windows Domain requires a password and smart card

**Answer: D**

**Domain:** 4.6 - Multi-factor Authentication

**Explanation:** [[MFA|Two-factor authentication]] requires two different factors. Option D uses a password (something you know) and a smart card (something you have). Option A: password + PIN are both "something you know" (one factor). Option B: fingerprint is one biometric factor. Option C: pseudo-random code alone is one factor.

---

### A55. A company is deploying an application to field employees with device management, device variety, and corporate/personal use concerns.

A) CYOD
B) SSO
C) COPE
D) BYOD

**Answer: C**

**Domain:** 4.1 - Securing Wireless and Mobile

**Explanation:** **COPE** (Corporate-Owned, Personally Enabled) provides company-standardized devices that support both corporate and personal use with management capabilities. **CYOD** (Choose Your Own Device) allows user choice, increasing device variety. **SSO** (Single Sign-On) handles authentication across resources. **BYOD** (Bring Your Own Device) uses personal devices without standardization or management.

---

### A56. An organization is installing a UPS for their new data center.

A) Compensating
B) Directive
C) Deterrent
D) Detective

**Answer: A**

**Domain:** 1.1 - Security Controls

**Explanation:** A **compensating control** doesn't prevent an attack but restores from one. A UPS doesn't stop power outages but provides alternative power during them. Directive controls provide instructions/guidance. Deterrent controls discourage attacks. Detective controls identify intrusion attempts.

---

### A57. A manufacturing company would like to track the progress of parts used on an assembly line.

A) Secure enclave
B) Blockchain
C) Hashing
D) Asymmetric encryption

**Answer: B**

**Domain:** 1.4 - Blockchain Technology

**Explanation:** [[Blockchain]] ledger functionality tracks and verifies components, digital media, votes, and physical/digital objects. A secure enclave protects secret information in hardware. [[Hashing]] provides integrity verification but doesn't track components. [[Asymmetric encryption]] uses different encryption/decryption keys but doesn't enable tracking.

---

### A58. A company's website has been compromised and content replaced with a political message.

A) Insider
B) Organized crime
C) Shadow IT
D) Hacktivist

**Answer: D**

**Domain:** 2.1 - Threat Actors

**Explanation:** A **hacktivist** is motivated by philosophy/ideology and spreads messages through website defacement and document releases. Insiders have access but rarely post political content. Organized crime actors pursue money, not political messaging. Shadow IT groups build their own systems, not deface websites.

---

### A59. A Linux administrator downloading an ISO sees a SHA256 hash value on the download site.

A) Verifies that the file was not corrupted during the file transfer
B) Provides a key for decrypting the ISO after download
C) Authenticates the site as an official ISO distribution site
D) Confirms that the file does not contain any malware

**Answer: A**

**Domain:** 3.3 - Protecting Data

**Explanation:** After download, the administrator calculates the file's [[Hashing|SHA256 hash]] and compares it to the published value, confirming **data integrity** and ruling out corruption. Hash values don't decrypt files, authenticate sites, or detect [[Malware]]—they only verify file integrity.

---

### A60. A company requires login access only when physically within the same building as the server.

A) USB security key
B) Biometric scanner
C) PIN
D) SMS

**Answer: B**

**Domain:** 3.3 - Protecting Data

**Explanation:** A **biometric scanner** requires physical presence to authenticate. A USB security key can be stolen/used remotely. A [[PIN]] can be guessed or stolen. [[SMS]] messages can reach a mobile device remotely. Only biometrics guarantee physical co-location.

---

## Progress Summary
✅ **A49–A60 complete** | 12/12 questions processed | All domains identified | All explanations formatted with [[wiki links]]

# VIRGIL Study Guide: CompTIA Security+ SY0-701
## Practice Exam A, Questions A61–A72

---

### A61. A development team has installed a new application and database to a cloud service. After running a vulnerability scanner on the application instance, a security administrator finds the database is available for anyone to query without providing any authentication. Which of these vulnerabilities is MOST associated with this issue?

A) Legacy software
B) Open permissions
C) Race condition
D) Malicious update

**Answer: B**

**Domain:** 3.0 - Security Architecture

**Explanation:** [[Open permissions]] is the core vulnerability here. When cloud resources are deployed without proper [[IAM]] configuration and access controls, they can be exposed to the public internet. The scenario describes a misconfiguration issue—the database lacks [[authentication]] requirements entirely. **Legacy software** doesn't apply to new installations. **Race conditions** involve timing conflicts between processes, not public access. **Malicious updates** are unwanted software installations, not permission misconfiguration.

---

### A62. Employees of an organization have received an email with a link offering a cash bonus for completing an internal training course. Which of the following would BEST describe this email?

A) Watering hole attack
B) Cross-site scripting
C) Zero-day
D) Phishing campaign

**Answer: D**

**Domain:** 5.0 - Security Program Management and Oversight

**Explanation:** This describes a **[[Phishing campaign]]**—a controlled security awareness test by the IT department to evaluate employee security habits. The email uses social engineering (financial incentive) to trick users into clicking a malicious link. **Watering hole attacks** compromise legitimate websites users visit. **[[XSS]]** exploits browser trust in web applications, not email links. **[[Zero-day]]** exploits involve unknown vulnerabilities with no patch available—a link alone is not a zero-day attack.

---

### A63. Which of the following risk management strategies would include the purchase and installation of an NGFW?

A) Transfer
B) Mitigate
C) Accept
D) Avoid

**Answer: B**

**Domain:** 3.0 - Security Architecture

**Explanation:** **[[Mitigate|Mitigation]]** reduces risk by implementing security controls. Purchasing and installing an [[NGFW]] (Next-Generation Firewall) decreases threat exposure through additional protective layers. **Transfer** moves risk to a third party (e.g., insurance). **Accept** acknowledges risk and accepts consequences. **Avoid** stops participating in the risky activity entirely.

---

### A64. An organization is implementing a security model where all application requests must be validated at a policy enforcement point. Which of the following would BEST describe this model?

A) Public key infrastructure
B) Zero trust
C) Discretionary access control
D) Federation

**Answer: B**

**Domain:** 1.0 - General Security Concepts

**Explanation:** **[[Zero Trust]]** architecture mandates that nothing is inherently trusted—all access requests, regardless of source, must be verified at a central policy enforcement point. This continuous validation is a core Zero Trust principle. **[[PKI]]** manages asymmetric encryption and digital certificates. **[[Discretionary access control]]** (DAC) allows owners to determine access, but doesn't specify enforcement mechanisms. **Federation** manages authentication across third-party systems, not policy enforcement points.

---

### A65. A company is installing a new application in a public cloud. Which of the following determines the assignment of data security in this cloud infrastructure?

A) Playbook
B) Audit committee
C) Responsibility matrix
D) Right-to-audit clause

**Answer: C**

**Domain:** 3.0 - Security Architecture

**Explanation:** A **responsibility matrix** (or RACI matrix) is published by cloud providers to clarify which party owns security responsibilities for each service. In **IaaS**, the customer is responsible for OS and application security; in **SaaS**, the provider handles most security. A **playbook** documents response procedures. An **audit committee** oversees risk management. A **right-to-audit clause** is a contractual term allowing periodic audits, but doesn't determine security assignments.

---

### A66. When decommissioning a device, a company documents the type and size of storage drive, the amount of RAM, and any installed adapter cards. Which of the following describes this process?

A) Destruction
B) Sanitization
C) Certification
D) Enumeration

**Answer: D**

**Domain:** 4.0 - Security Operations

**Explanation:** **[[Enumeration]]** is the detailed inventory and listing of all hardware components in a device (CPU, memory, storage, adapters, etc.). This documentation is the first step in decommissioning. **Destruction** physically damages hardware to prevent reuse. **Sanitization** securely removes data (e.g., disk wiping) while preserving hardware. **Certification** is third-party documentation that destruction was completed.

---

### A67. An attacker has sent more information than expected in a single API call, and this has allowed the execution of arbitrary code. Which of the following would BEST describe this attack?

A) Buffer overflow
B) Replay attack
C) Cross-site scripting
D) DDoS

**Answer: A**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** A **[[buffer overflow]]** occurs when more data is written to a memory buffer than it can hold, overwriting adjacent memory and potentially executing arbitrary code. This is a classic code execution vulnerability. **Replay attacks** resend captured legitimate traffic, not oversized payloads. **[[XSS]]** exploits web browser trust, not API calls. **[[DDoS]]** creates unavailability through traffic flooding, not code execution.

---

### A68. A company encourages users to encrypt all of their confidential materials on a central server. The organization would like to enable key escrow as a backup option. Which of these keys should the organization place into escrow?

A) Private
B) CA
C) Session
D) Public

**Answer: A**

**Domain:** 1.0 - General Security Concepts

**Explanation:** **Private keys** must be escrowed for [[key escrow]] backup. In [[asymmetric encryption]], the private key decrypts data encrypted with the public key. If a user loses their private key, the organization's escrow copy allows data recovery. **CA keys** validate certificate authority signatures, not user data. **Session keys** are temporary and discarded after use—not suitable for long-term escrow. **Public keys** are already publicly available—no need to escrow them.

---

### A69. A company is in the process of configuring and enabling host-based firewalls on all user devices. Which of the following threats is the company addressing?

A) Default credentials
B) Vishing
C) Instant messaging
D) On-path

**Answer: C**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** **Instant messaging** is a common attack vector for delivering malicious links and malware. A **host-based firewall** (personal firewall) can block unauthorized inbound/outbound connections from IM clients. **Default credentials** involve [[authentication]] misconfigurations—firewalls don't detect weak passwords. **[[Vishing]]** (voice phishing) occurs over phone calls, outside firewall scope. **On-path attacks** intercept traffic silently; firewalls can't detect attacks the victim is unaware of.

---

### A70. A manufacturing company would like to use an existing router to separate a corporate network from a manufacturing floor. Both networks use the same physical switch, and the company does not want to install any additional hardware. Which of the following would be the BEST choice for this segmentation?

A) Connect the corporate network and the manufacturing floor with a VPN
B) Build an air gapped manufacturing floor network
C) Use host-based firewalls on each device
D) Create separate VLANs for the corporate network and the manufacturing floor

**Answer: D**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** **VLANs (Virtual Local Area Networks)** segment networks logically on a single physical switch—no additional hardware required. Traffic between VLANs is controlled by the router. A **[[VPN]]** encrypts traffic but doesn't segment networks and typically requires additional hardware. **Air-gapping** requires separate physical switches (additional hardware). **Host-based firewalls** protect individual devices but don't provide network-level segmentation.

---

### A71. An organization needs to provide a remote access solution for a newly deployed cloud-based application. This application is designed to be used by mobile field service technicians. Which of the following would be the best option for this requirement?

A) RTOS
B) CRL
C) Zero-trust
D) SASE

**Answer: D**

**Domain:** 3.0 - Security Architecture

**Explanation:** **[[SASE]]** (Secure Access Service Edge) is a next-generation [[VPN]] platform optimized for remote access to cloud applications. SASE combines network security and WAN capabilities for distributed, mobile users. **RTOS** (Real-Time Operating System) is for embedded systems, not remote access. **[[CRL]]** (Certificate Revocation List) checks certificate status, not remote connectivity. **[[Zero Trust]]** is a security strategy requiring verification, but doesn't provide remote access functions itself.

---

### A72. A company is implementing a quarterly security awareness campaign. Which of the following would MOST likely be part of this campaign?

A) Suspicious message reports from users
B) An itemized statement of work
C) An IaC configuration file
D) An acceptable use policy document

**Answer: A**

**Domain:** 5.0 - Security Program Management and Oversight

**Explanation:** Security awareness campaigns typically include **simulated [[Phishing]]** attacks and mechanisms for users to report suspicious messages to the IT security team. This builds employee vigilance and creates feedback loops. A **statement of work** is a service delivery document. **[[Infrastructure as Code]]** configuration files manage cloud infrastructure, not awareness programs. An **acceptable use policy (AUP)** defines proper technology use—it informs awareness training but isn't itself part of the campaign implementation.

---

## Summary Table

| Q | Answer | Domain | Key Concept |
|---|--------|--------|-------------|
| A61 | B | 3.0 | Open permissions; cloud misconfiguration |
| A62 | D | 5.0 | Phishing campaign; security awareness test |
| A63 | B | 3.0 | Mitigation; risk reduction via controls |
| A64 | B | 1.0 | Zero Trust; policy enforcement points |
| A65 | C | 3.0 | Cloud responsibility matrix; IaaS vs SaaS |
| A66 | D | 4.0 | Enumeration; hardware inventory |
| A67 | A | 2.0 | Buffer overflow; code execution |
| A68 | A | 1.0 | Key escrow; asymmetric encryption |
| A69 | C | 2.0 | Host-based firewall; IM threat vector |
| A70 | D | 2.0 | VLAN segmentation; no additional hardware |
| A71 | D | 3.0 | SASE; cloud remote access |
| A72 | A | 5.0 | Awareness campaign; phishing reports |

# VIRGIL: CompTIA Security+ SY0-701 Practice Exam A (Questions 73–84)

---

### A73. A recent report shows the return of a vulnerability that was previously patched four months ago.

A) Containerization
B) Data masking
C) 802.1X
D) Change management

**Answer: D**

**Domain:** 1.0 - Security and Risk Management

**Explanation:** [[Change Management]] includes a formal testing phase that identifies potential issues before patches or upgrades reach production. This prevents reintroduced vulnerabilities by validating changes before deployment. Containerization (A) doesn't address vulnerability management. Data masking (B) limits sensitive data visibility but doesn't prevent vulnerabilities. 802.1X (C) is network access control, unrelated to patching processes.

---

### A74. A security manager would like to ensure that unique hashes are used with an application login process.

A) Salting
B) Obfuscation
C) Key stretching
D) Digital signature

**Answer: A**

**Domain:** 1.0 - Security and Risk Management

**Explanation:** [[Salting]] adds random data to passwords before [[hashing]], ensuring identical passwords produce unique hashes across users. This prevents rainbow table attacks. Obfuscation (B) makes code unreadable but doesn't add randomness to hashes. Key stretching (C) applies cryptographic functions repeatedly for brute-force protection, not randomization. Digital signatures (D) provide integrity/authentication, not password storage mechanisms.

---

### A75. Which cryptographic method is used to add trust to a digital certificate?

A) Steganography
B) Hash
C) Symmetric encryption
D) Digital signature

**Answer: D**

**Domain:** 1.0 - Security and Risk Management

**Explanation:** A [[Certificate Authority]] uses a [[Digital Signature]] to cryptographically sign certificates, establishing third-party trust. If you trust the CA, you trust its signed certificates. Steganography (A) hides information, not trust establishment. Hash (B) verifies integrity but lacks third-party trust validation. Symmetric encryption (C) provides confidentiality, not certificate authentication.

---

### A76. A company is using SCAP as part of their security monitoring processes.

A) Train the user community to better identify phishing attempts
B) Present the results of an internal audit to the board
C) Automate the validation and patching of security issues
D) Identify and document authorized data center visitors

**Answer: C**

**Domain:** 4.0 - Security Operations

**Explanation:** [[SCAP]] (Security Content Automation Protocol) standardizes vulnerability management and enables automated validation/patching across multiple security tools using consistent security criteria. User awareness training (A) is separate from SCAP. Audit presentations (B) don't require SCAP. Visitor documentation (D) is a physical security policy unrelated to SCAP automation.

---

### A77. An organization maintains a large database of customer information for sales tracking and customer support.

A) Data processor
B) Data owner
C) Data subject
D) Data custodian

**Answer: D**

**Domain:** 5.0 - Governance, Risk, and Compliance

**Explanation:** The [[Data Custodian]] manages access rights and implements security controls protecting data. The data processor (A) handles operational use without permission management. The data owner (B) makes high-level business decisions. Data subjects (C) are the individuals whose data is collected—they don't manage access.

---

### A78. An organization's content management system currently labels files and documents as "Public" and "Restricted."

A) Minimized attack surface
B) Simplified categorization
C) Expanded privacy compliance
D) Decreased search time

**Answer: C**

**Domain:** 3.0 - Security Architecture and Engineering

**Explanation:** Adding a "Private" [[Data Classification]] label typically addresses expanded compliance requirements (GDPR, HIPAA, PCI-DSS) distinguishing sensitive personal data from general restricted information. Attack surface (A) isn't affected by classification labels. Adding categories (B) complicates rather than simplifies. Search performance (D) isn't impacted by additional classifications.

---

### A79. A corporate security team would like to consolidate and protect the private keys across all of their web servers.

A) Integrate an HSM
B) Implement full disk encryption on the web servers
C) Use a TPM
D) Upgrade the web servers to use a UEFI BIOS

**Answer: A**

**Domain:** 1.0 - Security and Risk Management

**Explanation:** An [[HSM]] (Hardware Security Module) is a dedicated cryptographic appliance that centrally stores and manages private keys/certificates for multiple devices with high security. Full-disk encryption (B) protects only individual servers without consolidation. [[TPM]] (C) operates on individual devices, not centralized. UEFI BIOS (D) is firmware unrelated to key management.

---

### A80. A security technician is reviewing this security log from an IPS.

A) The alert was generated from a malformed User Agent header
B) The alert was generated from an embedded script
C) The attacker's IP address is 222.43.112.74
D) The attacker's IP address is 64.235.145.35
E) The alert was generated due to an invalid client port number

**Answer: B, C**

**Domain:** 4.0 - Security Operations

**Explanation:** The [[IPS]] alert details show `<script>alert(2)</script>` embedded in JSON data, confirming an [[XSS]] attack (B). The flow notation "222.43.112.74:3332 -> 64.235.145.35:80" indicates the source (attacker) is 222.43.112.74 (C). User Agent (A) is metadata only, not the alert cause. The victim's IP is 64.235.145.35 (D incorrect). Port 3332 (E) is valid and unrelated to the alert.

---

### A81. Which of the following describes a monetary loss if one event occurs?

A) ALE
B) SLE
C) RTO
D) ARO

**Answer: B**

**Domain:** 5.0 - Governance, Risk, and Compliance

**Explanation:** [[SLE]] (Single Loss Expectancy) = Asset Value × Exposure Factor; it quantifies financial impact from one security incident. [[ALE]] (A) annualizes SLE across 12 months. [[RTO]] (C) defines recovery time windows, not monetary loss. [[ARO]] (D) counts annual occurrence frequency, not loss amount.

---

### A82. A user with restricted access has typed this text in a search field: USER77' OR '1'='1

A) Cross-site scripting
B) Buffer overflow
C) SQL injection
D) SSL stripping

**Answer: C**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** The syntax `' OR '1'='1` is a classic [[SQL Injection]] payload exploiting poor input validation to bypass authentication/authorization and query the database directly. [[XSS]] (A) exploits third-party trust, not input validation. Buffer overflow (B) overflows memory, not SQL query logic. [[SSL Stripping]] (D) downgrades encrypted connections, unrelated to this attack.

---

### A83. A user has opened a helpdesk ticket complaining of poor system performance, excessive pop up messages, and the cursor moving without anyone touching the mouse.

A) On-path
B) Worm
C) Trojan horse
D) Logic bomb

**Answer: C**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** A [[Trojan Horse]] disguises itself as legitimate software (vendor spreadsheet) and executes hidden code post-installation, giving attackers system control—causing performance degradation, popups, and unexpected cursor movement. On-path (A) intercepts communications silently. Worm (B) self-replicates without user action. Logic bomb (D) lies dormant until triggered, usually causing data destruction—not interactive symptoms.

---

### A84. A web-based manufacturing company processes monthly charges to credit card information saved in the customer's profile.

A) Chain of custody
B) Password vaulting
C) Compliance reporting
D) Sandboxing

**Answer: C**

**Domain:** 5.0 - Governance, Risk, and Compliance

**Explanation:** Storing sensitive payment card data requires encryption and [[MFA]] to satisfy regulatory requirements (PCI-DSS, GDPR), necessitating security control documentation for [[Compliance Reporting]]. Chain of custody (A) applies to evidence integrity, not customer data protection. Password vaulting (B) secures credentials, not customer profiles. Sandboxing (D) isolates testing environments, not production payment systems.

# VIRGIL: CompTIA Security+ SY0-701 Study Guide
## Practice Exam A — Questions A85–A90

---

### A85. A security manager has created a report showing intermittent network communication from certain workstations on the internal network to one external IP address.

A) On-path attack
B) Keylogger
C) Replay attack
D) Brute force

**Answer: B**

**Domain:** 2.0 - Threats, Vulnerabilities, and Mitigations

**Explanation:** A [[Keylogger]] is malware that captures keystrokes and periodically transmits captured data to an attacker's external server. The random, intermittent traffic pattern described matches typical [[Keylogger]] exfiltration behavior. An [[On-path attack]] requires active monitoring between two parties (no evidence here). A [[Replay attack]] reuses captured credentials for authentication and doesn't match this traffic pattern. A [[Brute force]] attack generates sustained, repetitive login attempts, not sporadic external communications.

---

### A86. The security policies in a manufacturing company prohibit the transmission of customer information, however a security administrator has received an alert that credit card numbers were transmitted as an email attachment.

A) IPS
B) DLP
C) RADIUS
D) IPsec

**Answer: B**

**Domain:** 4.0 - Security Operations

**Explanation:** [[DLP]] (Data Loss Prevention) is specifically designed to identify, monitor, and block transmission of sensitive data such as credit card numbers and [[PII]] across networks and email systems. An [[IPS]] (Intrusion Prevention System) focuses on detecting known attack signatures and exploits, not data content. [[RADIUS]] is an authentication protocol and has no data inspection capabilities. [[IPsec]] provides encryption and authentication but does not inspect payload content for sensitive information.

---

### A87. A security administrator has configured a virtual machine in a screened subnet with a guest login account and no password.

A) The server is a honeypot for attracting potential attackers
B) The server is a cloud storage service for remote users
C) The server will be used as a VPN concentrator
D) The server is a development sandbox for third-party programming projects

**Answer: A**

**Domain:** 1.0 - General Security Concepts

**Explanation:** A [[Honeypot]] is an intentionally vulnerable decoy system placed in a [[Screened subnet]] (DMZ) to attract and monitor attacker activity. An easily compromised guest account with no password is a classic honeypot design to lure potential adversaries. Cloud storage, [[VPN]] concentrators, and development sandboxes all require secure configurations with proper authentication and would never use open guest access as a best practice.

---

### A88. A security administrator is configuring a DNS server with a SPF record.

A) Transmit all outgoing email over an encrypted tunnel
B) List all servers authorized to send emails
C) Digitally sign all outgoing email messages
D) Obtain disposition instructions for emails marked as spam

**Answer: B**

**Domain:** 4.0 - Security Operations

**Explanation:** [[SPF]] (Sender Policy Framework) is a [[DNS]] record that publishes a list of authorized mail servers permitted to send emails for a specific domain, preventing email spoofing. Encrypted email transmission is configured on the mail server itself, not [[DNS]]. [[DKIM]] (Domain Keys Identified Mail) handles digital signatures of email messages using public key cryptography. [[DMARC]] (Domain-based Message Authentication, Reporting, and Conformance) provides disposition instructions for failed authentication (reject, quarantine, or accept).

---

### A89. A company would like to securely deploy applications without the overhead of installing a virtual machine for each system.

A) Containerization
B) IoT
C) Proxy
D) RTOS

**Answer: A**

**Domain:** 3.0 - Security Architecture

**Explanation:** [[Containerization]] enables multiple isolated application instances to run on a single lightweight container engine, eliminating the resource overhead of full virtual machines. Each container includes only the application and its dependencies, providing isolation without hypervisor overhead. [[IoT]] refers to embedded devices and is unrelated to application deployment. [[Proxy]] devices provide network filtering and caching, not application deployment. [[RTOS]] (Real-Time Operating System) is designed for time-sensitive industrial and embedded applications, not general application deployment.

---

### A90. A company has just purchased a new application server in a test environment, and the security director wants to determine if any part of the system can be exploited.

A) Tabletop exercise
B) Vulnerability scanner
C) DDoS
D) Penetration test

**Answer: D**

**Domain:** 4.0 - Security Operations

**Explanation:** A [[Penetration test]] actively exploits vulnerabilities to determine if systems can be compromised, providing the most comprehensive assessment of exploitability. This is the best practice approach in non-production environments. A tabletop exercise is a discussion-based training activity, not a technical assessment. A [[Vulnerability scanner]] passively identifies weaknesses but does not attempt active exploitation. A [[DDoS]] attack is malicious and does not provide vulnerability assessment information.

---

**END OF PRACTICE EXAM A CHUNK 8/8**

---
_Ingested: 2026-04-16 20:38 | Source: professor-messer-sy0-701-comptia-security-plus-practice-exams-v18.pdf_
