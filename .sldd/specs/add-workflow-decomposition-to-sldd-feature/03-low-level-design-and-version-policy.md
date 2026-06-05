# Requirement-to-Design Traceability

| Step 01 Requirement | Low-Level Coverage |
|---|---|
| Missing `kind` means `feature` | Router and navigation rules infer feature when `kind` is absent. Schema treats `kind` as optional for compatibility. |
| Support `workflow-set` | Add workflow-set routing, step files, template, journal shape, and status/resume behavior. |
| Preserve feature workflow | Existing feature step map and gates remain unchanged except additive recommendation/predecessor handling. |
| Plan materialization modes | `01-workflow-set-plan.md` step documents write complete, write draft, and no-write behavior. |
| All-or-nothing scaffold | `02-scaffold-children.md` validates and scaffolds every proposed child or none when preflight fails. |
| Child Step 01 pending with origin | Scaffold creates child journal Step 01 as pending with `origin.type: "workflow-set-scaffold"`. |
| Predecessor gate | Child Step 01 approval reads `relationships.predecessors` and requires predecessor Step 06 complete. |
| Read-only child overview | Status/resume computes child state from child journals and does not persist child progress in parent. |
| Conflict safety | Scaffold records `conflict` state and stops instead of overwriting. |

# API Contracts

This project has no runtime API. The contracts are skill instruction contracts and journal/template contracts.

Workflow kind routing contract:

```text
If journal.kind is missing: treat as feature.
If journal.kind is feature: use normal feature step flow.
If journal.kind is workflow-set: use workflow-set parent step flow.
If journal.kind is unknown: stop and ask for correction.
```

Feature step flow contract:

```text
01-product-intent
99-codebase-context
02-high-level-design
03-low-level-design
04-tests-red
05-implementation-green
06-verification
```

Workflow-set step flow contract:

```text
01-workflow-set-plan
02-scaffold-children
03-verify-workflow-set
```

Plan materialization contract:

```text
1. Write it and mark it complete.
2. Write it as a draft and wait for review.
3. Do not write files yet.
```

Scaffold contract:

```text
Scaffold requires a complete or explicitly approved workflow-set plan.
Scaffold creates all proposed children in the approved plan.
Scaffold does not mark child Step 01 complete.
Scaffold stops on conflicts and does not overwrite automatically.
```

Child predecessor approval contract:

```text
Before marking child Step 01 complete, every journal in relationships.predecessors must exist and have Step 06 verification complete.
```

# Data Models

Workflow-set journal shape, first version:

```json
{
  "schema_version": 1,
  "name": "publishing-product-set",
  "workflow": "sldd",
  "kind": "workflow-set",
  "title": "Publishing Product",
  "current_step": "01-workflow-set-plan",
  "steps": {
    "01-workflow-set-plan": {
      "status": "pending",
      "artifact": "01-workflow-set-plan.md"
    },
    "02-scaffold-children": {
      "status": "pending"
    },
    "03-verify-workflow-set": {
      "status": "pending"
    }
  },
  "workflowSet": {
    "children": [
      {
        "name": "auth-feature",
        "title": "Authentication",
        "kind": "feature",
        "scaffold": {
          "state": "proposed"
        },
        "predecessors": []
      }
    ]
  }
}
```

Child feature journal shape, first version:

```json
{
  "schema_version": 1,
  "name": "article-authoring-feature",
  "workflow": "sldd",
  "kind": "feature",
  "title": "Article Authoring",
  "current_step": "01",
  "relationships": {
    "parents": [
      "../publishing-product-set/_spec-journal.json"
    ],
    "predecessors": [
      "../auth-feature/_spec-journal.json"
    ]
  },
  "steps": {
    "01": {
      "status": "pending",
      "artifact": "01-product-intent-specification.md",
      "origin": {
        "type": "workflow-set-scaffold",
        "journal": "../publishing-product-set/_spec-journal.json",
        "artifact": "../publishing-product-set/01-workflow-set-plan.md"
      }
    }
  }
}
```

Schema additions should be optional and backward-compatible:

- `kind`: optional string enum `feature` or `workflow-set`.
- `title`: optional string.
- `workflowSet.children`: optional array for workflow-set journals.
- `workflowSet.children[].scaffold.state`: enum `proposed`, `created`, or `conflict`.
- `relationships.parents`: optional array of journal paths.
- `relationships.predecessors`: optional array of journal paths.
- `steps.*.origin`: optional object for scaffold origin metadata.

# Error Model

Routing errors:

- Unknown `kind`: stop and ask for correction.
- Workflow-set requested with feature-only step: stop and route to valid workflow-set step.
- Feature requested with workflow-set-only step: stop and route to valid feature step.

Planning errors:

- Missing approval to write plan: do not create or update files.
- Draft plan not approved: do not scaffold.

Scaffold validation errors:

- Duplicate child names: stop and route back to plan revision.
- Missing child name/title/kind/scope: stop and route back to plan revision.
- Invalid suffix without approved custom name: stop and ask for name confirmation.
- Predecessor cycle: stop and route back to plan revision.
- Missing predecessor journal when predecessor is not in scaffold batch: stop and ask for correction.
- Target directory collision without matching origin: record `conflict` and stop.

Child approval errors:

- Missing predecessor journal: keep Step 01 pending and report blocker.
- Predecessor Step 06 incomplete: keep Step 01 pending and report blocker.
- Missing scaffold origin where expected: stop and ask for direction before regeneration or approval.

# Test Strategy

Because this repository is primarily Markdown skill instructions and schema, Step 04 should use verification-oriented tests appropriate to the repo, such as:

- Schema validation examples for old feature journals, new workflow-set journals, and scaffolded child journals.
- Static content checks that required new step files and templates exist.
- Static content checks that `SKILL.md`, step files, and README mention key guardrails.
- Scenario fixtures under the SLDD spec workflow or another appropriate test data location, if a test convention exists by Step 04.

No runtime application tests or CI changes are required by this design.

# Test Scenario Catalog

1. Existing journal without `name` or `kind` is rejected as invalid.
2. Existing feature workflow is not renamed or rewritten solely to add missing journal fields.
3. `workflow-set` journal routes to workflow-set steps.
4. Unknown `kind` is rejected.
5. Large idea recommendation text is present before Step 01 or in exploration behavior.
6. Materialization mode write-complete marks `01-workflow-set-plan` complete.
7. Materialization mode write-draft keeps `01-workflow-set-plan` pending.
8. Materialization mode no-write creates no files.
9. Approved scaffold creates all proposed children.
10. Scaffolded child Step 01 is pending and has `origin.type: "workflow-set-scaffold"`.
11. Parent records only scaffold state, not child execution progress.
12. Name collision records `conflict` and does not overwrite existing files.
13. Child Step 01 approval is blocked when a predecessor Step 06 is incomplete.
14. Child Step 01 approval is allowed only when all predecessor Step 06 statuses are complete and user approval is explicit.
15. Workflow-set resume after parent completion lists children by reading child journals and does not auto-select when multiple children are pending.
16. README and help text explain workflow-set decomposition and guardrails.

# Dependency and Version Policy

No new runtime or build dependencies are required.

Allowed dependency-related changes:

- Update `skills/sldd/schema/_spec-journal.schema.json` only with JSON Schema constructs already used or compatible with the existing schema style.
- Use existing repository tooling and shell commands for validation.

Disallowed dependency-related changes:

- Do not add package managers, build files, CI configuration, or runtime libraries.
- Do not introduce a separate executable generator or orchestration tool.

# Ordered Implementation Plan

1. Update `skills/sldd/schema/_spec-journal.schema.json` to require `name` and `kind`, allow `title`, `workflowSet`, `relationships`, workflow-set step keys, and step `origin` metadata.
2. Update `skills/sldd/SKILL.md` to document workflow kinds, required journal validation, workflow-set steps, decomposition guardrails, and updated step/template maps.
3. Add `skills/sldd/steps/01-workflow-set-plan.md` with objective, gates, materialization modes, approval protocol, save flow, and response format.
4. Add `skills/sldd/steps/02-scaffold-children.md` with plan validation, all-or-nothing scaffold rules, write order, conflict handling, journal updates, and completion criteria.
5. Add `skills/sldd/steps/03-verify-workflow-set.md` with coordination-only verification and no dedicated artifact requirement.
6. Add `skills/sldd/templates/01-workflow-set-plan.md`.
7. Add `skills/sldd/templates/01-product-intent-from-workflow-set.md`.
8. Update `skills/sldd/steps/00-navigation.md` for kind-based status/resume routing, workflow-set parent routing, and read-only child overview behavior.
9. Update `skills/sldd/steps/88-exploration.md` and `skills/sldd/steps/01-product-intent.md` for large-idea recommendation and explicit transition rules.
10. Update child Step 01 guidance so scaffolded children enforce predecessor Step 06 completion before approval.
11. Update `README.md` for user-visible workflow decomposition behavior, commands/status, storage, journal fields, templates, and guardrails.
12. Add or run validation checks for schema compatibility, required file presence, and documentation guardrails.
13. Preserve all existing Step 04/05 Red-Green contracts and do not implement postponed features.
