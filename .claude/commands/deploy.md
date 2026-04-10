Deploy VIRGIL to a COCYTUS fleet machine.

Target: $ARGUMENTS

Steps:
1. Resolve the target. If `$ARGUMENTS` is a short hostname (e.g. `abaddon`, `morax`), look it up in `~/.ssh/config` to confirm it's reachable. If it's a bare IP or `user@host`, use it directly.
2. Run the deploy script:
   ```
   bash ~/Documents/Cocytus/VIRGIL/scripts/deploy-machine.sh $ARGUMENTS
   ```
   Stream and display the output as it runs.
3. After the script completes, summarise the pass/fail report:
   - List any failed steps with their error messages.
   - If all passed, confirm the machine is ready and remind the user to SSH in and run `virgil` to authenticate Claude Code on first launch.
4. If the git clone step failed (SSH key not present on the remote), offer to either:
   - Copy the local `~/.ssh/id_ed25519.pub` to the target's `~/.ssh/authorized_keys` first, or
   - Guide the user to add a GitHub deploy key for the VIRGIL repo on the target machine.

Do not prompt for `ANTHROPIC_API_KEY` or `SLACK_WEBHOOK_URL` — the script will pick them up from the current environment (they are already set in the crontab on this machine and exported in `.bashrc`).
