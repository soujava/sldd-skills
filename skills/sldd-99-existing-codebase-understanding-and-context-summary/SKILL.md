---
name: sldd-99-existing-codebase-understanding-and-context-summary
description: Capture existing-codebase context before Step 02 in brownfield projects.
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
- If resuming later, re-evaluate the current codebase before relying on any previous Step 99 summary.
- Reject inconsistent checklist states where Step 02+ is complete while Step 99 is required and incomplete.

## Draft Output

Create a draft with required Step 99 headings from Step 88 Section 6.
Wait for explicit approval.

## Save Flow (after approval)

1. Ask whether to persist `docs/specs/<feature-name>/99-existing-codebase-understanding.md`; saving this snapshot is optional.
2. If persistence is approved, save `docs/specs/<feature-name>/99-existing-codebase-understanding.md`.
3. Update `SPEC.md` Step 99 `[x]` with either the saved artifact link or a journal note that the approved summary was not saved and Step 99 must be re-run on resume.
4. Verify `SPEC.md` remains journal-only; do not write Step 99 body content into `SPEC.md`.
5. Use `sldd-98-approval-helper` completion prompt.

Apply Step 88 Section 5 (Shared Save Decision).
