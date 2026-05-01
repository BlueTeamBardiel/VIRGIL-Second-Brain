#!/usr/bin/env python3
"""
llm_client.py — LLM inference wrapper with automatic fallback.

Chain: Primary Ollama → Secondary Ollama → Anthropic API

As a module:
    from llm_client import ask
    text = ask("Summarize this", system="You are VIRGIL.")

As a script:
    python3 llm_client.py [OPTIONS] "prompt"
    echo "prompt" | python3 llm_client.py [OPTIONS]

Options:
    -s/--system TEXT       System prompt
    -m/--model MODEL       Override model
    -b/--backend NAME      Force: primary | secondary | anthropic
    -t/--timeout N         Per-backend timeout in seconds (default: 60)
    --max-tokens N         Max tokens (default: 2048)

Environment variables:
    VIRGIL_PRIMARY_OLLAMA_URL    Primary Ollama endpoint (default: http://localhost:11434)
    VIRGIL_SECONDARY_OLLAMA_URL  Secondary Ollama endpoint (optional, skip if unset)
    VIRGIL_PRIMARY_MODEL         Model for primary Ollama (default: llama3.2)
    VIRGIL_SECONDARY_MODEL       Model for secondary Ollama (default: qwen2.5:14b)
    VIRGIL_LLM_BACKEND           Force a backend: primary | secondary | anthropic
    ANTHROPIC_API_KEY            Required for Anthropic backend

Exit codes: 0=ok, 1=all backends failed
"""

import json
import os
import sys
import tempfile
import time
import urllib.error
import urllib.request
from pathlib import Path
from typing import Optional

# ── Config ────────────────────────────────────────────────────────────────────
PRIMARY_URL     = os.environ.get("VIRGIL_PRIMARY_OLLAMA_URL", "http://localhost:11434")
SECONDARY_URL   = os.environ.get("VIRGIL_SECONDARY_OLLAMA_URL", "")
ANTHROPIC_URL   = "https://api.anthropic.com/v1/messages"

MODEL_PRIMARY   = os.environ.get("VIRGIL_PRIMARY_MODEL", "llama3.2")
MODEL_SECONDARY = os.environ.get("VIRGIL_SECONDARY_MODEL", "qwen2.5:14b")
MODEL_ANTHROPIC = "claude-haiku-4-5-20251001"

FALLBACK_ORDER  = ["primary", "secondary", "anthropic"]

# ── Circuit breaker ───────────────────────────────────────────────────────────
# After CIRCUIT_THRESHOLD consecutive failures a backend is skipped for
# CIRCUIT_COOLDOWN seconds.  State persists in a tmp file so it survives
# across subprocess calls within the same cron job.
CIRCUIT_THRESHOLD = 3
CIRCUIT_COOLDOWN  = 300  # 5 minutes
_CB_FILE = Path(tempfile.gettempdir()) / "virgil_circuit_breaker.json"


def _cb_load() -> dict:
    try:
        return json.loads(_CB_FILE.read_text())
    except Exception:
        return {}


def _cb_save(state: dict) -> None:
    try:
        _CB_FILE.write_text(json.dumps(state))
    except Exception:
        pass


def _cb_is_open(backend: str) -> bool:
    """Return True if the circuit is open (backend should be skipped)."""
    state = _cb_load()
    entry = state.get(backend, {})
    if entry.get("failures", 0) >= CIRCUIT_THRESHOLD:
        opened_at = entry.get("opened_at", 0)
        if time.time() - opened_at < CIRCUIT_COOLDOWN:
            return True
        # Cooldown expired — reset and allow retry
        entry["failures"] = 0
        state[backend] = entry
        _cb_save(state)
    return False


def _cb_record_failure(backend: str) -> None:
    state = _cb_load()
    entry = state.get(backend, {"failures": 0})
    entry["failures"] = entry.get("failures", 0) + 1
    if entry["failures"] >= CIRCUIT_THRESHOLD:
        entry["opened_at"] = time.time()
    state[backend] = entry
    _cb_save(state)


def _cb_record_success(backend: str) -> None:
    state = _cb_load()
    state[backend] = {"failures": 0}
    _cb_save(state)


class LLMError(RuntimeError):
    pass


# ── Internal helpers ──────────────────────────────────────────────────────────

def _get_anthropic_key() -> str:
    return os.environ.get("ANTHROPIC_API_KEY", "")


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
    Query LLM with automatic fallback: Primary Ollama → Secondary Ollama → Anthropic.

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
    order = (
        [backend] if backend
        else ([os.environ["VIRGIL_LLM_BACKEND"]] if os.environ.get("VIRGIL_LLM_BACKEND")
              else FALLBACK_ORDER)
    )
    errors: list[str] = []

    for b in order:
        # Circuit breaker: skip backends that have failed repeatedly
        if _cb_is_open(b):
            msg = f"{b}: circuit open (>{CIRCUIT_THRESHOLD} recent failures — cooldown {CIRCUIT_COOLDOWN}s)"
            print(f"[llm_client] skipping {b} — circuit open", file=sys.stderr)
            errors.append(msg)
            continue

        try:
            if b == "primary":
                m = model or MODEL_PRIMARY
                print(f"[llm_client] trying primary ollama ({m})", file=sys.stderr)
                result = _ollama_call(PRIMARY_URL, m, prompt, system, max_tokens, timeout)

            elif b == "secondary":
                if not SECONDARY_URL:
                    raise LLMError("VIRGIL_SECONDARY_OLLAMA_URL not set — skipping secondary")
                m = model or MODEL_SECONDARY
                print(f"[llm_client] trying secondary ollama ({m})", file=sys.stderr)
                result = _ollama_call(SECONDARY_URL, m, prompt, system, max_tokens, timeout)

            elif b == "anthropic":
                m = model or MODEL_ANTHROPIC
                print(f"[llm_client] trying Anthropic ({m})", file=sys.stderr)
                result = _anthropic_call(m, prompt, system, max_tokens, timeout)

            else:
                raise LLMError(f"Unknown backend: {b!r}")

            _cb_record_success(b)
            return result

        except LLMError as e:
            print(f"[llm_client] {b} failed: {e}", file=sys.stderr)
            _cb_record_failure(b)
            errors.append(f"{b}: {e}")

    raise LLMError("All backends failed:\n" + "\n".join(errors))


# ── CLI ───────────────────────────────────────────────────────────────────────

def main() -> None:
    import argparse

    parser = argparse.ArgumentParser(
        description="LLM wrapper: Primary Ollama → Secondary Ollama → Anthropic",
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
