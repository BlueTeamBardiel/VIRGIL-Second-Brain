# SCEP

## What it is
Think of SCEP like a vending machine for digital certificates — a device inserts a request, proves it has the right code, and receives a certificate without human intervention. Simple Certificate Enrollment Protocol (SCEP) is a protocol that automates the process of requesting and issuing X.509 digital certificates from a Certificate Authority (CA), originally designed by Cisco for network device enrollment. It uses HTTP and PKCS standards to allow devices to self-enroll without requiring manual administrator intervention.

## Why it matters
In enterprise MDM (Mobile Device Management) environments, SCEP is used to automatically provision certificates to mobile devices so they can authenticate to corporate Wi-Fi or VPNs. An attacker who can intercept or spoof a SCEP enrollment transaction — particularly in older implementations lacking proper challenge password validation — could potentially enroll a rogue device and receive a legitimate certificate, granting it trusted network access. This is why challenge password strength and CA validation controls are critical SCEP hardening steps.

## Key facts
- SCEP operates over **HTTP (port 80)** by default, meaning traffic is unencrypted unless wrapped in HTTPS — a notable weakness in older deployments
- Uses a **challenge password** as the pre-shared secret to authorize certificate requests, which must be kept confidential
- Originally a Cisco/VeriSign draft standard; never formalized as an official IETF RFC until **RFC 8894 (2020)**
- SCEP is widely used by **MDM solutions** (Intune, Jamf) to distribute client authentication certificates to endpoints automatically
- Supports only **RSA** key pairs in its original design; newer implementations (NDES in Windows) extend functionality but inherit complexity and attack surface

## Related concepts
[[PKI]] [[X.509 Certificates]] [[NDES]] [[MDM Security]] [[Certificate Authority]]