---
description: Audiobook — render chapters through the TTS command and assemble the chaptered m4b
argument-hint: "[optional — 'ch01' to render one chapter for a listening check, or 'assemble']"
---

Render: $ARGUMENTS

Follow steps 3–5 of the `audiobook-production` skill.

```bash
python3 scripts/longform.py render --only ch01     # listening check first, unless told to skip it
python3 scripts/longform.py render --keep-going    # the rest, in the background; resumable
python3 scripts/longform.py audio-assemble         # join, chapter marks, tags, cover, loudness
```

`[audio] render_cmd` must be set. It is the only engine-specific line. Estimate
cost from `status` (spoken hours) before a long render. Verify the result with
`ffprobe -show_chapters dist/audiobook.m4b`, not the exit code.
