---
name: sldd-03-low-level-design-and-version-policy
description: Produce Step 03 low-level design with API contracts, data models, error model, test strategy, and version policy.
metadata:
  step: "03"
  type: specification
---

# Skill: Low-Level Design and Version Policy

Use `sldd-88-shared-templates-and-protocols` for shared gates, save decision, and templates.

## Gate + Resume Checks

- Require Step 01 and Step 02 approved.
- For existing codebases, require Step 99 approved.
- Reject implementation/test generation at this step.
- Reject inconsistent checklist states.

## Draft Output

Create a draft with required Step 03 headings from Step 88 Section 6.
Include ordered implementation plan.
Wait for explicit approval.

## Save Flow (after approval)

1. Save `docs/specs/<feature-name>/03-low-level-design-and-version-policy.md`.
2. Verify artifact contains Step 03 content only.
3. Update `SPEC.md` Step 03 `[x]` with link.
4. Verify `SPEC.md` remains journal-only.
5. Use `sldd-98-approval-helper` completion prompt.

Apply Step 88 Section 5 (Shared Save Decision).
