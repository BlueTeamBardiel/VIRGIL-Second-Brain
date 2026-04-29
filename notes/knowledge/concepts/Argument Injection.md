# argument injection

## What it is
Like slipping a fake ingredient label onto a spice jar before handing it to a chef — the program accepts your input, but you've embedded extra instructions the developer never intended. Argument injection occurs when an attacker inserts additional command-line arguments or flags into input that gets passed to an external process, altering the program's behavior without breaking its syntax.

## Why it matters
A classic example is CVE-2016-3714 (ImageMagick's "ImageTragick"), where filenames passed to ImageMagick contained injected arguments that caused it to execute arbitrary shell commands during image processing. Web apps that shell out to utilities like `curl`, `git`, `ffmpeg`, or `rsync` are prime targets — a user-supplied filename of `--config=/tmp/evil.conf` can completely redirect program behavior.

## Key facts
- Argument injection differs from command injection: in command injection you inject *new commands* (`;`, `&&`, `|`), while in argument injection you inject *flags/options* into an existing command call
- The leading dash (`-` or `--`) is the telltale signal — inputs starting with a dash can be interpreted as options rather than data
- Mitigated by using `--` (double-dash) as an end-of-options separator, which tells most Unix programs to treat all subsequent input as literal arguments, not flags
- Affects many common tools: `curl --upload-file`, `ssh`, `git clone`, `wget`, and `rsync` are frequently exploited vectors
- Input validation alone is insufficient; proper API usage (avoiding shell invocation entirely) or explicit argument separation is required for robust defense

## Related concepts
[[command injection]] [[OS command injection]] [[input validation]] [[shell metacharacters]] [[insecure direct object reference]]