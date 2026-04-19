---
domain: "identity and access management"
tags: [authentication, biometrics, iam, access-control, security-plus, mfa]
---
# Biometric Authentication

**Biometric authentication** is the process of verifying an individual's identity by measuring and analyzing unique physical or behavioral characteristics, such as fingerprints, iris patterns, or voice. It belongs to the **"something you are"** factor of [[multi-factor authentication]] and is widely deployed in modern [[access control]] systems ranging from smartphone unlock mechanisms to border control infrastructure. Unlike passwords or tokens, biometric traits are inherently linked to the individual and cannot be forgotten or easily transferred.

---

## Overview

Biometric authentication emerged from forensic science — fingerprint identification has been used in criminal investigations since the late 19th century — but its integration into everyday authentication systems accelerated dramatically in the 2000s with the miniaturization of sensors and advances in machine learning. The core premise is that certain human characteristics are unique enough and stable enough over time to serve as reliable identifiers. Modern biometric systems leverage both physiological traits (fingerprints, retina, face geometry, hand geometry, vein patterns, DNA) and behavioral traits (gait analysis, keystroke dynamics, voice patterns, signature dynamics).

The deployment context matters significantly. A smartphone fingerprint reader operates as a **local match on device (LMOD)** system — the biometric template is stored in a secure enclave on the device itself (Apple's Secure Enclave or Android's Trusted Execution Environment), and comparison happens locally without transmitting raw biometric data. Enterprise or government systems may use centralized biometric databases where templates are stored server-side, introducing different threat models. The distinction between local and centralized storage is critical from a privacy and security perspective.

Biometric systems are evaluated on several performance metrics: **False Acceptance Rate (FAR)** measures how often an unauthorized user is incorrectly accepted; **False Rejection Rate (FRR)** measures how often a legitimate user is incorrectly rejected. These two metrics are inversely related — tuning a system to be more permissive reduces FRR but increases FAR, and vice versa. The **Crossover Error Rate (CER)**, also called Equal Error Rate (EER), is the point at which FAR equals FRR and serves as the primary benchmark for comparing the accuracy of different biometric systems. A lower CER indicates a more accurate system.

Regulatory and legal considerations heavily shape biometric deployments. Illinois's **Biometric Information Privacy Act (BIPA)** requires informed consent before collecting biometric identifiers and mandates data retention schedules and destruction policies. The EU's **GDPR** classifies biometric data as a "special category" of personal data requiring explicit consent and heightened protection. Organizations deploying biometric systems must account for these obligations, including breach notification requirements.

Biometrics are most powerful not as standalone authentication but as part of multi-factor schemes. Combining a fingerprint scan with a PIN or hardware token creates layered defense — if a latent fingerprint is lifted and replicated, the attacker still needs the second factor. This is why modern standards such as **FIDO2/WebAuthn** are designed to use on-device biometrics as the verification step for a cryptographic credential, rather than transmitting raw biometric data over a network.

---

## How It Works

Biometric authentication follows a consistent pipeline regardless of the modality used. Understanding each phase is essential for security analysis.

### Phase 1: Enrollment

During enrollment, the system captures a raw biometric sample (e.g., scans a fingerprint three times to account for placement variation). A **feature extraction algorithm** processes the raw image or signal into a mathematical representation called a **biometric template**. For fingerprints, this involves identifying minutiae points — ridge endings and bifurcations — and encoding their positions and orientations into a feature vector. The raw image is typically discarded; only the template is stored.

```
Raw Sample → Preprocessing → Feature Extraction → Template → Secure Storage
   (image)     (normalize,      (minutiae,             (encrypted,
               filter noise)     geometry)              hashed, or
                                                        in TEE)
```

### Phase 2: Authentication (Verification vs. Identification)

**Verification (1:1 matching):** The user claims an identity (e.g., presents a smart card or enters a username), and the system compares the live sample against *that specific user's* stored template. Used in most consumer and enterprise scenarios. Fast, low computational overhead.

**Identification (1:N matching):** The system compares the live sample against *all* stored templates in a database to determine who the person is. Used in law enforcement, airport watchlists, and border control. Computationally expensive and subject to higher false acceptance rates as N grows.

### Phase 3: Matching and Decision

The matching algorithm produces a **similarity score** between the live sample and the stored template. This score is compared against a configurable **threshold**:

- Score ≥ Threshold → **Accept**
- Score < Threshold → **Reject**

For fingerprints, algorithms like SourceAFIS (open source) compute minutiae correspondence. For face recognition, deep convolutional neural networks (CNNs) like FaceNet produce 128-dimensional embedding vectors; cosine similarity or Euclidean distance between vectors determines match confidence.

### Fingerprint Authentication — Technical Detail

Modern capacitive fingerprint sensors (used in most laptops and Android phones) work by detecting electrical differences between the ridges (which contact the sensor) and valleys (which do not). The sensor grid produces a 2D differential map which is processed into a grayscale image.

```
Sensor Grid Output (500 dpi typical)
      ↓
Image Enhancement (Gabor filter for ridge orientation)
      ↓
Binarization (ridge = 1, valley = 0)
      ↓
Thinning (skeletonize ridges to 1-pixel width)
      ↓
Minutiae Extraction (endpoints, bifurcations with x,y,θ)
      ↓
Template (typically 400–1000 minutiae descriptors)
```

### Face Recognition Pipeline

```
Camera Input (visible light, near-IR, or structured light)
      ↓
Face Detection (MTCNN, Viola-Jones, or RetinaFace)
      ↓
Alignment (align to canonical face coordinates using landmarks)
      ↓
Feature Extraction (CNN → 128-512 dimensional embedding)
      ↓
Similarity Matching (cosine similarity against stored embedding)
      ↓
Threshold Decision
```

Apple Face ID uses a **structured light projector** that casts 30,000 invisible IR dots onto the face to create a 3D depth map, making it resistant to photograph-based spoofing.

### Iris Recognition Pipeline

Iris recognition (Daugman's algorithm, the basis for most deployed systems) uses:
1. Near-infrared illumination to reveal iris texture regardless of melanin level
2. Segmentation to isolate the iris from pupil and sclera
3. Normalization to unwrap the iris into a rectangular strip
4. 2D Gabor wavelet filtering to produce a 2048-bit **IrisCode**
5. Hamming distance comparison between two IrisCodes (< 0.32 = match)

### FIDO2 Biometric Integration

In the FIDO2/WebAuthn framework, the biometric never leaves the device:

```
1. Server sends challenge nonce
2. Authenticator (device) prompts for biometric
3. Local biometric match in TEE/Secure Enclave
4. If match: private key signs the challenge
5. Signed assertion sent to server
6. Server verifies signature with stored public key
```

No biometric data is transmitted. The network only sees a cryptographic signature.

---

## Key Concepts

- **False Acceptance Rate (FAR):** The probability that the system incorrectly accepts an unauthorized user. A FAR of 0.001% means 1 in 100,000 unauthorized attempts succeeds. Critical for high-security applications.

- **False Rejection Rate (FRR):** The probability that the system incorrectly rejects a legitimate user. High FRR causes user frustration and workarounds (users propping open doors, sharing credentials). Must be balanced against FAR.

- **Crossover Error Rate (CER) / Equal Error Rate (EER):** The threshold setting at which FAR = FRR. Used as a single-number performance benchmark. Lower CER = better system. Fingerprint scanners typically achieve CER of 0.1–1%; iris scanners achieve ~0.0001%.

- **Biometric Template:** A mathematical representation of extracted features stored for comparison. Not a stored image in most systems. Templates are one-way in concept — you cannot reconstruct the original biometric from a well-designed template — but this is not guaranteed.

- **Liveness Detection (Anti-Spoofing):** Mechanisms to distinguish a live human from a spoofing artifact (photo, silicone fingerprint, recording). Techniques include 3D depth sensing (Face ID), pulse detection via photoplethysmography, challenge-response blink detection, or sweat pore analysis in fingerprints.

- **Cancelable Biometrics:** A technique where a transformed (distorted) version of the biometric template is stored rather than the original. If the template is compromised, a new transformation can be applied, creating a fresh template — mimicking password reset semantics for biometrics.

- **Multimodal Biometrics:** Combining two or more biometric modalities (e.g., fingerprint + iris) to increase accuracy and resistance to spoofing, at the cost of increased enrollment complexity.

- **Behavioral Biometrics:** Continuous authentication through ongoing analysis of behavioral patterns such as typing rhythm, mouse movement, gait, or touchscreen interaction. Used for risk-based authentication and fraud detection rather than point-in-time authentication.

---

## Exam Relevance

**SY0-701 Domain Mapping:** Biometric authentication appears primarily in **Domain 4.0 – Security Operations** (specifically 4.6, authentication and authorization) and **Domain 1.0 – General Security Concepts** (1.2, authentication factors).

**Key Exam Points:**

- Biometrics = **"something you are"** — the third authentication factor. Distinguish from "something you know" (password/PIN) and "something you have" (token/smart card).
- **CER/EER is the primary accuracy metric** — questions may ask which metric is used to compare biometric systems. The answer is CER or EER, not FAR or FRR alone.
- **Lower CER = more accurate system.** If a question asks which fingerprint scanner is more accurate and gives CER values, pick the lower number.
- FAR relates to **security** (too high = unauthorized access); FRR relates to **availability** (too high = users locked out). Organizations must balance based on their security requirements.
- **Iris recognition has the lowest CER** of commonly deployed modalities — often cited in exam questions comparing biometric types.
- Biometrics **cannot be revoked or changed** if compromised (a critical weakness). This is a common exam gotcha — unlike passwords, you can't issue a new fingerprint.
- In MFA contexts, biometrics are strongest when combined with another factor. Biometrics alone do not constitute MFA.
- The **FIDO2/WebAuthn** standard is increasingly exam-relevant — know that it uses on-device biometrics to unlock private keys without transmitting biometric data.

**Common Question Pattern:**
> "A user's fingerprint template is stolen from a database. Which of the following is the GREATEST concern?" → The correct answer relates to the fact that **biometrics cannot be changed**, unlike a compromised password.

---

## Security Implications

### Spoofing and Presentation Attacks

The most widely demonstrated attack class. Researchers have successfully spoofed:
- **Fingerprint sensors** using gelatin, silicone, or even printed inkjet circuits overlaid on a finger. A 2019 NYU/Michigan State study demonstrated that synthetic "MasterPrint" fingerprints could match ~65% of partial fingerprint datasets used by smartphone sensors.
- **Face recognition** using printed photographs (defeated by 2D systems without liveness detection), silicone masks, or adversarial makeup patterns. Researchers at the University of Toronto demonstrated that strategic face paint could defeat commercial face recognition.
- **Iris scanners** using printed iris photographs with a contact lens on top (demonstrated against Samsung Galaxy S8's iris scanner in 2017 by Chaos Computer Club).

### Template Database Breaches

If centrally stored templates are compromised, the damage is permanent — users cannot re-enroll with new biometrics. The **OPM breach (2015)** compromised fingerprint records of 5.6 million US federal employees and contractors. Unlike passwords, these credentials cannot be rotated. This event catalyzed significant policy changes around biometric data storage in government systems.

### Adversarial Machine Learning Attacks

Deep learning–based face recognition systems are vulnerable to **adversarial examples** — imperceptible perturbations to images that cause misclassification. Researchers have demonstrated physical-world attacks using adversarial eyeglass frames that cause face recognition to misidentify the wearer.

### Side-Channel Attacks on Secure Enclaves

While Apple's Secure Enclave and ARM TrustZone protect template storage from normal OS access, side-channel attacks exploiting cache timing, power analysis, or fault injection have been demonstrated against similar secure execution environments (e.g., CVE-2020-9839 affecting Apple's SEP, various TrustZone vulnerabilities catalogued by researchers at Graz University of Technology).

### Presentation Attack Detection (PAD) Evasion

Liveness detection algorithms have their own failure modes. In 2023, researchers demonstrated that generative AI–produced deepfake videos could defeat several commercial liveness detection systems used by banking KYC processes, prompting NIST to publish updated guidance under SP 800-76-2 and the ISO/IEC 30107 standard for PAD testing.

### Coercion and Compelled Use

Biometrics introduce a legal and physical coercion vector. Unlike a PIN (protected by Fifth Amendment in some US jurisdictions), courts have generally held that compelled fingerprint or face unlock does not constitute testimonial self-incrimination (see *United States v. Baust*, 2014). An attacker with physical access can force biometric authentication.

---

## Defensive Measures

### Liveness Detection Implementation

Deploy biometric sensors with certified Presentation Attack Detection. For face recognition, require **3D structured light** (e.g., Face ID–class sensors) rather than 2D camera-only systems. For fingerprint sensors, select capacitive sensors with sweat pore analysis or vein detection capabilities over optical sensors. Certify systems against **ISO/IEC 30107-3** PAD testing levels.

### Cancelable Biometrics and Template Protection

Store transformed templates rather than raw templates. Implement **Fuzzy Vault**, **Biometric Salting**, or **Homomorphic Encryption** schemes for template protection. Ensure templates are salted per-application so a breach of one template database cannot be cross-matched against another.

### Multi-Factor Architecture

Never rely on biometrics alone for privileged access. Combine with a hardware token ([[FIDO2]] security key, smart card) using **phishing-resistant MFA**. For high-assurance environments, implement biometrics + PIN + physical token (three factors).

### Privileged Access Policy

For administrative and privileged accounts, require biometric + hardware token regardless of the sensitivity threshold of the individual action. Define explicit policy in your **Identity and Access Management** framework that biometrics satisfy only one factor.

### Centralized Template Storage Controls

If centralized storage is required (enterprise or government), encrypt templates at rest using AES-256 with HSM-managed keys. Implement strict access controls (zero-trust network access to the biometric database, audit logging of all match queries). Consider **distributed template storage** where template fragments are split across multiple servers (no single server holds a complete template).

### Privacy-by-Design

Implement data minimization: collect only necessary biometric data, define retention periods, and automate deletion on employee/user offboarding. Conduct Privacy Impact Assessments before deployment. Ensure consent mechanisms are in place per BIPA/GDPR requirements.

### Monitoring and Anomaly Detection

Deploy behavioral analytics to detect unusual authentication patterns (e.g., successful biometric logins from geographically impossible locations, high-frequency authentication attempts suggesting automated attack). Integrate biometric system logs into your [[SIEM]] for correlation.

---

## Lab / Hands-On

### Lab 1: Fingerprint Matching with SourceAFIS (Python)

SourceAFIS is an open-source fingerprint recognition library. Use it to understand template creation and matching.

```bash
pip install sourceafis pillow
```

```python
from sourceafis import FingerprintMatcher, FingerprintTemplate
from PIL import Image
import numpy as np

# Load fingerprint images (grayscale, 500