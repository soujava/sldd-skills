---
name: sldd-06-verification-and-feedback-report
description: Audit implementation against approved specs and produce final Go/No-Go decision.
metadata:
  step: "06"
  type: verification
---

# Skill: Verification and Feedback Report

Use `sldd-88-shared-templates-and-protocols` for shared gates, save decision, and templates.

## Gate + Resume Checks

- Require Steps 01-05 approved.
- For existing codebases, require Step 99 approved.
- Reject premature verification before implementation completion.
- Reject inconsistent checklist states.

## Draft Output

Create a draft with required Step 06 headings from Step 88 Section 6.
Wait for explicit approval.

## Save Flow (after approval)

1. Save `docs/specs/<feature-name>/06-verification-and-feedback-report.md`.
2. Verify artifact contains Step 06 report only.
3. Update `SPEC.md` Step 06 `[x]` with link.
4. Verify `SPEC.md` remains journal-only.
5. Use `sldd-98-approval-helper` completion prompt.

Apply Step 88 Section 5 (Shared Save Decision).
