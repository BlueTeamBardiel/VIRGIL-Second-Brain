# XCom

## What it is
Like passing notes between prisoners in different cells through a trusted guard, XCom (Cross-Communication) is Apache Airflow's built-in mechanism that allows tasks in a DAG (Directed Acyclic Graph) to share small pieces of data by pushing and pulling values through a central metadata database. It enables workflow tasks to coordinate without direct connections to each other.

## Why it matters
In a DevSecOps pipeline breach, an attacker who compromises an Airflow worker node could abuse XCom to exfiltrate secrets — such as API keys or database credentials — that upstream tasks stored as XCom values and downstream tasks retrieve at runtime. Because XCom values are stored in plaintext in Airflow's backend database by default, a single database read can expose sensitive inter-task communications across an entire automated pipeline.

## Key facts
- XCom values are stored in Airflow's metadata DB (commonly PostgreSQL or MySQL) and are **not encrypted at rest by default**
- Tasks push values via `xcom_push()` and retrieve them via `xcom_pull()`, making the metadata database a high-value target
- XCom is intended for **small metadata** (not large datasets), but developers frequently misuse it to pass credentials or tokens
- Hardening requires encrypting the Airflow Fernet key, restricting DB access, and auditing what values tasks store in XCom
- Excessive XCom use violates the **principle of least privilege** — tasks receive access to data they shouldn't need

## Related concepts
[[Secrets Management]] [[Pipeline Security]] [[Principle of Least Privilege]] [[Credential Exposure]] [[CI/CD Security]]