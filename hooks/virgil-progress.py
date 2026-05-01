#!/usr/bin/env python3
"""virgil-progress.py — Cert domain mastery tracker.

Reads quiz-scores.json, maps topics to exam domains by keyword,
and shows % mastery per domain, weakest domain, review queue, ETA to 70%.

Usage:
  python3 hooks/virgil-progress.py [--cert secplus|cysa|ccna|all]
"""

from __future__ import annotations

import argparse
import json
import os
import sys
from datetime import date
from pathlib import Path

VIRGIL_DIR = Path(os.environ.get("VIRGIL_DIR", Path.home() / "VIRGIL"))
SCORES_FILE = VIRGIL_DIR / "logs" / "quiz-scores.json"

# ── Domain keyword maps ───────────────────────────────────────────────────────

DOMAIN_MAPS: dict[str, dict[str, list[str]]] = {
    "secplus": {
        "1 — General Security Concepts": [
            "cryptography", "aes", "rsa", "pki", "certificate", "hashing", "sha",
            "symmetric", "asymmetric", "key exchange", "authentication", "mfa",
            "totp", "biometric", "kerberos", "ntlm", "saml", "oauth", "jwt",
            "sso", "ldap", "radius", "tacacs",
        ],
        "2 — Threats, Vulnerabilities and Mitigations": [
            "malware", "ransomware", "trojan", "rootkit", "spyware", "adware",
            "worm", "virus", "botnet", "apt", "phishing", "spearphishing",
            "vishing", "smishing", "social engineering", "sql injection", "sqli",
            "xss", "csrf", "ssrf", "buffer overflow", "race condition", "idor",
            "rce", "lfi", "rfi", "xxe", "privilege escalation", "kerberoasting",
            "pass the hash", "lateral movement", "zero day", "cve", "cwe",
        ],
        "3 — Security Architecture": [
            "firewall", "ids", "ips", "waf", "siem", "soc", "dmz", "vlan",
            "vpn", "nat", "proxy", "load balancer", "cloud", "aws", "azure",
            "gcp", "zero trust", "microsegmentation", "sdp", "sd-wan",
            "container", "docker", "kubernetes", "serverless", "iam",
        ],
        "4 — Security Operations": [
            "incident response", "forensics", "dfir", "chain of custody",
            "log analysis", "threat hunting", "vulnerability scan", "pentest",
            "osint", "reconnaissance", "nmap", "metasploit", "burp suite",
            "wireshark", "tcpdump", "mitre", "att&ck", "ioc", "ioa",
            "playbook", "runbook", "soar",
        ],
        "5 — Security Program Management": [
            "risk", "compliance", "gdpr", "hipaa", "pci dss", "nist", "iso",
            "cis", "policy", "procedure", "bcp", "drp", "rto", "rpo",
            "awareness training", "audit", "governance",
        ],
    },
    "cysa": {
        "1 — Security Operations": [
            "siem", "soc", "log", "alert", "triage", "monitoring", "dashboard",
            "splunk", "elastic", "kibana", "netflow", "syslog",
        ],
        "2 — Vulnerability Management": [
            "vulnerability", "scan", "nessus", "openvas", "cvss", "cve",
            "patch", "remediation", "risk rating", "asset inventory",
        ],
        "3 — Incident Response": [
            "incident", "response", "forensics", "dfir", "containment",
            "eradication", "recovery", "lessons learned", "chain of custody",
            "evidence", "ioc", "timeline",
        ],
        "4 — Reporting and Communication": [
            "report", "metrics", "kpi", "dashboard", "communication",
            "stakeholder", "executive", "brief",
        ],
        "5 — Identity and Access Management": [
            "identity", "access", "iam", "privilege", "rbac", "least privilege",
            "pam", "mfa", "sso", "directory", "active directory", "ldap",
        ],
    },
    "ccna": {
        "1 — Network Fundamentals": [
            "osi", "tcp", "udp", "ip", "mac", "arp", "ethernet", "frame",
            "packet", "subnet", "cidr", "ipv4", "ipv6", "dns", "dhcp",
            "nat", "switching", "collision domain", "broadcast domain",
        ],
        "2 — Network Access": [
            "vlan", "trunk", "stp", "spanning tree", "rstp", "port security",
            "802.1x", "wireless", "wifi", "ssid", "wpa", "access point",
        ],
        "3 — IP Connectivity": [
            "routing", "router", "static route", "rip", "ospf", "eigrp",
            "bgp", "default route", "convergence", "metric", "administrative distance",
        ],
        "4 — IP Services": [
            "dhcp", "dns", "ntp", "snmp", "netflow", "qos", "nat", "pat",
            "acl", "access list",
        ],
        "5 — Security Fundamentals": [
            "firewall", "acl", "ipsec", "vpn", "aaa", "tacacs", "radius",
            "dhcp snooping", "arp inspection", "port security",
        ],
        "6 — Automation and Programmability": [
            "python", "ansible", "netconf", "restconf", "json", "yaml",
            "api", "automation", "devops", "infrastructure as code",
        ],
    },
    "netplus": {
        "1 — Networking Concepts": [
            "ip addressing", "subnetting", "routing", "switching", "dns", "dhcp",
            "nat", "vlan", "ospf", "bgp", "tcp", "udp", "osi model", "ethernet",
            "wifi", "wireless", "ipv4", "ipv6", "mac", "arp", "cidr",
        ],
        "2 — Network Implementation": [
            "configure", "router", "switch", "firewall", "access point", "cable",
            "fiber", "copper", "ssid", "wpa", "vlan", "trunk", "port", "interface",
            "sfp", "poe", "qos",
        ],
        "3 — Network Operations": [
            "monitoring", "syslog", "snmp", "netflow", "baseline", "documentation",
            "diagram", "change management", "backup", "patch", "update",
        ],
        "4 — Network Security": [
            "firewall", "acl", "vpn", "ids", "ips", "zero trust", "authentication",
            "radius", "tacacs", "wpa3", "threat", "vulnerability", "hardening",
        ],
        "5 — Network Troubleshooting": [
            "troubleshoot", "latency", "jitter", "packet loss", "ping", "traceroute",
            "nslookup", "ipconfig", "netstat", "cable tester", "loopback", "duplex",
        ],
    },
    "sdr": {
        "1 — RF Fundamentals": [
            "frequency", "wavelength", "amplitude", "modulation", "bandwidth",
            "spectrum", "signal", "noise", "antenna", "gain", "decibel", "db",
            "propagation", "polarization",
        ],
        "2 — Digital Signal Processing": [
            "sample rate", "nyquist", "fft", "filter", "demodulation", "iq signal",
            "baseband", "decimation", "interpolation", "convolution", "windowing",
        ],
        "3 — Hardware": [
            "rtl-sdr", "hackrf", "sdrplay", "gnu radio", "sdr#", "gqrx", "dongle",
            "tuner", "upconverter", "lna", "bias tee", "coax", "connector",
        ],
        "4 — Applications": [
            "adsb", "acars", "noaa", "weather satellite", "pager", "trunking",
            "p25", "dmr", "aprs", "pocsag", "ais", "vor", "rx",
        ],
    },
}

# ── Ingested content helpers ──────────────────────────────────────────────────

def load_ingested_topics(cert_slug: str) -> list[str]:
    """Load topic names from ingested cert notes to supplement keyword matching."""
    cert_dir = VIRGIL_DIR / "notes" / "knowledge" / cert_slug
    if not cert_dir.exists():
        return []
    topics = []
    for note in cert_dir.glob("*.md"):
        if note.stem.lower() in {"index", "readme"}:
            continue
        stem = note.stem.lower()
        parts = stem.split("-", 2)
        topic = parts[2].replace("-", " ") if len(parts) >= 3 else stem.replace("-", " ")
        topics.append(topic)
    return topics


def match_topic(topic: str, keywords: list[str]) -> bool:
    """Check whether topic matches any keyword."""
    t = topic.lower()
    return any(kw in t for kw in keywords)


def match_topic_enhanced(topic: str, keywords: list[str], cert_slug: str) -> bool:
    """Match topic against hardcoded keywords AND ingested vault content."""
    if match_topic(topic, keywords):
        return True
    ingested = load_ingested_topics(cert_slug)
    t = topic.lower()
    return any(ing in t or t in ing for ing in ingested)


# ── Scoring helpers ───────────────────────────────────────────────────────────

def load_scores() -> dict:
    if not SCORES_FILE.exists():
        return {}
    try:
        return json.loads(SCORES_FILE.read_text(encoding="utf-8"))
    except Exception:
        return {}


def topic_ratio(info: dict) -> float:
    out_of = info.get("out_of", 5)
    score = info.get("score", 0)
    return score / out_of if out_of > 0 else 0.0


def is_overdue(info: dict) -> bool:
    nr = info.get("next_review")
    if not nr:
        return False
    try:
        return date.fromisoformat(nr) <= date.today()
    except ValueError:
        return False


def map_topics_to_domain(scores: dict, cert: str) -> dict[str, list[tuple[str, float]]]:
    """Returns {domain_name: [(topic, ratio), ...]}."""
    domains = DOMAIN_MAPS.get(cert, {})
    result: dict[str, list[tuple[str, float]]] = {d: [] for d in domains}

    for topic, info in scores.items():
        matched = False
        for domain, keywords in domains.items():
            if match_topic_enhanced(topic, keywords, cert):
                result[domain].append((topic, topic_ratio(info)))
                matched = True
                break
        if not matched:
            result.setdefault("Uncategorized", []).append((topic, topic_ratio(info)))

    return result


def render_cert(cert: str, scores: dict, today: str) -> None:
    label = cert.upper()
    domains = map_topics_to_domain(scores, cert)

    total_topics = sum(len(v) for v in domains.values())
    if total_topics == 0:
        print(f"\n  {label}: no quiz data yet — run virgil-quiz to start tracking")
        return

    print(f"\n  {'─' * 44}")
    print(f"  {label} Domain Mastery")
    print(f"  {'─' * 44}")

    domain_avgs: list[tuple[str, float, int]] = []
    for domain, entries in domains.items():
        if not entries:
            continue
        avg = sum(r for _, r in entries) / len(entries)
        domain_avgs.append((domain, avg, len(entries)))

    domain_avgs.sort(key=lambda x: x[1])  # weakest first

    for domain, avg, count in domain_avgs:
        pct = int(avg * 100)
        bar_filled = int(pct / 5)
        bar = "█" * bar_filled + "░" * (20 - bar_filled)
        flag = " ← weakest" if domain == domain_avgs[0][0] else ""
        print(f"  {domain[:38]:<38} {pct:3d}% [{bar}] ({count} topics){flag}")

    overall = sum(a for _, a, _ in domain_avgs) / len(domain_avgs) if domain_avgs else 0
    print(f"\n  Overall: {int(overall * 100)}%  |  Target: 70%")

    if overall < 0.70:
        gap = 0.70 - overall
        topics_to_improve = max(1, int(gap * total_topics * 2))
        print(f"  ETA to 70%: quiz ~{topics_to_improve} more topics")

    # Review queue
    due = [(t, i) for t, i in scores.items() if is_overdue(i)]
    if due:
        print(f"\n  Due for review ({len(due)} topics):")
        for t, i in sorted(due, key=lambda x: x[1].get("next_review", ""))[:5]:
            nr = i.get("next_review", "?")
            pct = int(topic_ratio(i) * 100)
            print(f"    {t:<35} last: {pct}%  due: {nr}")
        if len(due) > 5:
            print(f"    … and {len(due) - 5} more")


# ── Main ──────────────────────────────────────────────────────────────────────

def main() -> None:
    ap = argparse.ArgumentParser(description="VIRGIL cert domain mastery tracker")
    ap.add_argument(
        "--cert",
        choices=["secplus", "cysa", "ccna", "netplus", "sdr", "all"],
        default="all",
        help="Which cert to show (default: all)",
    )
    args = ap.parse_args()

    today = date.today().isoformat()
    scores = load_scores()

    print(f"\n{'═' * 48}")
    print(f"  VIRGIL Progress — {today}")
    print(f"{'═' * 48}")

    if not scores:
        print("\n  No quiz data found.")
        print(f"  Scores file: {SCORES_FILE}")
        print("\n  Run 'virgil-quiz' to start tracking your knowledge.")
        print(f"{'═' * 48}\n")
        return

    certs = ["secplus", "cysa", "ccna", "netplus", "sdr"] if args.cert == "all" else [args.cert]
    for cert in certs:
        render_cert(cert, scores, today)

    print(f"\n{'═' * 48}\n")


if __name__ == "__main__":
    main()
