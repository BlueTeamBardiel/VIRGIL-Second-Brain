#!/usr/bin/env python3
"""
llm_client.py — LLM inference wrapper with automatic fallback.

Chain: BEHEMOTH Ollama (gpt-oss:20b) → ABADDON Ollama (qwen2.5:14b) → Anthropic API

As a module:
    from llm_client import ask
    text = ask("Summarize this", system="You are VIRGIL.")

As a script:
    python3 llm_client.py [OPTIONS] "prompt"
    echo "prompt" | python3 llm_client.py [OPTIONS]

Options:
    -s/--system TEXT       System prompt
    -m/--model MODEL       Override model
    -b/--backend NAME      Force: behemoth | abaddon | anthropic
    -t/--timeout N         Per-backend timeout in seconds (default: 60)
    --max-tokens N         Max tokens (default: 2048)

Exit codes: 0=ok, 1=all backends failed
"""

import json
import os
import subprocess
import sys
import urllib.error
import urllib.request
from typing import Optional

# ── Config ────────────────────────────────────────────────────────────────────
BEHEMOTH_URL    = "http://localhost:11434"
ABADDON_URL     = os.environ.get("ABADDON_OLLAMA_URL", "http://abaddon:11434")
ANTHROPIC_URL   = "https://api.anthropic.com/v1/messages"

MODEL_BEHEMOTH  = "gpt-oss:20b"
MODEL_ABADDON   = "qwen2.5:14b"
MODEL_ANTHROPIC = "claude-haiku-4-5-20251001"

FALLBACK_ORDER  = ["behemoth", "abaddon", "anthropic"]


class LLMError(RuntimeError):
    pass


# ── Internal helpers ──────────────────────────────────────────────────────────

def _get_anthropic_key() -> str:
    key = os.environ.get("ANTHROPIC_API_KEY", "")
    if key:
        return key
    try:
        cron = subprocess.check_output(
            ["crontab", "-l"], stderr=subprocess.DEVNULL, text=True
        )
        for line in cron.splitlines():
            if "ANTHROPIC_API_KEY" in line and "=" in line:
                val = line.split("=", 1)[1].strip().strip('"').strip("'")
                return val
    except Exception:
        pass
    return ""


def _ollama_call(
    url: str,
    model: str,
    prompt: str,
    system: Optional[str],
    max_tokens: int,
    timeout: int,
) -> str:
    messages = []
    if system:
        messages.append({"role": "system", "content": system})
    messages.append({"role": "user", "content": prompt})

    payload = json.dumps({
        "model": model,
        "messages": messages,
        "stream": False,
        "options": {"num_predict": max_tokens},
    }).encode()

    req = urllib.request.Request(
        f"{url}/api/chat",
        data=payload,
        headers={"Content-Type": "application/json"},
    )
    try:
        with urllib.request.urlopen(req, timeout=timeout) as r:
            body = json.loads(r.read())
    except urllib.error.URLError as e:
        raise LLMError(f"{url} unreachable: {e}") from e
    except json.JSONDecodeError as e:
        raise LLMError(f"{url} bad JSON response: {e}") from e

    if "error" in body:
        raise LLMError(f"{url} error: {body['error']}")
    try:
        return body["message"]["content"]
    except KeyError as e:
        raise LLMError(f"{url} unexpected response shape: {e}") from e


def _anthropic_call(
    model: str,
    prompt: str,
    system: Optional[str],
    max_tokens: int,
    timeout: int,
) -> str:
    api_key = _get_anthropic_key()
    if not api_key:
        raise LLMError("ANTHROPIC_API_KEY not set")

    payload_dict: dict = {
        "model": model,
        "max_tokens": max_tokens,
        "messages": [{"role": "user", "content": prompt}],
    }
    if system:
        payload_dict["system"] = system

    payload = json.dumps(payload_dict).encode()
    req = urllib.request.Request(
        ANTHROPIC_URL,
        data=payload,
        headers={
            "x-api-key": api_key,
            "anthropic-version": "2023-06-01",
            "content-type": "application/json",
        },
    )
    try:
        with urllib.request.urlopen(req, timeout=timeout) as r:
            body = json.loads(r.read())
        return body["content"][0]["text"]
    except urllib.error.HTTPError as e:
        detail = e.read().decode(errors="replace")[:300]
        raise LLMError(f"HTTP {e.code}: {detail}") from e
    except (urllib.error.URLError, KeyError, json.JSONDecodeError) as e:
        raise LLMError(f"Anthropic error: {e}") from e


# ── Public API ────────────────────────────────────────────────────────────────

def ask(
    prompt: str,
    system: Optional[str] = None,
    model: Optional[str] = None,
    backend: Optional[str] = None,
    max_tokens: int = 2048,
    timeout: int = 60,
) -> str:
    """
    Query LLM with automatic fallback: BEHEMOTH → ABADDON → Anthropic.

    Args:
        prompt:     User message.
        system:     Optional system prompt.
        model:      Override model name (applied to whichever backend is used).
        backend:    Force a specific backend; skips fallback if set.
        max_tokens: Maximum tokens in response.
        timeout:    Per-backend network timeout in seconds.

    Returns:
        Response text as a string.

    Raises:
        LLMError: If all backends fail (or the forced backend fails).
    """
    order = [backend] if backend else ([os.environ["VIRGIL_LLM_BACKEND"]] if os.environ.get("VIRGIL_LLM_BACKEND") else FALLBACK_ORDER)
    errors: list[str] = []

    for b in order:
        try:
            if b == "behemoth":
                m = model or MODEL_BEHEMOTH
                print(f"[llm_client] trying BEHEMOTH ({m})", file=sys.stderr)
                return _ollama_call(BEHEMOTH_URL, m, prompt, system, max_tokens, timeout)

            elif b == "abaddon":
                m = model or MODEL_ABADDON
                print(f"[llm_client] trying ABADDON ({m})", file=sys.stderr)
                return _ollama_call(ABADDON_URL, m, prompt, system, max_tokens, timeout)

            elif b == "anthropic":
                m = model or MODEL_ANTHROPIC
                print(f"[llm_client] trying Anthropic ({m})", file=sys.stderr)
                return _anthropic_call(m, prompt, system, max_tokens, timeout)

            else:
                raise LLMError(f"Unknown backend: {b!r}")

        except LLMError as e:
            print(f"[llm_client] {b} failed: {e}", file=sys.stderr)
            errors.append(f"{b}: {e}")

    raise LLMError("All backends failed:\n" + "\n".join(errors))


# ── CLI ───────────────────────────────────────────────────────────────────────

def main() -> None:
    import argparse

    parser = argparse.ArgumentParser(
        description="LLM wrapper: BEHEMOTH → ABADDON → Anthropic",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=__doc__,
    )
    parser.add_argument("prompt", nargs="?", help="Prompt text (or pipe via stdin)")
    parser.add_argument("-s", "--system",    default="",   metavar="TEXT",    help="System prompt")
    parser.add_argument("-m", "--model",     default="",   metavar="MODEL",   help="Override model")
    parser.add_argument("-b", "--backend",   default="",   metavar="NAME",    help="Force backend")
    parser.add_argument("-t", "--timeout",   type=int, default=60,            help="Timeout per backend (s)")
    parser.add_argument("--max-tokens",      type=int, default=2048,          help="Max response tokens")
    args = parser.parse_args()

    prompt = args.prompt if args.prompt else sys.stdin.read()
    if not prompt.strip():
        parser.error("no prompt provided (pass as arg or pipe via stdin)")

    try:
        result = ask(
            prompt.strip(),
            system=args.system   or None,
            model=args.model     or None,
            backend=args.backend or None,
            max_tokens=args.max_tokens,
            timeout=args.timeout,
        )
        print(result)
    except LLMError as e:
        print(f"[llm_client] fatal: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
