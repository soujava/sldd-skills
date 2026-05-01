---
name: sldd-01-product-intent-specification
description: Produce Step 01 intent spec with strict gate/resume checks and artifact-first save flow.
metadata:
  step: "01"
  type: specification
---

# Skill: Product Intent Specification

Use `sldd-88-shared-templates-and-protocols` for shared gates, save decision, and templates.

## Objective

Define and validate Step 01 product intent for downstream steps.

## Gate + Resume Checks

- Reject jump-ahead requests to design/tests/implementation.
- If resuming from `SPEC.md`, reject invalid state where later steps are complete but Step 01 is not.

## Draft Output

Create a draft with required Step 01 headings from Step 88 Section 7.
Wait for approval.

## Approval Protocol

- Use `sldd-88-approval-helper` messaging.
- Save/update only after explicit approval.

## Save Flow (after approval)

1. Save `docs/specs/<feature-name>/01-product-intent-specification.md`.
2. Verify artifact contains Step 01 content only.
3. Update `SPEC.md` Step 01 `[x]` with link.
4. Verify `SPEC.md` remains journal-only.
5. Use `sldd-88-approval-helper` completion prompt.

Apply Step 88 Section 6 (Shared Save Decision).

## Response Format

1. Gate and resume check result
2. Draft summary with required Step 01 headings
3. Approval request
4. Continue/hold prompt
