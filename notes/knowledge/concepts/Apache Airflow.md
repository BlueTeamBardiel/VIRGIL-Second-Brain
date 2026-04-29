# Apache Airflow

## What it is
Think of it like a factory assembly line manager who schedules workers, tracks which machines ran which jobs, and keeps logs of everything — except this manager runs in your browser and orchestrates data pipelines. Apache Airflow is an open-source workflow automation platform that schedules, monitors, and executes directed acyclic graphs (DAGs) of tasks, commonly used in data engineering and MLOps environments.

## Why it matters
In 2021, researchers discovered that misconfigured Airflow instances exposed plaintext credentials — database passwords, AWS keys, Slack tokens — stored inside DAG files and the Airflow metadata database, accessible via unauthenticated web UIs left open to the internet. An attacker who reaches the Airflow web server can trigger arbitrary DAG runs, execute code on worker nodes, and pivot into connected cloud infrastructure — making Airflow a high-value lateral movement target in data-heavy environments.

## Key facts
- Airflow's **metadata database** (typically PostgreSQL or MySQL) stores connection credentials in the `connection` table; if unencrypted, this is a treasure chest for attackers
- The **Fernet key** (`AIRFLOW__CORE__FERNET_KEY`) encrypts stored credentials — a missing or default key means credentials are stored in plaintext
- Airflow exposes a **REST API** (enabled by default since v2.0) that can trigger DAGs remotely; improper authentication on this endpoint is a critical misconfiguration
- DAG files are **executed as Python code** on the scheduler; code injection through a malicious DAG equals remote code execution on the host
- CVE-2020-11978 and CVE-2020-17526 are notable Airflow RCE/authentication bypass vulnerabilities used in real exploitation chains

## Related concepts
[[Credential Exposure]] [[Remote Code Execution]] [[Misconfiguration Vulnerabilities]] [[API Security]] [[Secrets Management]]