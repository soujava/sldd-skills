---
name: sldd-98-approval-helper
description: Standardized approval template used by all SLDD skills (01-06). Centralizes approval logic to avoid duplication and ensure consistent workflow.
metadata:
  step: "98"
  type: utility
---

# Skill: sldd-98-approval-helper

## Objective

Standardized approval template used by all SLDD skills (01-06). Centralizes approval logic to avoid duplication and ensure consistent workflow.

## When to Use

This skill is invoked automatically at the end of each step (01-06) after the user approves the draft.

## Language Configuration

All messages must use the `language` configured in `AGENTS.md` (section ## SLDD).

## Language Compliance Check (mandatory before every reply)

Before sending any user-facing message, validate language compliance:
- The full response (including final review/approval prompts) must be in the resolved language.
- The pre-defined replies ("yes, continue", "no", "approved, proceed to Step X", etc.) must be translated to the resolved language.
- If this skill contains example text in another language, translate the meaning; do not copy that text literally.
- If any sentence is not in the resolved language, rewrite the response before sending.

## Approval Flow

### 1. After Approval (Step Complete)

When the user approves ("approved", "looks good", "proceed", etc.):

```
## ✅ Step XX complete and saved to: <file>

**Progress updated:**
- [x] Step XX — <description> -> <file>

---

**Proceed to the next step?**

- **Yes**: Reply "yes, continue to Step XX+1"  
- **No**: Reply "no, wait for instructions"  
- **Approve and continue**: Reply "approved, proceed to Step XX+1"
```
**

### 2. After Rejection/Feedback (Step Incomplete)

When the user requests corrections:

```
## ⚠️ Step XX awaiting revisions

The draft has been rejected. Please incorporate the feedback and 
present a new draft for review.
```

### 3. After "Yes, continue" (Next Step)

When the user confirms they want to proceed:

```
Understood. Proceeding to Step XX+1...

[Load next step skill]
```

### 4. After "No, wait for instructions"

```
Understood. Waiting for your instructions.

The current progress is saved at: <specs-dir>/<feature>/SPEC.md
```

### 5. After "Approved, proceed to Step XX+1"

```
Understood. Approving and proceeding to Step XX+1...

[Mark [x] + Save file + Load next step]
```

## Keywords Rules

| User Keywords | Action |
|---------------|--------|
| "approved", "looks good", "proceed", "ok" | Only mark [x] and save |
| "approved, proceed to Step X" | Mark [x] + Save + Advance to Step X |
| "yes, continue" | Confirm and advance if yes |
| "no" | Stop and wait |
| "revise", "correct", "change" | Request new draft |
