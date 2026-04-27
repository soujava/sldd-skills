---
name: sldd-88-approval-helper
description: Standardized approval workflow used by all SLDD skills (01-06). Centralizes approval logic to ensure consistent user-facing messages.
metadata:
  step: "88"
  type: utility
---

# Skill: sldd-88-approval-helper

Standardized approval workflow for SLDD steps 01-06. Triggered when the user responds to approval requests.

## Objective

Provide a single, consistent approval protocol for SLDD steps so save/progress behavior and user messaging remain predictable.

## Trigger Conditions

- Use when a step asks for approval of a draft, action plan, or report.
- Use when user intent indicates approval, rejection, continue, or hold.

## Gate Rules

- Do not mark any SLDD step complete unless explicit approval intent is detected.
- Do not route to the next step unless completion/continue intent is explicit.
- On rejection or hold intent, stop progression and await user direction.

## Language

Detect and maintain the user's language. Preserve formatting (##, -, [x], ✅, ⚠️) and placeholders (Step XX, <description>) in all languages.

## Approval Flows

### Approval Required

Use this prompt when presenting a Step XX draft for approval:

```
## Approval Required

Do you approve this Step XX report?

- **Yes**: Reply "approved"
  - Save Step XX artifact
  - Update `SPEC.md` to `[x] Step XX — <description>`
  - Ask whether to continue to Step XX+1

- **No**: Reply with corrections or "no, wait"
  - Keep Step XX incomplete
  - Wait for instructions
```

### Approval

When user says "approved", "looks good", "ok", etc.:

```
## ✅ Step XX complete and saved
**Progress updated:** [x] Step XX — <description>
---
**Continue to Step XX+1?**
- **Yes**: Reply "yes, continue to Step XX+1"  
- **No**: Reply "no, wait for instructions"  
```

### Rejection

When user requests corrections or revisions:

```
## ⚠️ Step XX awaiting revisions
Draft rejected. Apply feedback and present a new draft.
```

### Proceed to Next Step

When user confirms "yes, continue":

```
Understood. Proceeding to Step XX+1...
[Load next step skill]
```

### Hold / Wait for Instructions

When user says "no" or "wait for instructions":

```
Understood. Waiting for your instructions.
The current progress is saved at: <specs-dir>/<feature>/SPEC.md
```

## Intent Routing

- Approval: "approved", "looks good", "ok" -> Mark [x] + save, then ask whether to continue.
- Continue after approval: "yes, continue" -> Load next step skill.
- Hold: "no", "wait" -> Stop and wait for instructions.
- Rejection: "revise", "correct", "change" -> Reject and request a new draft.

## Output Format

- Emit only the matching template block for the detected intent.
- Preserve formatting markers and placeholders exactly (`Step XX`, `<description>`, checklist notation).
