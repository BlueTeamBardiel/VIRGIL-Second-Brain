---
domain: "identity-and-access-management"
tags: [password-manager, credential-security, encryption, zero-knowledge, mfa]
---
# 1Password

**1Password** is a commercial **password manager** developed by AgileBits Inc. that stores, generates, and auto-fills credentials using a [[Zero-Knowledge Architecture]] model where the provider cannot access user data. It uses a dual-key derivation system combining a user's **Master Password** with a randomly generated **Secret Key** to produce the encryption keys that protect the [[Encrypted Vault]] containing all stored credentials and sensitive items.

---

## Overview

1Password was founded in 2006 and has grown into one of the most widely deployed password management solutions for both individuals and enterprise organizations. Its core value proposition addresses the fundamental human failure mode in credential security: password reuse across multiple services. By providing a secure, centrally managed vault accessible across devices, 1Password enables users to maintain unique, complex, randomly generated passwords for every account without needing to memorize them — dramatically reducing exposure from [[Credential Stuffing]] attacks and data breach fallout.

The architecture is built around **end-to-end encryption**, meaning all encryption and decryption occurs locally on the client device. AgileBits servers store only ciphertext blobs — even if the company were breached or compelled by law enforcement, the encrypted data would be computationally useless without the user's Master Password and Secret Key. This is a meaningful security guarantee distinguishable from services that store a password hash and derive keys server-side, where server compromise could expose more attack surface.

1Password operates on a **Software-as-a-Service (SaaS)** model for its cloud-synced tiers, but also historically supported local Wi-Fi sync and integration with Dropbox or iCloud for users preferring to avoid cloud storage of their vault. As of the modern 1Password 8 era, the cloud-based 1Password.com account model is the primary offering, though the cryptographic protections remain client-enforced. For enterprises, 1Password Business and Teams editions add features including centralized vault management, access provisioning, activity audit logs, and SCIM-based [[LDAP]] / identity provider integration.

The tool has expanded far beyond simple password storage. Modern vault items include TOTP-based [[Multi-Factor Authentication]] seeds, SSH private keys with the 1Password SSH agent, passkeys, secure notes, software licenses, credit card data, and identity documents. The 1Password CLI (`op`) enables secrets injection into CI/CD pipelines, removing the need to store plaintext credentials in environment variables or configuration files — a significant security improvement for [[DevSecOps]] practices.

---

## How It Works

### Dual-Key Encryption Model

1Password's security is built on the **SRP (Secure Remote Password) Protocol** for authentication combined with a two-factor key derivation scheme. Understanding this is critical to assessing the tool's actual security posture.

**Key Components:**
- **Master Password**: User-chosen passphrase, never transmitted to AgileBits servers
- **Secret Key**: 128-bit random value, 26 characters in Base32 encoding (format: `A3-XXXXXX-XXXXXX-XXXXXX-XXXXXX-XXXXXX`), generated at account creation, stored only on trusted devices and the Emergency Kit PDF
- **Account Unlock Key (AUK)**: Derived by combining the Master Password and Secret Key

### Key Derivation Process

```
Master Password + Secret Key
          │
          ▼
   PBKDF2-HMAC-SHA256
   (100,000+ iterations)
          │
          ▼
   Account Unlock Key (AUK)
          │
          ▼
   Decrypts → Encrypted Keyset
          │
          ▼
   Vault Keys (per-vault symmetric keys)
          │
          ▼
   AES-256-GCM encrypted vault items
```

The derivation uses **PBKDF2** with a high iteration count to slow brute-force attempts on the Master Password. The Secret Key acts as a second entropy source: because it is 128 bits of random data, even a weak Master Password results in a combined key space of approximately 2^128, rendering offline dictionary attacks infeasible without the Secret Key.

### Vault Item Encryption

Each vault item (login, secure note, etc.) is encrypted with **AES-256-GCM** (Authenticated Encryption with Associated Data). The authentication tag in GCM mode detects any tampering with ciphertext, providing both confidentiality and integrity.

```json
{
  "uuid": "abc123xyz",
  "category": "LOGIN",
  "encryptedBy": "vault-key-uuid",
  "ciphertext": "<base64-encoded AES-256-GCM ciphertext>",
  "iv": "<12-byte GCM nonce>",
  "authTag": "<16-byte GCM authentication tag>"
}
```

### Browser Extension / Auto-Fill Flow

1. User navigates to `https://example.com`
2. Browser extension reads the page's domain and subdomain
3. Extension queries local 1Password helper process (communicates over a local Unix socket or named pipe — no network call for the query itself)
4. Matching vault items are presented; user selects or confirms
5. Credentials are injected into DOM form fields or clipboard (depending on user settings)
6. For TOTP seeds stored in 1Password, the TOTP algorithm (RFC 6238) runs locally and the current code is filled automatically

### 1Password CLI (`op`)

The `op` CLI tool enables programmatic vault access, critical for secrets management in automation:

```bash
# Install on Linux
curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
  gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg

# Sign in
op signin

# Get a specific field from a vault item
op item get "GitHub Token" --fields label=credential

# Inject secrets into a command as environment variables
op run --env-file=".env.tpl" -- node server.js

# Example .env.tpl file
DB_PASSWORD=op://Private/Database/password
API_KEY=op://DevTeam/APIService/api_key

# List all vault items
op item list --vault "Private"

# Create a new login item
op item create \
  --category=login \
  --title="My Service" \
  --url="https://myservice.example.com" \
  username[text]=admin \
  password[password]=SuperSecretPass1!
```

### SSH Agent Integration

1Password 8 includes a built-in SSH agent. SSH private keys stored in the vault are exposed through a local socket, never written to disk unencrypted:

```bash
# Add to ~/.ssh/config or shell profile
export SSH_AUTH_SOCK=~/.1password/agent.sock

# Keys stored in 1Password appear to ssh-add -l
ssh-add -l
# Output: 256 SHA256:XXXX 1Password:MyServer (ED25519)
```

### Sync and Cloud Storage

Encrypted vault blobs are synced via HTTPS (TLS 1.2+) to 1Password's servers. The server receives and stores only ciphertext. The server-side authentication uses the SRP protocol, meaning the server never sees the user's password — it authenticates through a mathematical proof of knowledge.

---

## Key Concepts

- **Secret Key**: A 128-bit randomly generated value combined with the Master Password during key derivation; stored on the Emergency Kit and trusted devices only — loss of both Secret Key and Master Password results in permanent, irrecoverable vault lockout.
- **Zero-Knowledge Architecture**: A design principle where the service provider cryptographically cannot access user data; AgileBits stores only AES-256-GCM ciphertext that is mathematically decryptable only by the client possessing the correct Master Password and Secret Key.
- **Vault**: A logical container for related credential items, encrypted with its own symmetric vault key; multiple vaults can exist per account (e.g., Personal, Work, Shared Team), each with independent access controls.
- **Watchtower**: 1Password's integrated threat intelligence feature that checks stored credentials against the [[Have I Been Pwned (HIBP)]] breached password database using k-anonymity (sending only a 5-character SHA-1 hash prefix, never the actual password), and flags weak, reused, or compromised passwords.
- **Emergency Kit**: A PDF generated at account creation containing the account email, Secret Key, and a space to write the Master Password; the only backup mechanism for account recovery — must be stored securely offline (printed and locked, or encrypted offline backup).
- **Travel Mode**: An enterprise feature allowing administrators or users to temporarily remove selected vaults from devices before crossing borders or entering high-risk environments; vaults are hidden and inaccessible even under device inspection or coercion, and can be restored remotely after.
- **SCIM Bridge**: A deployable service enabling enterprise identity providers (Okta, Azure AD, Google Workspace) to provision and deprovision 1Password accounts automatically via the [[SCIM]] (System for Cross-domain Identity Management) protocol.

---

## Security Implications

### Attack Vectors

**Memory Scraping**: The decrypted vault key and plaintext credentials briefly exist in process memory on the client device. A local attacker with sufficient privileges (or malware) could attempt to dump the 1Password process memory to extract secrets. This is a risk shared by all password managers and is mitigated by OS-level process isolation and memory encryption features (e.g., Windows DPAPI, macOS Secure Enclave for biometric unlock).

**Master Password Brute-Force (Offline)**: If an attacker obtains the encrypted vault blob AND the user's Secret Key (e.g., from a stolen Emergency Kit combined with a compromised device backup), they could attempt offline brute-force of the Master Password. PBKDF2 with 100,000+ iterations slows this significantly, but a weak Master Password remains the weakest link. Without the Secret Key, even the encrypted vault blob is resistant to attack due to the 2^128 key space floor.

**Phishing the Master Password**: Attackers may create fake 1Password login pages or malicious browser extensions to capture the Master Password at entry time. The 1Password browser extension includes anti-phishing protections and domain matching but cannot prevent all social engineering scenarios.

**Supply Chain / Extension Compromise**: A compromised 1Password browser extension update could silently exfiltrate credentials. AgileBits mitigates this through signed releases and reproducible builds, but it remains a theoretical trust boundary.

**Real Incidents and CVEs:**

- **2023 — Okta Breach Lateral Movement**: The widely reported Okta support system breach in October 2023 resulted in AgileBits detecting suspicious activity on their Okta tenant. 1Password confirmed that their system was accessed by an attacker who leveraged the Okta breach but stated no user data or vaults were accessed. The incident highlighted the risk of identity provider compromise cascading to dependent services. AgileBits published a detailed incident report and terminated the malicious session within minutes of detection.
- **CVE-2023-34062** (Bitwarden reference, illustrative of class): While no critical RCE CVEs have been publicly assigned specifically to 1Password's core encryption engine, the broader password manager category has seen vulnerabilities in browser extension injection logic, clipboard handling timing attacks, and autofill domain-matching bypasses. Security researchers have demonstrated that 1Password's autofill could historically be tricked by specially crafted iframe structures — AgileBits addressed such issues through the responsible disclosure process.
- **2019 — 1Password 7 macOS Keychain Storage**: A security researcher demonstrated that 1Password 7 for macOS stored the Master Password and Secret Key in the macOS Keychain in plaintext under certain configurations. AgileBits disputed the severity but updated documentation and settings. This illustrates the importance of reviewing where local credential caching occurs.

---

## Defensive Measures

### For Individual Users

1. **Use a strong, unique Master Password**: Minimum 16 characters; a diceware passphrase (5+ words) is ideal for memorability and entropy. Never reuse this password anywhere else.

2. **Store the Emergency Kit securely offline**: Print it, store in a fireproof safe or safety deposit box. Do not store it digitally in unencrypted form.

3. **Enable Two-Factor Authentication on your 1Password.com account**: Adding TOTP or a hardware security key (FIDO2/WebAuthn via [[YubiKey]]) to the account login adds a layer that prevents account access even if credentials are phished — though this protects account management, not vault decryption directly.

4. **Audit with Watchtower regularly**: Review flagged weak, reused, or breached passwords on a monthly cadence. Prioritize remediating accounts flagged as breached.

5. **Restrict trusted devices**: Periodically review and revoke authorized devices in account settings, especially for devices that are lost, sold, or decommissioned.

6. **Enable the lock timer**: Configure 1Password to lock after a short idle period (1–5 minutes) and require biometric or Master Password re-entry, reducing window of exposure from unattended sessions.

### For Enterprise Deployments

```yaml
# Example 1Password SCIM Bridge docker-compose snippet
version: '3.8'
services:
  op-scim-bridge:
    image: 1password/scim:v2.9.0
    environment:
      - OP_SESSION=/secrets/scimsession
      - OP_REDIS_URL=redis://redis:6379
    ports:
      - "3002:3002"
    volumes:
      - ./secrets:/secrets:ro
  redis:
    image: redis:7-alpine
```

- **Enforce MFA for all team members** via the 1Password Teams/Business admin console under *Security → Two-Factor Authentication*.
- **Implement least-privilege vault access**: Create separate vaults per team/function; assign members only to vaults relevant to their role. Use groups to manage access at scale.
- **Enable and monitor Activity Log**: 1Password Business provides an audit log of all vault access, item views, and administrative changes. Forward these logs to a [[SIEM]] (e.g., Splunk, Elastic) via the 1Password Events API.
- **Use the SCIM Bridge for automated lifecycle management**: Ensure employee offboarding immediately deprovisions 1Password access, eliminating orphaned accounts.
- **Rotate the SCIM bridge credentials** and service account tokens on a scheduled basis (90-day maximum recommended).
- **Deploy 1Password for SSH** on developer workstations to eliminate unencrypted private keys on disk.

---

## Lab / Hands-On

### Lab 1: Setting Up 1Password CLI in a Homelab

This exercise demonstrates injecting secrets into a homelab automation script without hardcoding credentials.

```bash
# Install op CLI on Ubuntu/Debian
curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
  sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] \
  https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" | \
  sudo tee /etc/apt/sources.list.d/1password.list

sudo apt update && sudo apt install 1password-cli

# Verify installation
op --version

# Sign in to your 1Password account
eval $(op signin)

# Create a vault item for a homelab service
op item create \
  --category=login \
  --title="Proxmox Admin" \
  --url="https://YOUR-HOMELAB-IP:8006" \
  username[text]=root \
  password[password]=$(openssl rand -base64 32)

# Retrieve the generated password
op item get "Proxmox Admin" --fields password
```

### Lab 2: Secrets Injection in an Ansible Playbook

```bash
# Create a .env.tpl file for op run
cat > secrets.env.tpl << 'EOF'
PROXMOX_PASSWORD=op://Homelab/Proxmox Admin/password
GRAFANA_API_KEY=op://Homelab/Grafana/credential
SMTP_PASSWORD=op://Homelab/Email Relay/password
EOF

# Run Ansible with injected secrets (never written to disk)
op run --env-file=secrets.env.tpl -- \
  ansible-playbook -i inventory.yml site.yml \
  -e "proxmox_pass=$PROXMOX_PASSWORD"
```

### Lab 3