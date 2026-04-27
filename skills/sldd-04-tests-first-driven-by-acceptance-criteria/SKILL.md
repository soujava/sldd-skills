---
name: sldd-04-tests-first-driven-by-acceptance-criteria
description: Execute strict TDD Red phase by writing tests first and saving failing-test evidence.
metadata:
  step: "04"
  type: implementation
---

# Skill: Tests First Driven by Acceptance Criteria

Use `sldd-88-shared-templates-and-protocols` for shared gates, save decision, and templates.

## Objective

Execute Step 04 in strict Red phase by creating tests first, proving they fail, and capturing auditable evidence.

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

## Required Evidence

- Acceptance criteria -> tests mapping
- At least one edge case per criterion
- Exact test commands
- Failing output summary
- Explicit Red confirmation

## Approval Protocol

- Follow Step 88 two-phase approval behavior:
  - approve Phase A plan before writing tests or running commands,
  - approve Phase B evidence report before saving artifacts.
- Use `sldd-88-approval-helper` approval messaging.

## Save Flow (after approval)

1. Save `docs/specs/<feature-name>/04-tests-first-report.md`.
2. Verify artifact contains Step 04 report only.
3. Update `SPEC.md` Step 04 `[x]` with link.
4. Verify `SPEC.md` remains journal-only.
5. Use `sldd-88-approval-helper` completion prompt.

Apply Step 88 Section 5 (Shared Save Decision).

## Response Format

1. Gate and resume check result
2. Phase A test action plan
3. Phase B red-phase evidence summary
4. Approval request and continue/hold prompt
