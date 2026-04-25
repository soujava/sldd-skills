---
name: sldd-99-existing-codebase-understanding-and-context-summary
description: Capture existing-codebase context required before Step 02 in brownfield projects.
metadata:
  step: "99"
  type: appendix
---

# Skill: Existing Codebase Understanding and Context Summary

Use `sldd-88-shared-templates-and-protocols` for shared gates, save decision, and templates.

## Gate + Resume Checks

- Required before Step 02 for existing codebases.
- Optional for greenfield projects.
- Do not mark Step 99 complete without explicit approval.
- Reject inconsistent checklist states where Step 02+ is complete while Step 99 is required and incomplete.

## Draft Output

Create a draft with required Step 99 headings from Step 88 Section 6.
Wait for explicit approval.

## Save Flow (after approval)

1. Save `docs/specs/<feature-name>/99-existing-codebase-understanding.md`.
2. Update `SPEC.md` Step 99 `[x]` with link.
3. Verify `SPEC.md` remains journal-only.
4. Use `sldd-98-approval-helper` completion prompt.

Apply Step 88 Section 5 (Shared Save Decision).
