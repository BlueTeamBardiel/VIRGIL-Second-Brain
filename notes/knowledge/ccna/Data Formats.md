# Data Formats
**Tagline:** Master JSON, XML, and YAML—the languages that let network apps understand each other.

---

## 24.1 Data Serialization Fundamentals

### What is Data Serialization?

**Simple explanation:** Imagine App A (Python), App B (Ruby), and App C (Java) all store the same network interface data—but each in their own language's internal memory format. Without a common language, they can't understand each other's data. Data serialization is the translator.

**Technical definition:** Data serialization converts application data structures from memory into a standardized, transmittable format (a series of bytes) that can be stored or transmitted across networks, then reconstructed by any other application that understands that format.

### Why It Matters for CCNA

- **Network automation depends on it.** [[APIs]] open data access, but [[data serialization]] ensures both sides speak the same language.
- **Three formats you must know:** [[JSON]], [[XML]], [[YAML]]
- **Exam topic 6.7:** Recognize components of JSON-encoded data

### The Problem Without Serialization

```
App A (Python) ──┐
                 ├─→ App C's internal data structures
App B (Ruby) ────┤     ??? = Incompatible, unreadable
                 │
App C (Java) ────┘
```

### The Solution With Serialization

```
App A (Python) ──┐
                 ├─→ JSON serialized data ←──┐ Readable by all
App B (Ruby) ────┤                            │ applications
                 │                            │
App C (Java) ────→ API serializes to JSON ────┘
```

---

## 24.2 JSON (JavaScript Object Notation)

### Overview

- **Open-standard** data serialization format
- **Language-independent** (despite the name; works with Python, Ruby, Java, Go, etc.)
- **Human-readable** (unlike binary formats)
- **REST API native** (Cisco heavily uses JSON in automation)
- **CCNA exam focus:** Recognizing JSON components and interpreting JSON structures

### JSON Data Types: The Complete Picture

JSON has **four primitive types** and **two structured types**.

#### Primitive Data Types

| Type | Example | Notes |
|------|---------|-------|
| **String** | `"GigabitEthernet1/1"` | Always in double quotes. `"5"` is a string, not a number. `"true"` is a string, not a Boolean. |
| **Number** | `1000`, `192.168`, `-5` | No quotes. Can be integer or float. |
| **Boolean** | `true`, `false` | Lowercase only. No quotes. |
| **Null** | `null` | Lowercase only. Represents intentional absence of value. |

**⚠️ CRITICAL EXAM TRAP:**  
`"5"` (with quotes) = STRING  
`5` (no quotes) = NUMBER  
This distinction appears on CCNA exams frequently.

---

### JSON Structured Data Types

#### JSON Objects

**Definition:** An unordered set of key-value pairs, enclosed in curly braces `{}`.

```json
{
    "interface_name": "GigabitEthernet1/1",
    "is_up": true,
    "ip_address": "192.168.1.1",
    "netmask": "255.255.255.0",
    "speed": 1000,
    "description": null
}
```

**Rules for Objects:**
- Enclosed in `{}`
- Each key must be a **string** (always in double quotes)
- Values can be any JSON data type: string, number, Boolean, null, **or another object/array**
- Key and value separated by `:`
- Multiple pairs separated by `,`
- **No trailing comma** after the last pair (common mistake)

**Example with nested object:**
```json
{
    "interface": {
        "name": "GigabitEthernet1/1",
        "ip": "192.168.1.1"
    },
    "vlan_id": 10
}
```

#### JSON Arrays

**Definition:** An ordered set of values, enclosed in square brackets `[]`.

```json
{
    "vlans": [10, 20, 30, 40],
    "dns_servers": ["8.8.8.8", "8.8.4.4"],
    "interfaces": [
        {
            "name": "Gi0/0",
            "ip": "192.168.1.1"
        },
        {
            "name": "Gi0/1",
            "ip": "192.168.2.1"
        }
    ]
}
```

**Rules for Arrays:**
- Enclosed in `[]`
- Values separated by `,`
- Values can be any JSON data type (including nested arrays and objects)
- **Order matters** (unlike objects)
- **No trailing comma** after the last value

---

### Interpreting Complex JSON

**Example: Router configuration data**

```json
{
    "hostname": "router-core-01",
    "interfaces": [
        {
            "name": "Gi0/0",
            "enabled": true,
            "ip_config": {
                "address": "10.1.1.1",
                "mask": "255.255.255.0"
            },
            "description": null
        },
        {
            "name": "Gi0/1",
            "enabled": false,
            "ip_config": null,
            "description": "Link to distribution"
        }
    ],
    "routing": {
        "ospf_enabled": true,
        "bgp_enabled": false,
        "static_routes": []
    }
}
```

**Breakdown:**
- Root level: **Object** (`{...}`)
- `"hostname"`: **String** value
- `"interfaces"`: **Array** of **objects**
  - First interface: Gi0/0, enabled, has nested IP config object
  - Second interface: Gi0/1, disabled, no IP config (`null`)
- `"routing"`: **Object** containing Booleans and an empty array

---

## 24.3 XML (Extensible Markup Language)

### Overview

- **Tag-based** format (uses opening/closing tags like HTML)
- **Verbose** compared to JSON
- **Human-readable**
- Common in enterprise systems, less favored for modern APIs (though still used)

### Basic Structure

```xml
<?xml version="1.0" encoding="UTF-8"?>
<interface>
    <name>GigabitEthernet1/1</name>
    <is_up>true</is_up>
    <ip_address>192.168.1.1</ip_address>
    <netmask>255.255.255.0</netmask>
    <speed>1000</speed>
    <description></description>
</interface>
```

### XML vs JSON Comparison

| Aspect | JSON | XML |
|--------|------|-----|
| **Structure** | Key-value pairs | Tags/elements |
| **Verbosity** | Compact | Verbose |
| **Readability** | High | High |
| **Parsing overhead** | Low | Higher |
| **Modern APIs** | Preferred | Legacy systems |
| **Array representation** | Native `[]` | Repeated tags |
| **Null values** | `null` keyword | Empty tags or attributes |

**JSON is more compact:**
```json
// JSON: 81 bytes
{"name":"Gi0/0","ip":"192.168.1.1"}
```

```xml
<!-- XML: 130+ bytes -->
<interface>
    <name>Gi0/0</name>
    <ip_address>192.168.1.1</ip_address>
</interface>
```

---

## 24.4 YAML (YAML Ain't Markup Language)

### Overview

- **Whitespace-sensitive** format
- Uses **indentation** instead of brackets
- **Human-friendly** (often used in configuration files)
- Common in [[Ansible]] automation, Docker Compose, Kubernetes
- **Not on CCNA exam**, but useful for network automation context

### Basic Structure

```yaml
interface:
  name: GigabitEthernet1/1
  is_up: true
  ip_address: 192.168.1.1
  netmask: 255.255.255.0
  speed: 1000
  description: null

vlans:
  - 10
  - 20
  - 30
```

### YAML vs JSON/XML

| Aspect | YAML |
|--------|------|
| **Brackets** | No (uses indentation) |
| **Quotes** | Optional for strings |
| **Colons** | Still used for key-value pairs |
| **Lists** | Use `-` prefix |
| **Readability** | Very high (minimal syntax) |
| **Use case** | Config files, [[Ansible]] playbooks |

---

## Lab Relevance: Cisco IOS & Data Formats

### Relevant Cisco Commands

#### Viewing JSON-formatted API responses

```bash
# Cisco Catalyst switches with REST API
GET /api/v1/interfaces HTTP/1.1
Host: switch-ip
Authorization: Basic <credentials>

# Response will be JSON-formatted
```

#### NETCONF/YANG (uses XML)

```bash
# NETCONF session (RFC 6242)
<rpc message-id="1" xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
  <get-config>
    <source>
      <running/>
    </source>
  </get-config>
</rpc>
```

#### Ansible playbook (YAML format)

```yaml
---
- hosts: routers
  gather_facts: no
  tasks:
    - name: Configure interface
      ios_config:
        commands:
          - description Uplink to Core
        parents: interface GigabitEthernet0/0
```

#### REST API call examples

```bash
# Curl command to fetch JSON from Cisco device
curl -u admin:password https://192.168.1.1/api/v1/config/devices

# Python script interpreting JSON response
import requests
import json

response = requests.get('https://switch-ip/api/v1/interfaces', 
                       auth=('admin', 'password'))
data = response.json()  # Parse JSON
for interface in data['interfaces']:
    print(interface['name'])
```

---

## Exam Tips: What CCNA Tests on Data Formats

### Topic 6.7: Recognize Components of JSON-Encoded Data

**What you WILL see:**

1. **Identify JSON data types** from a snippet
   - "What data type is this value: `42`?" → Number
   - "What data type is this value: `'42'`?" → String
   - "What data type is this value: `true`?" → Boolean

2. **Spot syntax errors**
   - Trailing commas in objects/arrays (INVALID)
   - Single quotes instead of double quotes (INVALID)
   - Unquoted keys (INVALID)
   - Uppercase `True`, `False`, `Null` (INVALID—must be lowercase)

3. **Interpret complex JSON structures**
   - Identify which values are nested objects vs. arrays
   - Understand array ordering vs. object key ordering
   - Parse JSON with mixed data types

4. **Count elements correctly**
   - "How many interfaces are in this JSON array?"
   - "What is the value of the 'speed' key in the second object?"

### Question Examples You'll See

**Example 1: Data Type Identification**
```
Which of the following is NOT a valid JSON primitive data type?
A) String
B) Number
C) Integer  ← CORRECT ANSWER (JSON only has "Number")
D) Boolean
```

**Example 2: Syntax Error Spotting**
```json
{
    "vlan_id": 10,
    "vlan_name": "Management",  ← TRAILING COMMA IS INVALID
}
```

**Example 3: Array Ordering**
```
Given this JSON array: ["Server1", "Server2", "Server3"]
The order

---
*Source: Acing the CCNA Exam, Volume 2, Chapter 24 | [[CCNA]]*