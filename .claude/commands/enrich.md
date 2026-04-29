Run the VIRGIL enrichment pipeline autonomously.

## Steps
1. python3 ~/.local/bin/virgil-scan.py
2. python3 ~/.local/bin/virgil-enrich.py --resume --limit $LIMIT --category $CATEGORY
3. bash ~/.local/bin/virgil-review.sh --auto-commit

## Arguments
- $CATEGORY: attack, concept, protocol, algorithm, tool, framework, product, general
- $LIMIT: default 50

## Rules
- Never touch daily-logs/, notes/personal/, notes/cve/
- Skip any note already over 200 words
- Report count written, failures, git commit hash
