# XSQLDA

## What it is
Think of XSQLDA like a train manifest — a structured document that describes every car (column) in a data shipment before the cargo (actual data) arrives. Precisely, XSQLDA (Extended SQL Descriptor Area) is a C-language data structure used in Firebird and InterBase database APIs to describe the format of SQL query inputs and outputs at runtime. It acts as a metadata container that tells the application how many columns exist, their data types, lengths, and memory addresses for binding.

## Why it matters
In older Firebird/InterBase applications, improper bounds checking when populating XSQLDA structures created buffer overflow conditions — attackers who could influence query structure (e.g., via stored procedures returning unexpected column counts) could corrupt adjacent memory. More relevantly for defense, SQL injection vectors in applications using dynamic XSQLDA binding are particularly dangerous because the descriptor is constructed at runtime, meaning type confusion or unsanitized input can corrupt the sqld/sqln fields and cause unpredictable query behavior or crashes exploitable for denial-of-service.

## Key facts
- `sqln` stores the *allocated* number of XSQLVAR slots; `sqld` stores the *actual* number returned by the server — a mismatch is a classic source of out-of-bounds memory access
- Each column is described by an `XSQLVAR` sub-structure containing `sqltype`, `sqllen`, `sqldata` pointer, and `sqlind` (null indicator)
- XSQLDA is used in Firebird's GPRE (General PreProcessor) and direct C API (isc_dsql_* calls), not in JDBC/ODBC which abstract it away
- Vulnerabilities here fall under CWE-119 (Improper Restriction of Operations within Memory Buffer)
- Firebird is open-source and still actively deployed in healthcare and financial legacy systems, making XSQLDA knowledge relevant for legacy application penetration testing

## Related concepts
[[Buffer Overflow]] [[SQL Injection]] [[Memory Corruption]]