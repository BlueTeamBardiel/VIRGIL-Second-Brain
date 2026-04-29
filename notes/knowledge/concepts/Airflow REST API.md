# Airflow REST API

## What it is
Think of Apache Airflow like an air traffic controller for data pipelines — the REST API is the radio frequency anyone can use to issue commands to that controller. Precisely, the Airflow REST API is an HTTP interface that allows external systems to programmatically trigger, pause, inspect, and configure DAGs (Directed Acyclic Graphs), connections, variables, and users within an Airflow deployment. It was stabilized as a first-class feature in Airflow 2.0.

## Why it matters
In 2023, misconfigured Airflow instances exposed publicly on the internet allowed attackers to exploit unauthenticated API endpoints — retrieving stored database credentials and cloud provider keys embedded in Airflow *Variables* and *Connections* via simple GET requests. Because Airflow orchestrates ETL pipelines that touch data warehouses, S3 buckets, and production databases, a single exposed API becomes a master key to an organization's entire data infrastructure.

## Key facts
- **Default authentication is weak**: Early Airflow versions shipped with no authentication enabled by default; production deployments must explicitly configure RBAC or an auth backend.
- **Sensitive data exposure**: `/api/v1/connections` and `/api/v1/variables` endpoints can return plaintext credentials if improperly secured — a direct CWE-312 (Cleartext Storage of Sensitive Information) violation.
- **Privilege escalation risk**: The `/api/v1/users` endpoint allows admin-level API keys to create new admin accounts, enabling persistent access.
- **DAG triggering = RCE potential**: Triggering a malicious or modified DAG via `POST /api/v1/dags/{dag_id}/dagRuns` can result in arbitrary code execution on the worker nodes.
- **Network exposure**: Airflow's webserver port (default 8080) hosting the API should never be internet-facing; access should be restricted via firewall rules or a VPN.

## Related concepts
[[Credential Exposure]] [[Broken Object Level Authorization]] [[Server-Side Request Forgery]]