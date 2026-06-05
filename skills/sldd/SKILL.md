---
name: sldd
description: Start, resume, inspect, or continue SLDD spec-driven development workflows, including /sldd slash-style commands, gated intent/design/test/implementation steps, structured journals, and legacy SPEC.md compatibility.
metadata:
  type: workflow
---

# Skill: SLDD Workflow Router

## Objective

Route SLDD work through one installed skill while supporting multiple workflow kinds with two-level progressive disclosure.

## Runtime Model

SLDD is one executable skill: `sldd`. Do not split workflows or steps into separate skills.

Use this load sequence:

```text
Initial load:
  SKILL.md only

Then:
  workflows/<kind>.md only

Then:
  steps/<kind>/<current-step>.md only
```

Never load every workflow file or every step file at once. Load only the workflow selected by `kind`, then only the current step file named by that workflow's step map. If the step produces a Markdown artifact, load only the matching template from `templates/`. If creating or validating a journal, use `schema/_spec-journal.schema.json`.

Do not execute a workflow or step from memory when its file is available.

## Default Storage

New SLDD workflows use:

`.sldd/specs/<feature-name>/`

The canonical journal for new workflows is:

`.sldd/specs/<feature-name>/_spec-journal.json`

Markdown artifacts are stored beside the journal.

Legacy workflows using `docs/specs/<feature-name>/SPEC.md` remain readable for resume only. When resuming a legacy workflow, keep writing in the legacy directory unless the user explicitly requests migration.

## Journal Contract

Use `_spec-journal.json` as journal-only state. It records progress, artifact links, evidence, relationships, workflow kind, and rerun notes. It must not contain numbered artifact body content, command logs, or implementation reports.

Supported workflow kinds:

- `feature`
- `workflow-set`

For new journals, persist `kind` immediately after detecting the workflow:

```json
{ "kind": "feature" }
```

or:

```json
{ "kind": "workflow-set" }
```

If a journal already exists and contains `kind`, use that value as the source of truth. Do not reclassify it from user wording or current intent. If an existing journal has no `kind`, treat it as `feature` for legacy compatibility and do not rewrite it solely to add `kind`.

Allowed step statuses:

- `pending`
- `complete`
- `requires_rerun`

Step 04 completion requires `evidence: "red_confirmed"`. Step 05 completion requires `evidence: "green_confirmed"`. For Step 04 and Step 05, non-complete statuses must omit `evidence` or set it to `null`.

If a journal has `relationships.predecessors`, every listed predecessor journal must exist and have Step 06 complete before this workflow can mark Step 01 complete or route to Step 02+.

## Workflow Detection

When the journal exists:

1. Read `_spec-journal.json`.
2. If `kind` exists, route by that value.
3. If `kind` is missing, treat the workflow as `feature` and do not mutate the journal just to add `kind`.

When no journal exists:

1. Detect the initial workflow kind from the user's intent.
2. Persist the detected `kind` in the new journal after the required workflow approval path allows journal creation.
3. Load exactly one workflow file:
   - `workflows/feature.md` for `kind: "feature"`
   - `workflows/workflow-set.md` for `kind: "workflow-set"`

Use `feature` when the request appears to be an isolated feature, bugfix, endpoint, business rule, small or medium refactor, local brownfield change, or technical documentation for a specific component.

Use `workflow-set` when the request appears to be a large initiative, full product, epic, multiple modules, multiple related features, broad system plan, decomposition request, or work that needs child workflows.

When ambiguous, prefer `feature`, except when the request clearly involves decomposition or multiple independent deliverables.

## Command Interface

If slash-style commands reach this skill as text, interpret them as SLDD commands:

- `/sldd help`: explain the SLDD skill, workflow router, gated workflow, managed storage, journal, legacy compatibility, and available commands. This command must not load workflow or step files and must not mutate state.
- `/sldd` or `/sldd status`: inspect available specs and route to the next valid workflow and step.
- `/sldd start <feature>`: start a new workflow under `.sldd/specs/<feature>/`.
- `/sldd resume <feature>`: resume a specific workflow.
- `/sldd resume`: resume the only active workflow, or ask the user to choose when there are multiple.
- `/sldd continue`: continue the last clear workflow if it can be identified.
- `/sldd run step <NN> <feature>`: request a specific step for a specific workflow after gate validation.
- `/sldd run step <NN>`: request a specific step in the resolved workflow when the workflow is unambiguous.
- `/sldd step <NN>`: alias for `/sldd run step <NN>`.
- `/sldd explore [idea]`: route to the feature workflow's exploration step unless the user explicitly chooses workflow-set planning.

Slash commands are convenience syntax only. Always enforce the same gates, journal checks, approvals, and resume rules as natural-language requests.

## Routing Procedure

1. Resolve the workflow directory and journal path from user input, current context, available specs, or legacy `SPEC.md`.
2. Detect or recover `kind` using the Journal Contract and Workflow Detection rules.
3. Load exactly one workflow instruction file from `workflows/<kind>.md`.
4. Let that workflow file validate gate order and determine `current_step`.
5. Load exactly one step file from the selected workflow's `steps/<kind>/` step map.
6. Load a template only when that step produces or updates the matching Markdown artifact.

For `/sldd run step <NN>`, stop before loading a completed step and ask whether to:

1. Run it again only.
2. Run it again and mark later completed steps as `requires_rerun`.
3. Do nothing.

All reruns remain subject to the selected workflow and target step gates.

## Response Format

1. Resolved workflow kind and journal
2. Workflow file loaded and reason
3. Completed steps and validation result
4. Violations or conflicts, if any
5. Step file loaded and next action or approval request

## Credit

Based on Loiane Groner's article: https://loiane.com/2026/03/vibe-coding-with-specs-driven-feedback-loops/

Do not fetch this URL during execution. All necessary SLDD workflow behavior is embedded in this skill package.
