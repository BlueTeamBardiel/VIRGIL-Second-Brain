# REST APIs
**Why this matters: REST APIs are the bridge between network automation tools and Cisco devices—understanding them is essential for modern network engineering and SDN integration.**

## Overview

[[REST]] (Representational State Transfer) APIs enable seamless communication between software applications across different devices, programming languages, and platforms. In networking, REST APIs serve as the **northbound interface (NBI)** of [[SDN]] controllers, allowing engineers to programmatically manage network infrastructure. CCNA exam topic **6.5** requires you to describe REST-based API characteristics: authentication types, [[CRUD]] operations, [[HTTP]] methods (verbs), and data encoding formats.

**Simple analogy:** An API is like a restaurant menu. Instead of customers entering the kitchen to explain what they want, they use the menu (the API) to request specific dishes (resources). The kitchen (server) processes the order and returns the result.

## Why APIs Matter

Without APIs, applications would require custom point-to-point integrations:
- **App A ↔ App B**: Custom integration #1
- **App A ↔ App C**: Custom integration #2  
- **App B ↔ App C**: Custom integration #3

This creates a tangled web of complexity. APIs standardize communication, allowing multiple applications to access a single interface uniformly.

**Real-world example:** [[Cisco Catalyst Center]] (formerly Cisco DNA Center) exposes a REST API so that external automation tools, scripts, and third-party platforms can query device information, create policies, and monitor network health—all without knowing how Catalyst Center's internal database works.

---

## HTTP: The Protocol Foundation

[[HTTP]] is the transport protocol for REST APIs. It uses a **client-server architecture** where clients send requests and servers send responses. HTTP runs over [[TCP]] port 80 (or 443 for HTTPS), making it universally accessible.

### HTTP Request Structure

An HTTP request contains four components:

```
START LINE:    [METHOD] [URI] [HTTP_VERSION]
HEADERS:       Key-value pairs (Host, Authorization, Content-Type, etc.)
BLANK LINE:    Separates headers from body
BODY:          Optional message data (JSON, XML, etc.)
```

**Example HTTP Request:**
```
POST /api/v1/devices/switches HTTP/2
Host: catalyst-center.example.com
Authorization: Bearer eyJhbGc...
Content-Type: application/json
User-Agent: NetworkAutomationTool/2.1

{
  "deviceName": "Switch-Core-01",
  "ipAddress": "192.168.1.100",
  "snmpVersion": "v3"
}
```

### HTTP Response Structure

The server responds with:

```
START LINE:    [HTTP_VERSION] [STATUS_CODE] [STATUS_TEXT]
HEADERS:       Metadata about the response
BLANK LINE:    Separates headers from body
BODY:          Returned data (often JSON)
```

**Example HTTP Response:**
```
HTTP/2 201 Created
Date: Wed, 21 Dec 2022 12:35:10 GMT
Content-Type: application/json
Content-Length: 256

{
  "message": "Device created successfully",
  "deviceId": "abc123def456",
  "ipAddress": "192.168.1.100",
  "status": "online"
}
```

---

## HTTP Methods (Verbs) and CRUD Operations

[[CRUD]] stands for Create-Read-Update-Delete—the four fundamental data operations. HTTP methods map to CRUD operations as follows:

| CRUD Operation | Purpose | HTTP Method | Idempotent | Safe |
|---|---|---|---|---|
| **Create** | Add new resource | [[POST]] | ❌ No | ❌ No |
| **Read** | Retrieve resource | [[GET]] | ✅ Yes | ✅ Yes |
| **Update (Full)** | Replace entire resource | [[PUT]] | ✅ Yes | ❌ No |
| **Update (Partial)** | Modify specific fields | [[PATCH]] | ❌ No | ❌ No |
| **Delete** | Remove resource | [[DELETE]] | ✅ Yes | ❌ No |
| **Options** | Query allowed methods | OPTIONS | ✅ Yes | ✅ Yes |
| **Head** | Like GET, no response body | HEAD | ✅ Yes | ✅ Yes |

**Key Distinctions:**
- **Idempotent:** Calling multiple times produces same result (PUT, GET, DELETE)
- **Safe:** Request doesn't modify server state (GET, HEAD, OPTIONS)
- **POST is neither idempotent nor safe** — multiple POST requests create multiple resources

---

## HTTP Status Codes

The server's response begins with a 3-digit status code indicating the outcome:

| Code Range | Category | Examples | Meaning |
|---|---|---|---|
| **1xx** | Informational | 100 Continue | Request received; waiting for body |
| **2xx** | Success | 200 OK, 201 Created, 204 No Content | Request succeeded |
| **3xx** | Redirection | 301 Moved Permanently, 302 Found | Client must take further action |
| **4xx** | Client Error | 400 Bad Request, 401 Unauthorized, 404 Not Found | Client sent invalid request |
| **5xx** | Server Error | 500 Internal Server Error, 503 Service Unavailable | Server failed to process request |

**Common CCNA-relevant codes:**
- `200 OK` — Request succeeded, data returned
- `201 Created` — Resource created successfully
- `204 No Content` — Successful DELETE (no body in response)
- `400 Bad Request` — Malformed request syntax
- `401 Unauthorized` — Missing/invalid authentication
- `403 Forbidden` — Authenticated but lacks permission
- `404 Not Found` — Resource doesn't exist
- `500 Internal Server Error` — Server fault

---

## REST API Architecture

[[REST]] is an architectural style (not a protocol) with six guiding principles:

### 1. **Client-Server Architecture**
Clients and servers are separate, allowing independent evolution. A network engineer's Python script (client) communicates with Catalyst Center (server).

### 2. **Statelessness**
Each request contains all information needed for the server to process it. The server doesn't store client context between requests—cookies/sessions maintain state on the client side.

**Example:**
```
GET /api/v1/devices/abc123 HTTP/2
Authorization: Bearer token123
```
The server doesn't remember previous requests; the Authorization header provides the needed context.

### 3. **Uniform Interface**
Four constraints standardize communication:
- **Resource identification in requests:** URIs uniquely identify resources (`/api/v1/devices/switch-01`)
- **Resource manipulation via representations:** Clients manipulate resources via JSON/XML representations
- **Self-descriptive messages:** Each message includes enough info for interpretation
- **HATEOAS (Hypermedia As The Engine Of Application State):** Responses include links to related resources

### 4. **Cacheability**
Responses are marked as cacheable or non-cacheable, improving performance by reducing redundant requests.

### 5. **Layered System**
Clients can't know if directly connected to end server. Intermediate layers (proxies, load balancers) can improve scalability.

### 6. **Code on Demand** (Optional)
Servers can extend client functionality by returning executable code (rarely used in modern APIs).

---

## URI Structure and Resource Identification

URIs (Uniform Resource Identifiers) identify REST resources using a hierarchical structure:

```
https://catalyst-center.example.com:443/api/v1/devices/switches/abc123
└─ Scheme (https)  └─ Host           └─ Port  └─ Base  └─ API   └─ Resource type  └─ Resource ID
                                                    Path  Version  and hierarchy
```

**REST Resource Naming Conventions:**
- Use **nouns** (not verbs): `/devices` not `/getDevices`
- Use **plural** for collections: `/devices` (collection), `/devices/abc123` (single resource)
- Use **hyphens** for multi-word names: `/network-policies` not `/networkPolicies`
- Use **path parameters** for hierarchical relationships: `/devices/abc123/interfaces/eth0`
- Use **query parameters** for filtering/sorting: `/devices?status=online&limit=10`

**Examples:**
```
GET    /api/v1/devices                           # Get all devices
POST   /api/v1/devices                           # Create new device
GET    /api/v1/devices/abc123                    # Get specific device
PUT    /api/v1/devices/abc123                    # Update device (full replacement)
PATCH  /api/v1/devices/abc123                    # Update device (partial)
DELETE /api/v1/devices/abc123                    # Delete device
GET    /api/v1/devices/abc123/interfaces         # Get device's interfaces
POST   /api/v1/devices/abc123/interfaces         # Add interface to device
```

---

## Data Encoding and Formats

REST APIs exchange data in structured formats. The `Content-Type` header specifies the encoding:

| Format | MIME Type | Use Case | Readability |
|---|---|---|---|
| **JSON** | `application/json` | Modern APIs, Cisco APIs | Excellent |
| **XML** | `application/xml` | Legacy systems, SOAP | Good |
| **YAML** | `application/yaml` | Configuration, Ansible | Excellent |
| **CSV** | `text/csv` | Bulk data, reports | Good |
| **Plain Text** | `text/plain` | Logs, simple data | Excellent |

**JSON Example (most common for CCNA):**
```json
{
  "deviceId": "abc123",
  "deviceName": "Core-Router-01",
  "ipAddress": "10.1.1.1",
  "status": "online",
  "interfaces": [
    {
      "name": "GigabitEthernet0/0/1",
      "ipAddress": "10.2.1.1",
      "status": "up"
    }
  ]
}
```

**XML Example:**
```xml
<?xml version="1.0" encoding="UTF-8"?>
<device>
  <deviceId>abc123</deviceId>
  <deviceName>Core-Router-01</deviceName>
  <ipAddress>10.1.1.1</ipAddress>
  <status>online</status>
</device>
```

JSON is preferred because it's:
- Lightweight (smaller payload)
- Human-readable
- Native to JavaScript/Python
- Faster to parse

---

## REST API Authentication

Authentication verifies **who you are**; authorization verifies **what you can do**. REST APIs use multiple authentication methods:

### 1. **Basic Authentication**
Username and password encoded in Base64, sent in every request.

```
Authorization: Basic dXNlcjpwYXNzd29yZA==
```

**Risks:** Password visible (use HTTPS); credentials in every request; no token expiration.

### 2. **Bearer Token Authentication**
Client receives a token after login; token is sent in subsequent requests.

```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

**Advantages:** Token can have expiration; more secure than Basic Auth; stateless (server doesn't store session).

### 3. **OAuth 2.0**
Industry standard for delegated authorization. User authorizes app to access their account without sharing password.

**Flow:**
1. User clicks "Login with Google"
2. App redirects to Google authentication
3. Google returns authorization code
4. App exchanges code for access token
5. App uses token to access user's resources

**Use case:** Cisco cloud services often use OAuth 2.0 for third-party app integrations.

### 4. **API Keys**
Simple string sent as header or query parameter.

```
Authorization: ApiKey abc123def456ghi789
```

**Risks:** Less secure (static key); if exposed, entire account compromised; no fine-grained permissions.

### 5. **JWT (JSON Web Token)**
Signed token containing claims (user info, permissions, expiration).

**Structure:**
```
Header.Payload.Signature

eyJ

---
*Source: Acing the CCNA Exam, Volume 2, Chapter 23 | [[CCNA]]*
