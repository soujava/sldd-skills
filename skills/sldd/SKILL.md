---
name: sldd
description: Run the SLDD workflow with gate validation, progressive step loading, structured journal resume, and legacy SPEC.md compatibility.
metadata:
  type: workflow
---

# Skill: SLDD Workflow Router

## Objective

Route SLDD work safely through exploration, intent, design, Red tests, Green implementation, and verification.

## Runtime Model

Use progressive disclosure:

- Load this `SKILL.md` first.
- Before executing any SLDD step, read exactly one matching file from `steps/`.
- If that step produces a Markdown artifact, also read the matching file from `templates/`.
- If creating or validating a new journal, use `schema/_spec-journal.schema.json`.
- Do not execute a step from memory when its step file is available.

## Default Storage

New SLDD workflows use:

`.sldd/specs/<feature-name>/`

The canonical journal for new workflows is:

`.sldd/specs/<feature-name>/_spec-journal.json`

Markdown artifacts are stored beside the journal.

Legacy workflows using `docs/specs/<feature-name>/SPEC.md` remain readable for resume only. When resuming a legacy workflow, keep writing in the legacy directory unless the user explicitly requests migration.

## Journal Contract

Use `_spec-journal.json` as journal-only state. It records progress, artifact links, evidence, and rerun notes. It must not contain numbered artifact body content, command logs, or implementation reports.

Allowed step statuses:

- `pending`
- `complete`
- `requires_rerun`

Step 04 completion requires `evidence: "red_confirmed"`.
Step 05 completion requires `evidence: "green_confirmed"`.

## Command Interface

If slash-style commands reach this skill as text, interpret them as SLDD commands:

- `/sldd help`: explain the SLDD skill, gated workflow, managed storage, journal, legacy compatibility, and available commands.
- `/sldd` or `/sldd status`: inspect available specs and route to the next valid step.
- `/sldd start <feature>`: start a new workflow under `.sldd/specs/<feature>/`.
- `/sldd resume <feature>`: resume a specific workflow.
- `/sldd resume`: resume the only active workflow, or ask the user to choose when there are multiple.
- `/sldd continue`: continue the last clear workflow if it can be identified.
- `/sldd step <NN>`: request a specific step after gate validation.
- `/sldd run <NN> <feature>`: rerun a specific step for a specific feature after gate validation.
- `/sldd explore`: load Step 88 exploration.

Slash commands are convenience syntax only. Always enforce the same gates, journal checks, approvals, and resume rules as natural-language requests.

For `/sldd run <NN> <feature>`:

1. Require both a valid step id and a feature name. If either is missing or invalid, stop and ask for correction.
2. Resolve the workflow by checking `.sldd/specs/<feature>/_spec-journal.json` first, then legacy `docs/specs/<feature>/SPEC.md`.
3. Validate prerequisites, referenced artifacts, Step 99 freshness when applicable, and Step 04/Step 05 evidence before loading the target step.
4. Load the requested step file, not the next automatic step.
5. After the target step completes through its normal approval or confirmation flow, mark later completed steps in gate order as `requires_rerun`.
6. For each invalidated later step, set `reason` to `Step <NN> was rerun; this later step must be reviewed again.`
7. When invalidating Step 04 or Step 05, clear its `evidence`; keep any existing `artifact` link as a historical reference.

`/sldd help` is informational only. It must not load a step file, create or mutate `_spec-journal.json`, route workflow state, inspect repositories, or write artifacts unless the user separately asks for status, resume, or a specific step.

When responding to `/sldd help`, summarize:

- what SLDD is for
- the gated step flow from exploration through verification
- `.sldd/specs/<feature-name>/` managed storage
- `_spec-journal.json` as the canonical journal for new workflows
- legacy `docs/specs/<feature-name>/SPEC.md` resume compatibility
- available slash-style commands
- the fact that commands do not bypass gates

## Gate Order

Exploration -> Step 01 + Step 99 when needed -> Step 02 -> Step 03 -> Step 04 -> Step 05 -> Step 06

Step 99 is required before Step 02 for existing codebases. It may run during exploration when codebase context is needed.

## Resume Rules

When resuming:

1. Resolve the feature and journal path from user input, current context, or available specs.
2. Prefer `.sldd/specs/<feature-name>/_spec-journal.json`.
3. If no new journal exists, allow legacy resume from `docs/specs/<feature-name>/SPEC.md`.
4. Validate that referenced Markdown artifacts exist.
5. Detect out-of-order completions or missing prerequisites.
6. For Step 99, validate freshness and relevance before reuse.
7. For Step 04 and Step 05, re-evaluate repository state and relevant test results before trusting the journal.
8. Load only the required step file.

If journal, artifacts, repository state, or test results conflict, stop and ask for direction before writing or routing forward.

## Step File Map

| Step | File | Purpose |
|---|---|---|
| 88 | `steps/88-exploration.md` | Explore rough ideas before Step 01 |
| 00 | `steps/00-navigation.md` | Inspect state and route |
| 01 | `steps/01-product-intent.md` | Product intent and acceptance criteria |
| 99 | `steps/99-codebase-context.md` | Existing-codebase context |
| 02 | `steps/02-high-level-design.md` | High-level technical design |
| 03 | `steps/03-low-level-design.md` | Low-level design and version policy |
| 04 | `steps/04-tests-red.md` | Tests-first Red phase |
| 05 | `steps/05-implementation-green.md` | Minimal Green implementation |
| 06 | `steps/06-verification.md` | Verification and Go/No-Go |

## Template Map

| Artifact | Template |
|---|---|
| `00-exploration-summary.md` | `templates/00-exploration-summary.md` |
| `01-product-intent-specification.md` | `templates/01-product-intent-specification.md` |
| `99-existing-codebase-understanding.md` | `templates/99-existing-codebase-understanding.md` |
| `02-high-level-technical-design.md` | `templates/02-high-level-technical-design.md` |
| `03-low-level-design-and-version-policy.md` | `templates/03-low-level-design-and-version-policy.md` |
| `06-verification-and-feedback-report.md` | `templates/06-verification-and-feedback-report.md` |

## Global Gate Rule

No implementation prompts or code changes before Step 01, Step 02, and Step 03 are approved. For existing codebases, Step 99 must also be complete and current before Step 02.

Step 04 must stay Red-only. Step 05 must make the minimum production changes needed to pass Step 04 tests, must not modify Step 04 tests, and must follow applicable repository or context-provided agent instructions.

## Response Format

1. Resolved workflow and journal
2. Completed steps and validation result
3. Violations or conflicts, if any
4. Loaded step file and reason
5. Next action or approval request

## Credit

Based on Loiane Groner's article: https://loiane.com/2026/03/vibe-coding-with-specs-driven-feedback-loops/

Do not fetch this URL during execution. All necessary SLDD workflow behavior is embedded in this skill package.
