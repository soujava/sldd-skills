---
name: sldd-88-approval-helper
description: Standardized approval workflow used by all SLDD skills (01-06). Centralizes approval logic to ensure consistent user-facing messages.
metadata:
  step: "88"
  type: utility
---

# Skill: sldd-88-approval-helper

Standardized approval workflow for SLDD steps 01-06. Triggered when the user responds to approval requests.

## Language

Detect and maintain the user's language. Preserve formatting (##, -, [x], ✅, ⚠️) and placeholders (Step XX, <description>) in all languages.

## Approval Flows

### Approval Required

Use this prompt when presenting a Step XX draft for approval:

```
## Approval Required

Do you approve this Step XX report?

- **Yes**: Reply "approved"
  - Saves the Step XX artifact
  - Updates `SPEC.md` progress to `[x] Step XX — <description>`
  - Then asks whether to continue to Step XX+1

- **No**: Reply with corrections or "no, wait"
  - Keeps Step XX incomplete
  - Waits for further instructions
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
The draft has been rejected. Please incorporate the feedback and present a new draft for review.
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
