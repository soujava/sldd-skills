---
name: sldd-05-minimal-implementation-to-pass-existing-tests
description: Implement minimal production changes to pass Step 04 tests without modifying tests.
metadata:
  step: "05"
  type: implementation
---

# Skill: Minimal Implementation to Pass Existing Tests

Use `sldd-88-shared-templates-and-protocols` for shared gates, save decision, and templates.

## Objective

Implement only the minimum production changes required to pass Step 04 tests without modifying test files, while respecting the approved Step 03 design constraints and formalized Step 01 requirements.

## Gate + Resume Checks

- Require Steps 01-04 approved.
- Require Step 04 failing-test evidence.
- For existing codebases, require Step 99 approved.
- Reject requests to modify tests or bypass Red/Green order.
- Reject inconsistent checklist states.

## Implementation Contract (Two-Phase Protocol)

### Phase A: Implementation Action Plan
Present minimal production changes to pass existing tests. Approve before modifying production code.

### Phase B: Green-Phase Evidence Report
After implementation and verification, present passing evidence. Approve before saving.

The implementation plan must identify which Step 03 contracts, constraints, and implementation steps are being satisfied. Do not introduce behavior that is not required by Step 04 tests or approved by Step 03.

## Draft Output

Present:
- Phase A implementation action plan
- Phase B green-phase evidence report
- confirmation that tests were not modified

## Approval Protocol

- Follow Step 88 two-phase approval behavior:
  - approve Phase A plan before modifying production code,
  - approve Phase B evidence report before saving artifacts.
- Use `sldd-88-approval-helper` approval messaging.

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

## Response Format

1. Gate and resume check result
2. Phase A implementation action plan
3. Phase B green-phase evidence summary
4. Approval request and continue/hold prompt
