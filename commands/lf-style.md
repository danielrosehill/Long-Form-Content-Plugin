---
description: Write the style guide — the binding voice reference every agent reads
---

Write the work's style guide.

Dispatch the `voice-designer` subagent.

Its readers are agents that will never see another chapter, so rules must be
checkable. "Authoritative but approachable" will not survive twelve chapters;
"second person, present tense, no sentence opens with 'It is important to note'"
will, and can be grepped.

Derive the monospace line-length cap from the measure in the typesetting profile
named in `longform.toml`, and say in the guide that it is derived and from what.

Output is `guides/style-guide.md`. Run before `/lf-outline` — prose conventions
affect chapter sizing.
