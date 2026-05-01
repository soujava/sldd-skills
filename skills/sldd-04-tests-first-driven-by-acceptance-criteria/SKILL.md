---
name: sldd-04-tests-first-driven-by-acceptance-criteria
description: Execute strict TDD Red phase by writing tests first and saving failing-test evidence.
metadata:
  step: "04"
  type: implementation
---

# Skill: Tests First Driven by Acceptance Criteria

## Objective

Execute Step 04 in strict Red phase by creating tests first, proving they fail, and capturing auditable evidence aligned to Step 03.

## Gate + Resume Checks

- Require Step 01, Step 02, and Step 03 approved.
- For existing codebases, require Step 99 approved.
- Reject skip-ahead requests to implementation.
- Reject inconsistent checklist states.

## Strict Red-Phase Contract

- Tests first; no production logic.
- Allowed stubs: signatures/structure only, raise "not implemented" equivalent.
- Forbidden: business logic, validation logic, placeholder returns (`0`, `""`, `false`, `null`).
- Every Step 04 test run must fail.

## Draft Output (Two-Phase Protocol)

### Phase A: Test Action Plan
Present proposed test files, scenarios, and commands. Approve before writing tests or running commands.

### Phase B: Red-Phase Evidence Report
After execution, present failing-output evidence. Approve before saving.

Use these required Step 04 report headings:

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
- Ask for explicit approval of the Phase B evidence report before saving artifacts or updating `SPEC.md`.
- If approval is rejected, requested changes are given, or the user asks to hold, leave progress unchanged and wait.
- If approval intent is ambiguous, ask for clarification instead of writing, running commands, saving, or routing forward.
- If writes are unavailable, stop and report the limitation.

## Save Flow (after approval)

1. Save `docs/specs/<feature-name>/04-tests-first-report.md`.
2. Verify artifact contains Step 04 report only.
3. Update `SPEC.md` Step 04 `[x]` with link.
4. Verify `SPEC.md` remains journal-only.
5. Ask whether to continue to the next step or hold.

## Response Format

### Phase A Response
1. Gate and resume check result
2. Test action plan
3. Approval request

### Phase B Response
1. Red-phase evidence summary
2. Artifact approval request
3. Continue/hold prompt
