---
name: sldd-05-minimal-implementation-to-pass-existing-tests
description: Implement minimal production changes to pass Step 04 tests without modifying tests.
metadata:
  step: "05"
  type: implementation
---

# Skill: Minimal Implementation to Pass Existing Tests

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

Use these required Step 05 report headings:

- Production Files Changed
- Implementation Notes (Minimal Scope)
- Test Commands Executed
- Passing Results Summary
- Assumptions and Constraints
- Test Integrity Confirmation (No Test Modifications)

## Approval Protocol

- Ask for explicit approval of the Phase A implementation action plan before modifying production code.
- Ask for explicit approval of the Phase B evidence report before saving artifacts or updating `SPEC.md`.
- If approval is rejected, requested changes are given, or the user asks to hold, leave progress unchanged and wait.
- If approval intent is ambiguous, ask for clarification instead of modifying code, running commands, saving, or routing forward.
- If writes are unavailable, stop and report the limitation.

## Verification

- Run tests and confirm previously failing tests pass.
- Record commands and results.

## Save Flow (after approval)

1. Save `docs/specs/<feature-name>/05-minimal-implementation-report.md`.
2. Verify artifact contains Step 05 report only.
3. Update `SPEC.md` Step 05 `[x]` with link.
4. Verify `SPEC.md` remains journal-only.
5. Ask whether to continue to the next step or hold.

## Response Format

### Phase A Response
1. Gate and resume check result
2. Implementation action plan
3. Approval request

### Phase B Response
1. Green-phase evidence summary
2. Test integrity confirmation
3. Artifact approval request
4. Continue/hold prompt
