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

Provide one consistent approval protocol for predictable save/progress behavior.

## Trigger Conditions

- Use when a step asks for approval of a draft, action plan, or report.
- Use when user intent indicates approval, rejection, continue, or hold.

## Gate Rules

- Do not mark any SLDD step complete unless explicit approval intent is detected.
- Do not route to the next step unless completion/continue intent is explicit.
- On rejection or hold intent, stop progression and await user direction.

## Language

Maintain user language and preserve formatting/placeholders.

## Approval Flow

Use one compact approval loop:

1. Present the draft, action plan, or report and ask for explicit approval.
2. If approved, perform only the approved action:
   - save/update the artifact when applicable,
   - update `SPEC.md` only after the artifact is saved,
   - ask whether to continue to the next step.
3. If rejected, requested for changes, or placed on hold:
   - leave progress unchanged,
   - do not route forward,
   - wait for user direction.
4. If intent is ambiguous, ask for clarification instead of inferring approval.

## Intent Routing

- Approval: explicit approval such as "approved", "looks good", or "ok".
- Continue: explicit continuation after completion, such as "yes, continue".
- Hold: "wait", "hold", "stop", or "no, wait".
- Rejection: requested corrections, changes, or revision.
- Ambiguous: ask for clarification.

## Output Format

- Emit only the response needed for the detected intent.
- Preserve step identifiers, descriptions, paths, and checklist notation when reporting progress.
