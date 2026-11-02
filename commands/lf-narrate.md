---
description: Audiobook — adapt reviewed chapters into spoken scripts, then lint and seam-check them
argument-hint: "[chapter ids, or 'all' for every reviewed chapter without a current script]"
---

Narrate: $ARGUMENTS

Follow steps 1–2 of the `audiobook-production` skill.

Seed `guides/pronunciation.md` from the manuscript's acronyms and names
yourself first. Then dispatch one `narration-adapter` per chapter in a single
message. Each adapts its chapter only (text normalisation, nothing visual,
lexicon applied, `[audio] format`) into `audio/script/`.

Then `python3 scripts/longform.py script-lint` and
`python3 scripts/longform.py seams --layer script` with one `seam-reviewer` per
spoken seam. Script-lint must be clean, or each warning explained, before
`/lf-render`.
