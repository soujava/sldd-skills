---
name: sldd-02-high-level-technical-design
description: Produce Step 02 high-level design after prerequisite validation and save as a numbered artifact.
metadata:
  step: "02"
  type: specification
---

# Skill: High-Level Technical Design

Use `sldd-88-shared-templates-and-protocols` for shared gates, save decision, and templates.

## Objective

Produce approved Step 02 high-level design aligned to Step 01, including formalized exploration decisions, and Step 99 when required.

## Gate + Resume Checks

- Require Step 01 approved.
- For existing codebases, require Step 99 approved.
- Reject skip-ahead to implementation/tests.
- Reject inconsistent checklist states.

## Draft Output

Create a draft with required Step 02 headings from Step 88 "Compact Step Template Contracts".
The draft must explicitly trace approved Step 01 requirements, including formalized exploration decisions, into the proposed architecture, component responsibilities, data flow, security/observability requirements, trade-offs, and high-level test scenarios.
Wait for approval.

## Approval Protocol

- Use `sldd-88-approval-helper` messaging.
- Save/update only after explicit approval.

## Save Flow (after approval)

1. Save `docs/specs/<feature-name>/02-high-level-technical-design.md`.
2. Verify artifact contains Step 02 content only.
3. Update `SPEC.md` Step 02 `[x]` with link.
4. Verify `SPEC.md` remains journal-only.
5. Use `sldd-88-approval-helper` completion prompt.

Apply Step 88 "Shared Save Decision".

## Response Format

1. Gate and resume check result
2. Draft summary with required Step 02 headings
3. Approval request
4. Continue/hold prompt
