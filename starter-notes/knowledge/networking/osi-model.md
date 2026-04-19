# OSI Model

The Open Systems Interconnection (OSI) model is a conceptual framework that standardizes the functions of a telecommunication or computing system into seven abstracted layers, enabling interoperability between different systems and protocols. It provides a universal language for describing network communication and is fundamental to understanding how data moves across networks.

## Overview

The OSI model was developed by the International Organization for Standardization (ISO) to standardize network communication. It divides the communication process into seven distinct layers, each with specific functions and responsibilities. This layered approach allows different protocols and technologies to work together seamlessly.

## The Seven Layers

### Layer 7: Application Layer
- End-user services and applications
- Examples: [[HTTP]], [[HTTPS]], [[FTP]], [[SMTP]], [[DNS]]
- User-facing protocols and services

### Layer 6: Presentation Layer
- Data formatting and encryption
- Translation between application and network formats
- Compression and encryption/decryption

### Layer 5: Session Layer
- Manages communication sessions
- Establishes, maintains, and terminates connections
- Dialog control and synchronization

### Layer 4: Transport Layer
- End-to-end communication and reliability
- Examples: [[TCP]], [[UDP]]
- Flow control and error handling

### Layer 3: Network Layer
- Routing and logical addressing
- Examples: [[IP]], [[ICMP]]
- Path determination and packet forwarding

### Layer 2: Data Link Layer
- Physical addressing (MAC addresses)
- Examples: [[Ethernet]], [[PPP]]
- Frame formatting and error detection

### Layer 1: Physical Layer
- Physical transmission media
- Examples: cables, fiber optics, radio waves
- Bit transmission and hardware specifications

## Importance for Security

Understanding the OSI model is critical for network security, as [[DDoS]] attacks and other threats operate at different layers. For example, [[Layer 7 DDoS attacks]] target application-level vulnerabilities, while [[Layer 3]] and [[Layer 4]] attacks focus on network infrastructure.

## Related Concepts

- [[TCP/IP model]] (practical implementation alternative)
- [[Network protocols]]
- [[DDoS attacks]]
- [[Network security]]

## Tags

#networking #osi-model #educational #fundamentals #cloudflare

---
_Ingested: 2026-04-15 20:22 | Source: https://www.cloudflare.com/learning/ddos/glossary/open-systems-interconnection-model-osi/_
