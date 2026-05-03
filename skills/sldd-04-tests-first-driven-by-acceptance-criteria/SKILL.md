---
name: sldd-04-tests-first-driven-by-acceptance-criteria
description: Execute strict TDD Red phase by writing tests first and recording execution state.
metadata:
  step: "04"
  type: implementation
---

# Skill: Tests First Driven by Acceptance Criteria

## Objective

Execute Step 04 in strict Red phase by creating tests first, proving they fail, and recording recoverable execution state aligned to Step 03.

## Gate + Resume Checks

- Require Step 01, Step 02, and Step 03 approved.
- For existing codebases, require Step 99 approved.
- Reject skip-ahead requests to implementation.
- Reject inconsistent checklist states.
- When resuming an interrupted workflow, validate `SPEC.md`, current files, and relevant test results before deciding whether Step 04 is pending, complete, or superseded by later implementation.

## Interrupted Workflow Resume Rules

- If `SPEC.md` does not mark Step 04 complete, inspect existing test files and production changes before writing anything.
- If Step 04 tests already exist but Red evidence is unavailable or stale, run the relevant tests again.
- If the relevant tests fail for the expected missing behavior, mark Step 04 complete in `SPEC.md` with a short Red confirmation note.
- If the relevant tests already pass, infer that Step 05 may have been partially or fully executed; route to Step 05 or Step 06 based on checklist state and current verification.
- If test changes, production changes, or checklist state are ambiguous, stop and ask for direction before modifying files or progress.
- Never revert user changes while resuming. Work with the current state.

## Strict Red-Phase Contract

- **Tests first; no production logic.**
- **Minimal Stubbing**: Create ONLY the production files and signatures strictly required for the test to compile. Do not implement entire DTO or Entity suites if a single stub suffices for the current test scenario.
- **Allowed stubs**: method or function signatures and class structure only. Every stub method must immediately raise a runtime error or equivalent. No business logic, no validation logic, no placeholder return values, no delegating calls to other stubs.
- **Every Step 04 test run must fail.**
- **No Intermediate Implementation**: After Phase A approval, do not perform any production logic changes or file creations that are not documented in the "Minimal Stubbing" plan.

## Execution Output (Two-Phase Protocol)

### Phase A: Test Action Plan
Present proposed test files, scenarios, and commands. Approve before writing tests or running commands.
The approval request may ask whether the user authorizes Red-only execution or continuous Red -> Green execution through Step 05. Continuous authorization allows Step 05 to run immediately after Red confirmation without another approval turn.

### Phase B: Red-Phase Execution Snapshot
After execution, present failing-output evidence and the resulting repository state. This snapshot is the record of execution and may be used to continue directly to Step 05.
**Mandatory Turn Order**: After Phase A approval, the next response MUST be the Phase B snapshot. Do not interleave turn-based implementation of production structure between these phases.

Use these required Step 04 snapshot headings:

- Test Files Created
- Acceptance Criteria -> Tests Mapping
- Test Commands Executed
- Failing Results Summary
- Red-Phase Confirmation

## Required Evidence

- Acceptance criteria and Step 03 test scenarios -> tests mapping
- Coverage of the Step 03 Test Scenario Catalog
- Traceability from approved Step 01 behavior and Step 03 test scenarios into concrete tests
- If `00-exploration-summary.md` exists, use it only as contextual memory for rationale, edge cases, risks, and assumptions; do not create tests from summary-only decisions.
- At least one edge case per criterion
- Exact test commands
- Failing output summary
- Explicit Red confirmation

## Approval Protocol

- Ask for explicit approval of the Phase A test action plan before writing tests or running commands.
- Do not require a separate approval after Phase B before updating `SPEC.md`; Step 04 execution approval authorizes recording the Red snapshot state.
- If the user approved continuous execution from Step 04 to Step 05, route directly to `sldd-05-minimal-implementation-to-pass-existing-tests` after Red confirmation without asking for another approval between the steps.
- If approval is rejected, requested changes are given, or the user asks to hold, leave progress unchanged and wait.
- If approval intent is ambiguous, ask for clarification instead of writing, running commands, saving, or routing forward.
- If writes are unavailable, stop and report the limitation.

## Save Flow (after Red confirmation)

1. Do not create a mandatory Step 04 report artifact.
2. Update `SPEC.md` Step 04 `[x]` with a short journal-only Red confirmation note, including relevant command summary.
3. Verify `SPEC.md` remains journal-only and does not contain logs, report body, or numbered artifact content.
4. If continuous Step 04 -> Step 05 execution was approved, route directly to Step 05.
5. Otherwise, ask whether to continue to the next step or hold.

## Response Format

### Phase A Response
1. Gate and resume check result
2. Test action plan
3. Approval request

### Phase B Response
1. Red-phase execution snapshot
2. `SPEC.md` update summary
3. Continue/hold prompt, unless continuous Step 04 -> Step 05 execution was already approved
