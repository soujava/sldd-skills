---
name: sldd-04-tests-first-driven-by-acceptance-criteria
description: Execute strict TDD Red phase by writing tests first and marking step completion.
metadata:
  step: "04"
  type: implementation
---

# Skill: Tests First Driven by Acceptance Criteria

## Objective

Execute Step 04 in strict Red phase by creating tests first, proving they fail, and marking Step 04 complete after Red confirmation.

## Gate + Resume Checks

- Require Step 01, Step 02, and Step 03 approved.
- For existing codebases, require Step 99 approved.
- Reject skip-ahead requests to implementation.
- Reject inconsistent checklist states.
- On interrupted resume, re-evaluate `docs/specs/<feature-name>/SPEC.md`, current files, and relevant test results before deciding whether Step 04 is pending, complete, or superseded.

## Interrupted Workflow Resume Rules

- Always re-evaluate Step 04 on resume, even if `docs/specs/<feature-name>/SPEC.md` already marks Step 04 complete.
- Inspect existing test files and production changes before writing anything.
- Run the relevant tests again when the current Red/Green state cannot be determined from files alone.
- If the relevant tests fail for the expected missing behavior, mark Step 04 complete in `docs/specs/<feature-name>/SPEC.md`.
- If the relevant tests already pass, infer that Step 05 may have been partially or fully executed; route to Step 05 or Step 06 based on checklist state and current verification.
- If test changes, production changes, or checklist state are ambiguous, stop and ask for direction before modifying files or progress.
- Never revert user changes while resuming. Work with the current state.

## Strict Red-Phase Contract

- **Tests first; no production logic.**
- **Minimal Stubbing**: Create only production files and signatures strictly required for the test to compile. Do not implement full DTO or Entity suites if one stub suffices.
- **Allowed stubs**: method or function signatures and class structure only. Every stub method must immediately raise a runtime error or equivalent. No business logic, no validation logic, no placeholder return values, no delegating calls to other stubs.
- **Every Step 04 test run must fail.**
- **No Intermediate Implementation**: Do not perform any production logic changes. Production file creation is limited to the minimal stubs strictly required for tests to compile.

## Execution Protocol

Execute Step 04 directly when Step 01 acceptance criteria and Step 03 test scenarios are approved, clear, and sufficient.

Create only executable tests directly traceable to approved Step 01 acceptance criteria and Step 03 scenarios. If extra behavior, edge cases, test layers, assumptions, or non-obvious stubs are needed, stop and route back to Step 01 or Step 03 instead of expanding scope.

After execution, present failing-output evidence and repository state. This conversational snapshot may continue directly to Step 05.

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
- Use `00-exploration-summary.md` only as non-binding context; do not create tests from summary-only decisions.
- At least one approved or directly implied edge case per criterion; if an edge case requires new behavior or assumptions, stop and route back to Step 01 or Step 03.
- Exact test commands
- Failing output summary
- Explicit Red confirmation

## Approval Protocol

- Do not require a separate Step 04 execution approval when approved Step 01, Step 02, and Step 03 artifacts clearly define the acceptance criteria, constraints, and test scenarios.
- Ask for explicit approval before writing tests or running commands only when Step 04 detects ambiguity, scope expansion, missing test scenarios, unclear commands, or non-obvious minimal stubbing needs.
- If the user requested continuous execution from Step 04 to Step 05, route directly to `sldd-05-minimal-implementation-to-pass-existing-tests` after Red confirmation without asking for another approval between the steps.
- On rejection, requested changes, hold, or ambiguous approval, do not write, run, save, or route forward; clarify or wait.
- If writes are unavailable, stop and report the limitation.

## Save Flow (after Red confirmation)

1. Do not create a mandatory Step 04 report artifact.
2. Update `docs/specs/<feature-name>/SPEC.md` Step 04 `[x]` only.
3. Keep `docs/specs/<feature-name>/SPEC.md` journal-only; do not include logs, report body, or numbered artifact content.
4. If continuous Step 04 -> Step 05 execution was requested, route directly to Step 05.
5. Otherwise, ask whether to continue to the next step or hold.

## Response Format

### Execution Response
1. Gate and resume check result
2. Red-phase execution snapshot
3. `docs/specs/<feature-name>/SPEC.md` update summary
4. Continue/hold prompt, unless continuous Step 04 -> Step 05 execution was already requested

### Blocked Response
1. Gate and resume check result
2. Reason Step 04 cannot execute directly
3. Required clarification, approval, or route back to Step 01 or Step 03
