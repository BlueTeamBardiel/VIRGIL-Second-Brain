# MapMessage

## What it is
Think of MapMessage like a labeled tackle box — each compartment has a name and holds a specific type of lure (data). In Java Message Service (JMS), a `MapMessage` is a message type that stores key-value pairs where keys are strings and values are Java primitives or strings, transmitted between applications via a message broker. Unlike a plain text message, each field is explicitly named and typed.

## Why it matters
In enterprise Java applications using JMS brokers like ActiveMQ, attackers have exploited unsafe deserialization when applications process `MapMessage` objects from untrusted sources — CVE-2015-5254 in ActiveMQ allowed remote code execution by sending a crafted `ObjectMessage` alongside manipulated map data. Defenders must validate and sanitize all incoming message fields as rigorously as HTTP input, because message queues are often implicitly trusted internal attack surfaces.

## Key facts
- `MapMessage` is one of five JMS message types: `TextMessage`, `BytesMessage`, `StreamMessage`, `ObjectMessage`, and `MapMessage`
- Key-value pairs in a `MapMessage` are accessed via typed getters like `getString("key")` or `getInt("key")`, reducing accidental type confusion
- Injection attacks can occur if map values are passed unsanitized into SQL queries, LDAP lookups, or OS commands within the consuming application
- Message brokers (ActiveMQ, RabbitMQ via STOMP, IBM MQ) often lack authentication by default — a misconfiguration that lets attackers inject malicious `MapMessage` payloads
- From a CySA+ perspective, message queues represent **lateral movement** opportunities; compromising a broker can cascade malicious messages to multiple downstream consumers simultaneously

## Related concepts
[[Deserialization Vulnerabilities]] [[Message Queue Security]] [[Injection Attacks]]