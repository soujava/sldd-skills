---
name: sldd-05-minimal-implementation-to-pass-existing-tests
description: Implement minimal production changes to pass Step 04 tests without modifying tests.
metadata:
  step: "05"
  type: implementation
---

# Skill: Minimal Implementation to Pass Existing Tests

Use `sldd-88-shared-templates-and-protocols` for shared gates, save decision, and templates.

## Gate + Resume Checks

- Require Steps 01-04 approved.
- Require Step 04 failing-test evidence.
- For existing codebases, require Step 99 approved.
- Reject requests to modify tests or bypass Red/Green order.
- Reject inconsistent checklist states.

## Implementation Contract (Two-Phase Protocol)

### Phase A: Implementation Action Plan
Present the minimal production changes and logic proposed to pass the existing tests. This plan must be approved before any production code is modified.

### Phase B: Green-Phase Evidence Report
After implementation and verification, present the final report confirming passing results. Wait for approval before saving the artifact.

## Verification

- Run tests and confirm previously failing tests pass.
- Record commands and results.

## Save Flow (after approval)

1. Save `docs/specs/<feature-name>/05-minimal-implementation-report.md`.
2. Verify artifact contains Step 05 report only.
3. Update `SPEC.md` Step 05 `[x]` with link.
4. Verify `SPEC.md` remains journal-only.
5. Use `sldd-88-approval-helper` completion prompt.

Apply Step 88 Section 5 (Shared Save Decision).
