# Syslog
**Tagline:** Master centralized device logging to troubleshoot network problems faster and meet compliance requirements.

---

## Why Syslog Matters for CCNA

[[Syslog]] is the standard protocol for collecting and managing log messages from network devices. Instead of logging only locally on each device, Syslog sends messages to a centralized server, giving you visibility across your entire network. This is essential for troubleshooting, security auditing, and compliance. The CCNA exam tests your ability to configure Syslog, interpret message formats, and understand severity levels.

---

## Core Concept: What is Syslog?

**Simple analogy:** Think of Syslog like a security camera system. Each network device (switch, router) records events (the "footage"). Instead of checking each device individually, Syslog sends all those events to one central server (the monitoring station) where you can review everything in one place.

**Real definition:** [[Syslog]] is a protocol (defined in [[RFC 3164]] and [[RFC 5424]]) that allows network devices to send standardized log messages to a centralized Syslog server. It runs on [[UDP port 514]] by default, making it lightweight and fast. Syslog messages include information about device events, errors, warnings, and debug output—critical data for network operations and security investigations.

---

## 7.1: Viewing Device Logs

### Real-Time Logging

When you're connected to a Cisco device via console or [[SSH]], you can see log messages appear in real time as events happen.

**The Problem:** By default, logging messages interrupt your command-line input, making configuration difficult.

```
Router# 
%LINK-5-CHANGED: Interface GigabitEthernet0/0, changed state to up
```

Notice how the log message interrupted your prompt? This makes working on the device frustrating.

### The `logging synchronous` Command

This command buffers log messages so they don't interrupt your typing. When you press Enter, the buffered messages appear *after* your command output.

**Syntax:**
```
Router(config)# line console 0
Router(config-line)# logging synchronous
Router(config-line)# exit

Router(config)# line vty 0 4
Router(config-line)# logging synchronous
Router(config-line)# exit
```

**Effect:** Log messages now appear cleanly without disrupting your work.

### Storing Logs Locally

By default, logs appear in the console but are lost when the device reboots. You can store them in the device's **internal buffer** using:

```
Router(config)# logging buffered 4096
```

This creates a 4,096-byte circular buffer in RAM. View buffered logs with:

```
Router# show logging
```

This displays the internal log buffer contents plus logging configuration.

---

## 7.2: The Syslog Message Format

### Standard Message Structure

Every [[Syslog]] message follows a defined format:

| Component | Example | Purpose |
|-----------|---------|---------|
| **Priority** | `<166>` | Facility (×8) + Severity level |
| **Timestamp** | `Mar 10 14:23:15` | When the event occurred |
| **Hostname** | `Router1` | Which device generated the message |
| **Tag/Process** | `LINK-5-CHANGED:` | Message identifier and severity |
| **Message Body** | `Interface Fa0/0 changed to up` | Detailed description |

**Example full message:**
```
Mar 10 14:23:15 Router1 %LINK-5-CHANGED: Interface FastEthernet0/0, changed state to up
```

### Sequence Numbers and Timestamps

Modern Syslog configuration can prepend sequence numbers to track message ordering and timestamps to microsecond precision. Enable with:

```
Router(config)# service sequence-numbers
Router(config)# service timestamps log datetime msec
```

Now messages look like:
```
1: Mar 10 14:23:15.547 Router1 %LINK-5-CHANGED: ...
2: Mar 10 14:23:16.123 Router1 %LINK-5-CHANGED: ...
```

This is critical when debugging issues where timing matters.

### Syslog Severity Levels

Syslog uses 8 severity levels (0–7) to categorize message urgency. Understanding these is **critical for the exam**.

| Level | Name | Keyword | Meaning | Example |
|-------|------|---------|---------|---------|
| 0 | Emergency | `emerg` | System is unusable | CPU at 100%, device crashing |
| 1 | Alert | `alert` | Immediate action required | Power supply failure |
| 2 | Critical | `crit` | Critical condition | Memory exhausted |
| 3 | Error | `err` | Error condition | Interface down, packet loss |
| 4 | Warning | `warn` | Warning condition | High CPU (80%) |
| 5 | Notice | `notice` | Normal but significant | Configuration change |
| 6 | Informational | `info` | Informational messages | Interface up |
| 7 | Debug | `debug` | Debug-level messages | Packet-by-packet details |

**Key exam point:** Higher number = *lower* severity. Many students get this backwards. A level 7 (debug) is chatty but not urgent. A level 0 (emergency) is critical.

### The Debug Command

The `debug` command enables real-time diagnostic output showing detailed operational information.

**Common debug commands for CCNA:**

```
Router# debug ip packets
Router# debug ip routing
Router# debug ip eigrp packets
Router# debug interface
Router# debug spanning-tree events
```

**Critical warning:** Debug output consumes CPU cycles heavily. Use only when necessary and on a console connection (not a remote SSH session—you could lock yourself out). Disable with:

```
Router# undebug all
Router# u all  (shortcut)
```

---

## Configuring Syslog on Cisco IOS

### Basic Syslog Server Configuration

Tell the device where to send logs:

```
Router(config)# logging 192.168.1.100
```

This sends all log messages to the Syslog server at 192.168.1.100 (UDP port 514).

### Filtering by Severity Level

You can specify the minimum severity level to send. Only messages at that severity or higher are transmitted:

```
Router(config)# logging trap informational
```

This sends levels 0–6 (emergency through informational). Debug messages (level 7) are excluded. Common severity filters:

| Command | Levels Sent | Use Case |
|---------|-------------|----------|
| `logging trap emergencies` | 0 only | Minimal traffic, only critical |
| `logging trap errors` | 0–3 | Typical production setting |
| `logging trap warnings` | 0–4 | More detail for troubleshooting |
| `logging trap informational` | 0–6 | Comprehensive logging |
| `logging trap debug` | 0–7 | Verbose; test environments only |

### Naming the Syslog Server

For clarity, assign a hostname to your Syslog server:

```
Router(config)# logging host 192.168.1.100
Router(config)# logging host 192.168.1.101
```

You can configure multiple Syslog servers for redundancy.

### Enabling Logging to Console and Buffer

```
Router(config)# logging console informational
Router(config)# logging buffered 32768 informational
```

- `logging console informational`: Send info-level and higher to the console terminal
- `logging buffered 32768 informational`: Store up to 32KB of info-level logs in RAM

### Complete Configuration Example

```
Router(config)# service timestamps log datetime msec
Router(config)# service sequence-numbers
Router(config)# logging 192.168.1.100
Router(config)# logging trap warnings
Router(config)# logging buffered 16384
Router(config)# line console 0
Router(config-line)# logging synchronous
Router(config-line)# exit
```

### Verify Configuration

```
Router# show logging
Syslog logging: enabled (0 messages dropped, 0 messages rate-limited)
    Console logging: level debugging, 45 messages logged
    Monitor logging: level debugging, 0 messages logged
    Buffer logging: level debugging, 100 messages logged
    Logging to 192.168.1.100 (udp port 514, audit disabled)
      0 messages logged
    Logging to 192.168.1.101 (udp port 514, audit disabled)
      0 messages logged
```

---

## Syslog vs. SNMP vs. NetFlow Comparison

While studying Syslog, understand how it differs from related protocols:

| Protocol | Purpose | Port | Direction | Message Type |
|----------|---------|------|-----------|--------------|
| **[[Syslog]]** | Event logging | UDP 514 | Device → Server | Text events, alerts |
| **[[SNMP]]** | Device monitoring & management | UDP 161/162 | Bidirectional | Structured objects (OIDs) |
| **[[NetFlow]]** | Traffic analysis | UDP 2055 | Device → Server | Flow statistics |

**Syslog rule of thumb:** Use it for *what happened* (events). Use SNMP for *what is happening now* (status). Use NetFlow for *how much traffic* (metrics).

---

## Lab Relevance

These exact commands appear in Cisco IOS labs and are testable on the CCNA exam:

| Task | Syntax |
|------|--------|
| **Send logs to Syslog server** | `logging 192.168.1.100` |
| **Set severity filter** | `logging trap warnings` |
| **Enable timestamps** | `service timestamps log datetime msec` |
| **Add sequence numbers** | `service sequence-numbers` |
| **Configure console logging** | `logging console informational` |
| **Buffer logs in RAM** | `logging buffered 8192` |
| **Suppress interruption** | `line console 0` → `logging synchronous` |
| **View current logs** | `show logging` |
| **Enable interface debugging** | `debug interface` |
| **Disable all debugging** | `undebug all` or `u all` |
| **View log buffer** | `show logging buffer` |
| **Clear log buffer** | `clear logging buffer` |
| **Set hostname for DNS** | `logging host 192.168.1.100` (uses DNS if configured) |

---

## Exam Tips

### What the CCNA Specifically Tests

1. **Severity Level Ordering** (High-yield question type)
   - You'll see a scenario: "Which events are logged when you configure `logging trap error`?"
   - **Answer:** Only levels 0–3 (Emergency, Alert, Critical, Error)
   - **Trap:** Students forget that higher numbers = lower priority. Level 4 (Warning) is NOT sent.

2. **Real-World Logging Configuration** (Lab/Simulation)
   - You're given a switch. Configure it to send critical events to a Syslog server at 10.0.0.5.
   - Missing: You must also configure `logging synchronous` on console/vty lines to pass the lab.
   - Missing: You must enable timestamps so log entries are useful for compliance audits.

3. **Debug Command Dangers** (Conceptual question)
   - Question: "You enable `debug all` on a production router. What happens?"
   - **Answer:** CPU utilization spikes, packet processing slows, potentially device reboot.
   - **Why tested:** Ensures you understand operational impact of diagnostic commands.

4. **Log Message Format Interpretation** (Show output question)
   - You're shown:
   ```
   %LINK-5-CHANGED: Interface FastEthernet0/0, changed state to up
   ```
   - Identify the severity level (5 = Notice), the facility code, and what triggered the message.

5. **Multiple Syslog Servers** (Configuration)
   - Configure redundancy: If primary Syslog server fails, logs should still be sent somewhere.
   - **Syntax:** Configure two `logging` commands with different IP addresses.

### Common Exam Pitfalls

- **Pitfall 1:** Confusing `logging trap` (what severity gets sent) with

---
*Source: Acing the CCNA Exam, Volume 2, Chapter 7 | [[CCNA]]*