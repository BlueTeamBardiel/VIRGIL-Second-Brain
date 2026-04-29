# NFA-to-DFA

## What it is
Like a chess engine that tracks *every possible board position simultaneously* rather than committing to one move, an NFA (Nondeterministic Finite Automaton) explores multiple states at once — the subset construction algorithm then collapses that parallel exploration into a single deterministic machine (DFA) where each input produces exactly one next state. Formally, NFA-to-DFA conversion (the *powerset construction*) maps each DFA state to a *set* of NFA states, potentially creating up to 2ⁿ states from an NFA with n states.

## Why it matters
Regex-based intrusion detection systems and WAFs internally compile pattern rules into automata — if the underlying engine uses an NFA with backtracking instead of a converted DFA, attackers can craft inputs that trigger *ReDoS (Regular Expression Denial of Service)* by exploiting exponential backtracking paths. Converting to a DFA eliminates backtracking entirely, giving O(n) matching time and closing that attack surface.

## Key facts
- **Powerset construction** is the standard algorithm: each DFA state represents a *subset* of NFA states reachable on a given input string.
- An NFA with *n* states can produce a DFA with up to **2ⁿ states** (worst case), called the *state explosion problem*.
- DFAs always run in **linear time O(n)** relative to input length — critical for high-throughput network pattern matching (Snort, Suricata use DFA-based engines internally).
- NFAs are smaller and easier to construct from regex; DFAs are faster to execute — security tools often convert at *compile time* to pay the cost once.
- **ReDoS attacks** specifically target NFA backtracking engines; tools like `safe-regex` or `rxxr2` statically detect patterns requiring DFA conversion to be safe.

## Related concepts
[[Regular Expressions]] [[ReDoS]] [[Intrusion Detection Systems]]