# ssh-brute

## What it is
Like a locksmith trying every key on a massive keyring until one clicks, ssh-brute is the automated process of systematically attempting username/password combinations against an SSH service (port 22) until valid credentials are found. It exploits the fact that SSH authentication, by design, allows multiple login attempts before closing a connection.

## Why it matters
In 2016, the Mirai botnet and its descendants routinely used SSH brute-force attacks against IoT devices using factory-default credentials (like `root:root` or `admin:admin`), compromising hundreds of thousands of devices to build massive DDoS infrastructure. Defenders respond by implementing fail2ban, account lockout policies, or replacing password authentication entirely with public-key authentication.

## Key facts
- **Default target:** TCP port 22; attackers also scan for SSH running on non-standard ports using tools like Nmap before launching brute-force attempts
- **Common tools:** Hydra, Medusa, and Metasploit's `ssh_login` auxiliary module are the standard brute-force utilities used in penetration tests and real attacks
- **Credential stuffing variant:** Attackers often use previously breached credential lists (from HaveIBeenPwned dumps) rather than pure dictionary attacks, dramatically increasing success rates
- **Detection signatures:** Multiple failed authentication attempts (Event ID 4625 on Windows; `/var/log/auth.log` entries on Linux) in rapid succession from a single IP are the primary IOC
- **Best defense:** Disabling password-based SSH authentication (`PasswordAuthentication no` in `sshd_config`) and requiring RSA/ED25519 key pairs renders brute-force attacks completely ineffective

## Related concepts
[[Credential Stuffing]] [[Fail2Ban]] [[SSH Public Key Authentication]] [[Dictionary Attack]] [[Hydra]]