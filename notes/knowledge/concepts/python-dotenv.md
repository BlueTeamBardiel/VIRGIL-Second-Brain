# python-dotenv

## What it is
Like a locker combination written on a sticky note *inside* the locker rather than spray-painted on the outside — python-dotenv loads environment variables from a `.env` file into a running process, keeping secrets out of source code. It reads key-value pairs (e.g., `DB_PASSWORD=hunter2`) from a local `.env` file and injects them into `os.environ` at runtime. This separates configuration from code, following the Twelve-Factor App methodology.

## Why it matters
In 2021, a developer accidentally committed a `.env` file containing AWS root credentials to a public GitHub repository; automated scrapers harvested the keys within seconds, leading to a $50,000 cloud bill from cryptomining. python-dotenv is a direct mitigation: by keeping secrets in `.env` and adding `.env` to `.gitignore`, credentials never enter version control history where they become permanently retrievable even after deletion.

## Key facts
- `.env` files should **never** be committed to source control — add them explicitly to `.gitignore` to prevent accidental exposure
- python-dotenv does **not** encrypt the `.env` file; it relies on filesystem-level access controls (permissions) for protection, making it unsuitable as a secrets vault on shared systems
- The `override=False` parameter (default) prevents `.env` values from overwriting already-set system environment variables, reducing injection risk in production pipelines
- In CI/CD pipelines, `.env` files should be replaced by secrets managers (HashiCorp Vault, AWS Secrets Manager) — python-dotenv is a **development convenience**, not a production secrets solution
- Exposing `.env` files through misconfigured web servers (e.g., publicly accessible `/.env` endpoint) is a common vulnerability catalogued in real-world bug bounty programs and scanned for by automated attack tools like `gospider`

## Related concepts
[[Environment Variables]] [[Secrets Management]] [[Credential Exposure]] [[.gitignore]] [[Least Privilege]]