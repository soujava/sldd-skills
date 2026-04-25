---
name: sldd-04-tests-first-driven-by-acceptance-criteria
description: Execute strict TDD Red phase by writing tests first and saving failing-test evidence.
metadata:
  step: "04"
  type: implementation
---

# Skill: Tests First Driven by Acceptance Criteria

Use `sldd-88-shared-templates-and-protocols` for shared gates, save decision, and templates.

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

## Required Evidence

- Acceptance criteria -> tests mapping
- At least one edge case per criterion
- Exact test commands
- Failing output summary
- Explicit Red confirmation

## Save Flow (after approval)

1. Save `docs/specs/<feature-name>/04-tests-first-report.md`.
2. Verify artifact contains Step 04 report only.
3. Update `SPEC.md` Step 04 `[x]` with link.
4. Verify `SPEC.md` remains journal-only.
5. Use `sldd-98-approval-helper` completion prompt.

Apply Step 88 Section 5 (Shared Save Decision).
