---
name: sldd-02-high-level-technical-design
description: Produce Step 02 high-level design after prerequisite validation and save as a numbered artifact.
metadata:
  step: "02"
  type: specification
---

# Skill: High-Level Technical Design

Use `sldd-88-shared-templates-and-protocols` for shared gates, save decision, and templates.

## Gate + Resume Checks

- Require Step 01 approved.
- For existing codebases, require Step 99 approved.
- Reject skip-ahead to implementation/tests.
- Reject inconsistent checklist states.

## Draft Output

Create a draft with required Step 02 headings from Step 88 Section 6.
Wait for explicit approval.

## Save Flow (after approval)

1. Save `docs/specs/<feature-name>/02-high-level-technical-design.md`.
2. Verify artifact contains Step 02 content only.
3. Update `SPEC.md` Step 02 `[x]` with link.
4. Verify `SPEC.md` remains journal-only.
5. Use `sldd-98-approval-helper` completion prompt.

Apply Step 88 Section 5 (Shared Save Decision).
