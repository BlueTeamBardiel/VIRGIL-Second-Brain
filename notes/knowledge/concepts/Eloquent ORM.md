# Eloquent ORM

## What it is
Like a skilled translator who converts your English requests into fluent French without you learning the language, Eloquent ORM converts PHP objects and method calls into SQL queries automatically. It is Laravel's built-in Object-Relational Mapper (ORM) that abstracts database interactions, allowing developers to query and manipulate database records using PHP syntax rather than raw SQL strings.

## Why it matters
Eloquent's parameterized query bindings provide a strong default defense against SQL injection — when developers use `User::where('email', $input)->first()`, Eloquent automatically escapes the input, preventing classic injection attacks. However, when developers bypass Eloquent and use raw expression methods like `whereRaw()` or `DB::select()` with unsanitized user input, they reintroduce the exact SQL injection vulnerabilities the ORM was designed to prevent. Penetration testers specifically probe for these raw query escape hatches in Laravel applications.

## Key facts
- Eloquent uses **prepared statements with PDO bindings** by default, which neutralizes most SQL injection vectors at the framework level
- `whereRaw()`, `selectRaw()`, and `orderByRaw()` methods accept literal SQL strings and are **high-risk injection points** if user input is interpolated directly
- Mass assignment vulnerabilities occur when `$fillable` or `$guarded` model properties are misconfigured, allowing attackers to set unintended database fields (e.g., `is_admin = 1`)
- Eloquent relationships (hasMany, belongsTo) can inadvertently expose sensitive related records if **authorization checks** (Gates/Policies) are absent — an IDOR vulnerability pattern
- Logging raw Eloquent queries in production can leak schema details and sensitive data into log files accessible to attackers

## Related concepts
[[SQL Injection]] [[Mass Assignment Vulnerability]] [[Insecure Direct Object Reference]]