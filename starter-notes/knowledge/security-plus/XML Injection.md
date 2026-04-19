---
domain: "application-security"
tags: [injection, xml, web-security, input-validation, attack, owasp]
---
# XML Injection

**XML Injection** is an attack technique that exploits applications that parse or construct [[XML]] (eXtensible Markup Language) documents by embedding malicious XML syntax or content into user-supplied input. When an application insufficiently validates or sanitizes data before incorporating it into XML structures, attackers can manipulate the document's logic, inject new XML elements, or trigger unintended behaviors in downstream parsers. XML Injection is closely related to [[SQL Injection]] in principle and shares conceptual overlap with [[XXE (XML External Entity) Injection]], though it targets the structural integrity of XML data rather than external resource resolution.

---

## Overview

XML is a widely used data serialization and transport format underpinning technologies such as SOAP web services, REST APIs, configuration files, document storage systems, and enterprise application integration. Because XML relies on angle brackets, tags, attributes, and a hierarchical tree structure, any user-controlled data embedded directly into an XML document without proper encoding creates an opportunity for structural manipulation. XML Injection exploits this trust relationship between user input and the XML parser.

The attack exists because developers frequently build XML documents through string concatenation rather than using safe XML construction APIs or parameterized approaches. An application might dynamically construct an XML payload like `<user><name>` + userInput + `</name></user>`. If an attacker supplies input containing `</name><role>admin</role><name>`, the resulting document gains an injected `<role>` element, potentially altering application logic that reads role information from the parsed tree.

XML Injection encompasses several overlapping sub-techniques. **Element injection** allows attackers to add entirely new tags, altering the data model seen by the receiving application. **Attribute injection** manipulates existing element attributes to change application behavior (e.g., changing `authenticated="false"` to `authenticated="true"`). **Comment injection** (`<!--`) can silence portions of an XML document, hiding legitimate content from the parser. **CDATA injection** (`<![CDATA[...]]>`) can be used to bypass input filters that look for tag characters in literal text.

Real-world impact of XML Injection has been observed in SOAP-based financial services, healthcare interoperability systems using HL7 XML, and enterprise middleware platforms. A successful injection can lead to privilege escalation within application logic, authentication bypass, data corruption, information disclosure, and in combination with XXE vulnerabilities, server-side request forgery or arbitrary file read. The attack surface is large in enterprise environments where XML-based protocols like SAML, XMPP, and SOAP are prevalent.

Unlike [[Cross-Site Scripting (XSS)]] which targets the client browser, XML Injection typically targets server-side logic and backend systems. The vulnerability is classified under OWASP's A03:2021 – Injection and has been recognized in the OWASP Testing Guide (OTG-INPVAL-008) as a discrete test category for web application security assessments.

---

## How It Works

### The Vulnerable Pattern

The root cause is string concatenation when building XML documents. Consider a SOAP-based authentication service that constructs this XML:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<authenticate>
  <username>USER_INPUT</username>
  <password>PASS_INPUT</password>
</authenticate>
```

The server-side Java code generating this might look like:

```java
String xml = "<?xml version=\"1.0\"?><authenticate>" +
             "<username>" + username + "</username>" +
             "<password>" + password + "</password>" +
             "</authenticate>";
DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(
    new InputSource(new StringReader(xml))
);
```

No sanitization, no encoding — just raw concatenation.

### Step 1: Reconnaissance

An attacker probes the application by sending XML metacharacters to observe parsing errors or unexpected behavior:

```
username: test<
username: test&
username: test]]>
username: test"
```

An XML parsing error in the response (e.g., `org.xml.sax.SAXParseException: The element type "username" must be terminated`) confirms the input is embedded unencoded into XML.

### Step 2: Basic Element Injection

The attacker constructs a payload that closes the current element and injects new ones:

```
username: alice</username><role>admin</role><username>alice
```

This produces:

```xml
<authenticate>
  <username>alice</username>
  <role>admin</role>
  <username>alice</username>
  <password>anything</password>
</authenticate>
```

If the application reads the `<role>` element from the parsed document to determine privileges, the attacker has injected an administrative role assignment.

### Step 3: Authentication Bypass via Element Injection

Many SOAP services carry authentication state in XML attributes or elements. An attacker targeting a service that checks `<authenticated>false</authenticated>` can inject:

```
username: admin</username><authenticated>true</authenticated><username>admin
```

Resulting XML:

```xml
<authenticate>
  <username>admin</username>
  <authenticated>true</authenticated>
  <username>admin</username>
  <password></password>
</authenticate>
```

### Step 4: Attribute Injection

If user input is embedded in an attribute value:

```xml
<user role="USER_INPUT_HERE" />
```

An attacker supplies:
```
guest" role="admin
```

Resulting in:
```xml
<user role="guest" role="admin" />
```

Depending on the parser (some parsers take the last attribute value), this can override the intended role.

### Step 5: Comment Injection to Neutralize Validation Logic

An attacker can inject an XML comment to disable parts of the document:

```
username: alice<!--
```

This begins a comment block that swallows subsequent XML until `-->` appears, potentially neutralizing access control elements:

```xml
<username>alice<!--</username><checkAccess>true</checkAccess>-->
```

### Step 6: CDATA Smuggling

CDATA sections tell parsers to treat content as raw character data rather than markup. Attackers can use this to bypass filters:

```
username: <![CDATA[</username><admin>true</admin><username>]]>
```

### Testing with Burp Suite

Using [[Burp Suite]], intercept a SOAP or XML-based request and modify the body:

```
POST /soap/auth HTTP/1.1
Host: target.local
Content-Type: text/xml; charset=utf-8
SOAPAction: "authenticate"

<?xml version="1.0"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
  <soapenv:Body>
    <auth:login>
      <auth:username>admin</auth:username>
      <auth:password>x</auth:password>
    </auth:login>
  </soapenv:Body>
</soapenv:Envelope>
```

Inject into `<auth:username>`:

```xml
<auth:username>admin</auth:username><auth:isAdmin>true</auth:isAdmin><auth:username>admin</auth:username>
```

---

## Key Concepts

- **XML Element Injection**: The insertion of new XML elements into a document by breaking out of the intended element structure using `</tag>` sequences followed by new tag content, altering the data model processed by the application.

- **XML Attribute Injection**: Manipulation of element attributes by injecting quote characters and additional attribute name/value pairs into input that is embedded within attribute values in the XML document.

- **CDATA Section**: A construct in XML (`<![CDATA[ ... ]]>`) that instructs the parser to treat enclosed content as raw text rather than markup; attackers can exploit or inject CDATA sections to smuggle metacharacters past input filters.

- **XML Comment Injection**: Insertion of the XML comment delimiter `<!--` into user input to suppress or neutralize sections of an XML document that would otherwise enforce security controls.

- **SOAP Injection**: A specific form of XML Injection targeting SOAP (Simple Object Access Protocol) web services, where XML is the transport format for remote procedure calls, making it a high-value target for element and attribute manipulation attacks.

- **Schema Validation Bypass**: XML Injection attacks often succeed because schema validation (XSD) is not enforced server-side, or because the injection produces a document that technically conforms to a loose schema while still carrying malicious semantic content.

- **Blind XML Injection**: An XML Injection variant where the application does not return parsing errors or reflected output, requiring attackers to infer injection success through behavioral differences in application responses (similar to [[Blind SQL Injection]]).

---

## Exam Relevance

**SY0-701 Context**: XML Injection appears under the broader domain of **Application Attacks (Domain 4.0)** alongside SQL Injection, [[Command Injection]], and [[LDAP Injection]]. The exam tests conceptual understanding rather than deep exploitation mechanics.

**Common Question Patterns**:
- Questions asking you to identify XML Injection as the attack type when a user modifies input fields in SOAP/XML-based applications
- Scenario questions contrasting XML Injection with **XXE Injection** — know that XXE is a *subset* or related attack involving external entity references (`<!ENTITY>`), while XML Injection more broadly refers to structural manipulation of the XML document itself
- Questions about **input validation** and **output encoding** as the primary defenses against injection attacks, including XML Injection
- Matching attack types to OWASP Top 10 categories (A03:2021 Injection)

**Gotchas**:
- Do not confuse XML Injection with [[XXE (XML External Entity) Injection]]; XXE specifically exploits the XML external entity feature to read files or trigger SSRF, while XML Injection manipulates document structure and logic
- The exam may present XML Injection in the context of **SAML** authentication bypass — SAML uses XML, and signature wrapping attacks are a form of XML Injection against SAML assertions
- Remember that XML Injection can occur **server-to-server** (middleware, APIs), not just in browser-based web applications

---

## Security Implications

### Attack Vectors and Vulnerabilities

XML Injection primarily threatens applications that use XML for inter-system communication (SOAP services, SAML, XMPP, configuration APIs) and those that store user data in XML format. The attack vector is typically **network-accessible**, via HTTP/HTTPS on ports 80/443 for web services, or port 8080/8443 for application servers. SOAP services may also run on custom ports.

**SAML Signature Wrapping**: A historically significant form of XML Injection against SAML Identity Providers. By wrapping a legitimate signed assertion with injected XML, attackers could forge authentication tokens. This affected multiple SAML implementations including Shibboleth and SimpleSAMLphp. CVE-2017-11427 (OneLogin Ruby SAML) and CVE-2018-0489 (Shibboleth) both involved XML structure manipulation allowing authentication bypass.

**CVE-2019-3490**: A Novell eDirectory vulnerability where XML Injection in the iMonitor web interface allowed unauthenticated attackers to modify directory entries by injecting elements into LDAP-over-XML queries.

**CVE-2021-27886** (Mautic): XML handling in the marketing automation platform allowed injection that could alter campaign logic and data records.

### Detection Indicators

- Unexpected XML parsing errors (`SAXParseException`, `XMLStreamException`) returned in HTTP responses
- Anomalous XML structure in web application firewall (WAF) logs — look for `</`, `<!--`, `<![CDATA[` in parameter values
- SIEM alerts on malformed XML in API gateways
- Application logs showing unexpected elements in parsed XML structures

---

## Defensive Measures

### 1. Use Safe XML Construction APIs

Never concatenate strings to build XML. Use document builder APIs that handle encoding automatically:

**Java (DOM):**
```java
DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
Document doc = dbf.newDocumentBuilder().newDocument();
Element root = doc.createElement("authenticate");
Element user = doc.createElement("username");
user.setTextContent(userInput);  // Handles encoding automatically
root.appendChild(user);
doc.appendChild(root);
```

**Python (lxml):**
```python
from lxml import etree
root = etree.Element("authenticate")
username_el = etree.SubElement(root, "username")
username_el.text = user_input  # lxml encodes metacharacters
```

### 2. XML Encode User Input

If you must embed user data into XML strings, encode XML metacharacters before insertion:

| Character | Encoded Form |
|-----------|-------------|
| `<`       | `&lt;`      |
| `>`       | `&gt;`      |
| `&`       | `&amp;`     |
| `"`       | `&quot;`    |
| `'`       | `&apos;`    |

In Python:
```python
import xml.sax.saxutils as saxutils
safe_input = saxutils.escape(user_input)
```

### 3. XML Schema Validation (XSD)

Enforce strict XML Schema Definition validation to reject documents that do not conform to the expected structure:

```xml
<!-- schema.xsd -->
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">
  <xs:element name="authenticate">
    <xs:complexType>
      <xs:sequence>
        <xs:element name="username" type="xs:string" minOccurs="1" maxOccurs="1"/>
        <xs:element name="password" type="xs:string" minOccurs="1" maxOccurs="1"/>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
</xs:schema>
```

Enforce in Java:
```java
SchemaFactory sf = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
Schema schema = sf.newSchema(new File("schema.xsd"));
Validator validator = schema.newValidator();
validator.validate(new DOMSource(document));  // Throws if invalid
```

### 4. Web Application Firewall Rules

Configure WAF rules (ModSecurity, AWS WAF, F5 ASM) to detect XML metacharacters in parameters:

**ModSecurity rule example:**
```
SecRule ARGS "@rx [<>&'\"]" \
    "id:100001,phase:2,deny,status:400,\
    msg:'Possible XML Injection',\
    logdata:'Matched Data: %{TX.0} found within %{MATCHED_VAR_NAME}'"
```

### 5. Disable External Entities (XXE Mitigation — Complementary)

Hardening against XXE simultaneously reduces XML attack surface:

```java
DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
dbf.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);
dbf.setFeature("http://xml.org/sax/features/external-general-entities", false);
dbf.setFeature("http://xml.org/sax/features/external-parameter-entities", false);
dbf.setXIncludeAware(false);
dbf.setExpandEntityReferences(false);
```

### 6. Principle of Least Privilege for XML Processors

Run XML parsing services under accounts with minimal filesystem and network permissions. This limits the blast radius if injection leads to XXE or file inclusion escalation.

---

## Lab / Hands-On

### Lab Environment Setup

Use **DVWA** (Damn Vulnerable Web Application), **WebGoat**, or a custom SOAP service running in your homelab. The following uses a Docker-based vulnerable SOAP service:

```bash
# Pull and run WebGoat (includes XML/SOAP injection lessons)
docker pull webgoat/webgoat-8.0
docker run -p 8080:8080 -p 9090:9090 webgoat/webgoat-8.0

# Access at http://localhost:8080/WebGoat
```

### Exercise 1: Manual XML Injection Testing

Set up a minimal vulnerable Python Flask SOAP endpoint:

```python
# vuln_xml_service.py
from flask import Flask, request
import xml.etree.ElementTree as ET

app = Flask(__name__)

@app.route('/login', methods=['POST'])
def login():
    username = request.form.