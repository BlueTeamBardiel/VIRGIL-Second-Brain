# REST APIs

## What it is

Ordering food on DoorDash: you tap "add to cart," then "checkout," then "track order." Each tap is a separate, self-contained request to DoorDash's servers — the app doesn't keep a phone line open with the restaurant the whole time. You ask, you get an answer, you move on. That's REST.

REST (Representational State Transfer) is an architectural style for how software applications talk to each other. It's not a protocol — it's a set of rules for designing APIs that ride on top of HTTP. One program (the client) sends a structured HTTP request to another program (the server), the server does the work, and sends back a structured HTTP response. Done.

In networking, this is how modern automation tools talk to controllers. Cisco Catalyst Center, for example, exposes a REST API as its **northbound interface** — the door that Python scripts, Ansible playbooks, or third-party dashboards use to push config or pull telemetry from the SDN controller.

## Why it matters

The CLI is Dark Souls — powerful, precise, but every device you fight one-on-one with a keyboard. REST APIs are Helldivers 2 stratagems — you call in changes from above, programmatically, across hundreds of devices at once, and the controller dispatches the work.

If you want to automate networks, monitor at scale, or integrate gear with anything that wasn't sold by the same vendor, you're going through a REST API. Knowing how to read a 401 vs a 403, how to format a POST body, and what idempotent means is the difference between a script that works and one that bricks production at 3 AM.

## Key facts

### Transport

- **HTTP** is the transport protocol for REST. Port **80** for HTTP, port **443** for HTTPS.
- Client-server model. The client asks, the server answers. No persistent state between calls.
- **HTTP request** structure: start line (method + URI + version), headers, blank line, optional body.
- **HTTP response** structure: start line (version + status code), headers, blank line, body.

### CRUD methods

Like inventory management in Escape from Tarkov — you create stash items, read what's there, update stack sizes, or delete trash loot.

| Method | CRUD | Safe? | Idempotent? |
|--------|------|-------|-------------|
| **POST** | Create | No | No |
| **GET** | Read | Yes | Yes |
| **PUT** | Update (full) | No | Yes |
| **PATCH** | Update (partial) | No | No |
| **DELETE** | Delete | No | Yes |

- **Idempotent** = running it 10 times has the same effect as running it once. DELETE-ing a resource that's already gone still leaves it gone.
- **Safe** = doesn't modify server state. Only GET qualifies.
- **PUT vs PATCH**: PUT replaces the whole resource (re-rolling a Diablo item from scratch). PATCH only changes the fields you send (re-rolling one affix).

### Status codes

The server's reaction face after your request:

- **1xx** — Informational ("hold on, processing")
- **2xx** — Success ("we good")
- **3xx** — Redirection ("the resource moved, go here")
- **4xx** — Client error ("you screwed up")
- **5xx** — Server error ("we screwed up")

Specific ones worth memorizing:

- **200 OK** — Success, here's your data.
- **201 Created** — POST worked, resource exists now.
- **204 No Content** — DELETE worked, nothing to send back.
- **400 Bad Request** — Your JSON is malformed. You broke the syntax.
- **401 Unauthorized** — You didn't show ID. (Authentication failure.)
- **403 Forbidden** — You showed ID, but you're not on the guest list. (Authorization failure.)
- **404 Not Found** — The resource doesn't exist. The classic.
- **500 Internal Server Error** — The server tripped over its own shoelaces.

The 401 vs 403 distinction trips people up: 401 means "who are you?", 403 means "I know who you are and I still won't let you in."

### REST's six guiding principles

1. **Client-server** — separation of concerns.
2. **Statelessness** — every request carries everything the server needs. No "remember me from last time."
3. **Uniform interface** — consistent resource naming and methods.
4. **Cacheability** — responses can be cached when appropriate.
5. **Layered system** — client doesn't know if it's talking to the actual server or a proxy/load balancer in front.
6. **Code on demand** (optional) — server can ship executable code (like JavaScript) to the client.

**HATEOAS** (Hypermedia As The Engine Of Application State) — responses include links to related actions, so the client navigates the API like clicking links on a webpage rather than memorizing URLs.

### Resource naming

URIs uniquely identify every resource. Naming conventions:

- **Nouns, not verbs** — `/devices`, not `/getDevices`. The HTTP method is the verb.
- **Plural for collections** — `/devices/42` not `/device/42`.
- **Hyphens for multi-word names** — `/network-interfaces`, not `/network_interfaces` or `/networkInterfaces`.
- **Path parameters** for hierarchy — `/devices/42/interfaces/3` walks down a tree.
- **Query parameters** for filtering and sorting — `/devices?vendor=cisco&sort=hostname`.

### Data formats (MIME types)

What language the body is written in. Set with the `Content-Type` header.

- **application/json** — JSON. Lightweight, human-readable, the default for modern APIs.
- **application/xml** — XML. Verbose, older, still common in legacy systems.
- **application/yaml** — YAML. Indentation-based, popular in config files.
- **text/csv** — CSV. Spreadsheet-style.
- **text/plain** — Plain text.

### Authentication vs Authorization

- **Authentication** = who you are. (Showing your Steam login.)
- **Authorization** = what you're allowed to do. (Whether you own the DLC.)

Common auth methods:

- **Basic Auth** — username and password Base64-encoded in the header. Sent on **every** request. Base64 is *encoding*, not encryption — without HTTPS, the password is essentially in plaintext for anyone sniffing the wire.
- **API Keys** — a simple string in a header or query parameter. Like a Discord invite link: whoever has it, gets in.
- **Bearer Token** — you authenticate once, server gives you a token, you include it as `Authorization: Bearer <token>` on subsequent requests. Tokens can expire, limiting blast radius if leaked.
- **OAuth 2.0** — industry standard for delegated authorization. The "Sign in with Google" flow on random websites — you let App A act on your behalf with App B without ever giving App A your App B password.
- **JWT (JSON Web Token)** — a self-contained token with three parts separated by dots: **Header.Payload.Signature**. The payload contains claims (who you are, what you can do, when it expires); the signature lets the server verify the token wasn't tampered with. Common as the actual token used in Bearer auth.

## Related concepts

- [[SDN Controllers]]
- [[Northbound and Southbound Interfaces]]
- [[Cisco Catalyst Center]]
- [[JSON]]
- [[YAML]]
- [[HTTP and HTTPS]]
- [[TLS]]
- [[Network Automation]]
- [[Python requests library]]
- [[Postman]]
- [[Ansible]]
- [[NETCONF and RESTCONF]]
- [[OAuth 2.0]]
- [[JWT]]