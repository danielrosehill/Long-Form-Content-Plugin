---
description: Show what is drafted, what is not, and what is blocking production
---

Report the state of the work.

```bash
python3 scripts/longform.py status
python3 scripts/longform.py lint
```

Then say, in a few lines: what stage the work is in, which chapters are blocking
progress, how many `[VERIFY:]` markers are outstanding and where, and what the
next action is.

Where lint is clean, say that it means the mechanical failures are absent — not
that the work is good. Fabricated claims, voice drift and chapters that did not
make their brief's argument all pass a clean lint.
