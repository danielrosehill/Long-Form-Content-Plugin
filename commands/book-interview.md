---
description: Interview the user for the gaps the writing team will need — and only those
---

Fill the gaps the brief leaves.

Dispatch the `spec-interviewer` subagent.

It reads `spec/brief.md` and any material it points at **first**, then asks only
questions whose answers change the outline, the voice or the scope — in one
numbered batch, flagging which are load-bearing.

It does not ask what the brief already answers, and it does not ask the user to
make decisions that belong to the planning stage.

"I don't know" is a complete answer and is recorded as one. Output is
`spec/interview.md`, ending with what remains unsettled.
