---
name: sldd-05-minimal-implementation-to-pass-existing-tests
description: Implement minimal production changes to pass Step 04 tests and record execution state.
metadata:
  step: "05"
  type: implementation
---

# Skill: Minimal Implementation to Pass Existing Tests

## Objective

Implement only the minimum production changes required to pass Step 04 tests without modifying test files, while respecting the approved Step 03 design constraints and formalized Step 01 requirements, then record recoverable execution state.

## Gate + Resume Checks

- Require Steps 01-04 approved.
- Require Step 04 Red confirmation from `SPEC.md`, current failing test results, or continuous handoff from Step 04.
- For existing codebases, require Step 99 approved.
- Reject requests to modify tests or bypass Red/Green order.
- Reject inconsistent checklist states.
- When resuming an interrupted workflow, validate `SPEC.md`, current files, and relevant test results before deciding whether Step 05 is pending or complete.

## Interrupted Workflow Resume Rules

- If Step 04 is complete and Step 05 is not, run the relevant Step 04 tests before modifying production code.
- If the tests still fail, continue with the minimal implementation required to make them pass.
- If the tests already pass and test files were not modified after Red confirmation, mark Step 05 complete in `SPEC.md` with a short Green confirmation note.
- If Step 04 Red evidence is missing, stale, or ambiguous, re-run the relevant tests before implementation.
- If Step 04 tests appear to have been modified after Red confirmation, stop because test integrity may be compromised.
- If production implementation is partial, continue from the current state without reverting user changes.
- If checklist state, file state, or test results conflict, stop and ask for direction before modifying files or progress.

## Implementation Contract (Two-Phase Protocol)

### Phase A: Implementation Action Plan
Present minimal production changes to pass existing tests. Approve before modifying production code.
If invoked through explicit continuous Step 04 -> Step 05 authorization, present the implementation action plan as part of the execution snapshot and proceed without another approval turn.

### Phase B: Green-Phase Execution Snapshot
After implementation and verification, present passing evidence and the resulting repository state.

The implementation plan must identify which Step 03 contracts, constraints, and implementation steps are being satisfied. Do not introduce behavior that is not required by Step 04 tests or approved by Step 03.

## Execution Output

Present:
- Phase A implementation action plan
- Phase B green-phase execution snapshot
- confirmation that tests were not modified

Use these required Step 05 snapshot headings:

- Production Files Changed
- Implementation Notes (Minimal Scope)
- Test Commands Executed
- Passing Results Summary
- Assumptions and Constraints
- Test Integrity Confirmation (No Test Modifications)

## Approval Protocol

- Ask for explicit approval of the Phase A implementation action plan before modifying production code.
- Skip the separate Phase A approval only when Step 05 is invoked through explicit continuous Step 04 -> Step 05 authorization.
- Do not require a separate approval after Phase B before updating `SPEC.md`; Step 05 execution approval authorizes recording the Green snapshot state.
- If approval is rejected, requested changes are given, or the user asks to hold, leave progress unchanged and wait.
- If approval intent is ambiguous, ask for clarification instead of modifying code, running commands, saving, or routing forward.
- If writes are unavailable, stop and report the limitation.

## Verification

- Run tests and confirm previously failing tests pass.
- Record commands and results.

## Save Flow (after Green confirmation)

1. Do not create a mandatory Step 05 report artifact.
2. Update `SPEC.md` Step 05 `[x]` with a short journal-only Green confirmation note, including relevant command summary.
3. Verify `SPEC.md` remains journal-only and does not contain logs, report body, or numbered artifact content.
4. Ask whether to continue to the next step or hold.

## Response Format

### Phase A Response
1. Gate and resume check result
2. Implementation action plan
3. Approval request

Omit this separate Phase A response only when Step 05 is invoked through explicit continuous Step 04 -> Step 05 authorization.

### Phase B Response
1. Green-phase execution snapshot
2. Test integrity confirmation
3. Implementation action plan summary, when executed through continuous Step 04 -> Step 05 authorization
4. `SPEC.md` update summary
5. Continue/hold prompt
