# udev rules

## What it is
Think of udev rules as a bouncer's clipboard at a club — when a new device shows up at the door (the kernel), udev checks its list and decides exactly what name tag to give it, what permissions it gets, and which scripts run to let it in. Precisely: udev is the Linux device manager that dynamically manages device nodes in `/dev`, and udev rules are configuration files that match device attributes (vendor ID, product ID, subsystem) to trigger actions — setting permissions, creating symlinks, or executing scripts — when hardware is added or removed.

## Why it matters
Attackers with local access can drop a malicious udev rule that executes a payload whenever a specific USB device (or *any* USB device) is plugged in — effectively achieving privilege escalation or persistence without touching cron or systemd. This technique has been used in post-exploitation frameworks to maintain backdoors that survive reboots and evade defenders who only audit traditional persistence mechanisms like `/etc/rc.local` or cron jobs.

## Key facts
- Rules live in `/etc/udev/rules.d/` (persistent, admin-defined) and `/lib/udev/rules.d/` (system defaults); higher-numbered files take precedence
- The `RUN` key in a rule executes an arbitrary command as **root** when the device event fires — a direct privilege escalation vector if writable by non-root users
- Rules match on attributes like `SUBSYSTEM`, `ATTR{idVendor}`, `ATTR{idProduct}`, and `ACTION` (add/remove/change)
- Changes take effect after running `udevadm control --reload-rules` or on next device event — no reboot required
- Forensic investigators check udev rules during Linux incident response as a persistence hunting location, alongside cron, systemd units, and shell profiles

## Related concepts
[[Linux Privilege Escalation]] [[USB Attack Vectors]] [[Persistence Mechanisms]] [[Linux File Permissions]]