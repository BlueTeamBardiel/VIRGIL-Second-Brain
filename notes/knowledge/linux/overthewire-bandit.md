# OverTheWire Bandit

Bandit is a beginner-friendly [[wargame]] that teaches fundamental [[Linux]] command‑line skills through progressive levels. Designed for absolute beginners, it provides the foundational knowledge needed to tackle more advanced security challenges.

## Overview

- **Purpose**: Teach basics of command-line usage and Linux fundamentals
- **Structure**: Progressive levels (Level 0 onwards)
- **Difficulty**: Beginner‑friendly
- **Format**: Each level provides credentials and objectives to reach the next level

## Learning Approach

When stuck:
1. Consult [[man]] pages: `man <command>`
2. Use shell built‑in help: `help <command>`
3. Search online (Google recommended)
4. Join OverTheWire chat for community support

## Getting Started

- Begin at Level 0 (linked from sidebar)
- Read instructions for each level before attempting
- Expect to encounter unfamiliar concepts—this is intentional learning
- Understand that reading documentation is part of the skill‑building process

## Connection Issues

VMs experiencing "broken pipe error" over [[SSH]]:
- Add `IPQoS throughput` to `/etc/ssh/ssh_config`
- If unresolved, switch network adapter from NAT to Bridged mode

## Tags

#wargame #linux #beginners #ctf #overthewire #command-line

---

## What Is It? (Feynman Version)

Bandit is a training playground that turns a bare‑bones Linux box into a step‑by‑step puzzle book.  
Think of it as a maze where each door is guarded by a password; you learn the keys to unlock the next door by mastering everyday shell commands.

## Why Does It Exist?

Before Bandit, newcomers had to wade through vague tutorials or guess at shell commands without feedback.  
The challenge fills a gap: it gives a hands‑on, fail‑and‑retry environment where the cost of mistakes is just learning time, not data loss or system compromise.  
In real security work, novices often mis‑type commands or mis‑interpret output, leading to misconfigurations that can expose services. Bandit prevents that by offering a safe sandbox to practice.

## How It Works (Under the Hood)

1. **Server Setup**  
   A remote Linux VM runs a minimal environment. Each level is a separate user account (`bandit0`, `bandit1`, …).  
2. **Authentication**  
   You connect via SSH using the username and password for the current level (starting at level 0).  
3. **Objective Delivery**  
   Each level’s README (visible via `cat` or `more`) outlines a puzzle: “Find the file containing the password for the next level.”  
4. **Progression**  
   You locate the target file, read its contents (often via `cat`, `grep`, or `awk`), and then log out.  
   On the next level you use the extracted password to SSH as the next user.  
5. **Hints & Feedback**  
   No external hints are provided; the puzzle relies solely on Linux command knowledge. The server does not track time or score—just the ability to reach the next level.

## What Breaks When It Goes Wrong?

- **Lost Progress**: If you lose a password (e.g., mis‑type a file name), you might need to SSH out and re‑attempt, wasting time.
- **Credential Mis‑management**: Using wrong credentials can lock you out of the next level, forcing a full restart.
- **System Mis‑configuration**: If the SSH daemon on the server is mis‑configured (e.g., missing `PasswordAuthentication`), none of the levels are reachable, halting learning.
- **Network Issues**: Intermittent connectivity (broken pipe errors) can make it impossible to complete a level, causing frustration.

The human cost is primarily lost hours of productive learning and the psychological penalty of repeated failures. In a corporate training scenario, this would translate to lower confidence and slower onboarding.

## Lab Relevance

| What to Try | Command / Config | What to Watch |
|-------------|------------------|---------------|
| **SSH into a local challenge** | `ssh bandit0@localhost -p 2222` | Verify that `sshd` listens on the correct port; ensure `/etc/ssh/sshd_config` permits password auth. |
| **File discovery** | `find / -perm -4000 -type f 2>/dev/null` | Search for set‑uid binaries; remember to redirect errors. |
| **Privilege escalation basics** | `sudo -l` (if sudoers configured) | Understand how sudo can grant limited root access. |
| **Network troubleshooting** | `ping -c 3 google.com` | Detect if DNS resolution or connectivity is broken. |
| **SSH client tweak** | Add `IPQoS throughput` to `~/.ssh/config` | Resolve “broken pipe” when the server is slow or the network is congested. |

### Hands‑On Exercise

1. **Spin up a container**: `docker run -d -p 2222:22 --name bandit overthewire/bandit`  
2. **SSH in**: `ssh bandit0@localhost -p 2222` (password: `bandit0`).  
3. **Follow the README** to locate the next password.  
4. **Experiment**: try `ls -laR`, `cat`, `grep`, and `chmod` on various files to see how permissions affect access.

Watching what fails (e.g., permission denied, command not found) reinforces the importance of correct file ownership and executable flags in real systems.

---

_Ingested: 2026-04-15 20:22 | Source: https://overthewire.org/wargames/bandit/_