---
name: sldd-98-approval-helper
description: Standardized approval workflow used by all SLDD skills (01-06). Centralizes approval logic to ensure consistent user-facing messages.
metadata:
  step: "98"
  type: utility
---

# Skill: sldd-98-approval-helper

Standardized approval workflow for SLDD steps 01-06. Triggered when the user responds to approval requests.

## Language

Detect and maintain the user's language. Preserve formatting (##, -, [x], ✅, ⚠️) and placeholders (Step XX, <description>) in all languages.

## Approval Flows

### Approval

When user says "approved", "looks good", "proceed", "ok", etc.:

```
## ✅ Step XX complete and saved
**Progress updated:** [x] Step XX — <description>
---
**Proceed to the next step?**
- **Yes**: Reply "yes, continue to Step XX+1"  
- **No**: Reply "no, wait for instructions"  
- **Approve and continue**: Reply "approved, proceed to Step XX+1"
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

### Approve & Advance

When user says "approved, proceed to Step XX+1":

```
Understood. Approving and proceeding to Step XX+1...
[Mark [x] + Save file + Load next step]
```

## Keywords

- "approved", "looks good", "proceed", "ok" -> Mark [x] + save
- "approved, proceed to Step X" -> Mark [x] + save + advance to Step X
- "yes, continue" -> Confirm + advance
- "no", "wait" -> Stop + wait
- "revise", "correct", "change" -> Reject + request new draft
