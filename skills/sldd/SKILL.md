---
name: sldd
description: Start, resume, inspect, or continue SLDD spec-driven development workflows, including /sldd slash-style commands, gated intent/design/test/implementation steps, structured journals, and legacy SPEC.md compatibility.
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
For Step 04 and Step 05, non-complete statuses must omit `evidence` or set it to `null`.

## Command Interface

If slash-style commands reach this skill as text, interpret them as SLDD commands:

- `/sldd help`: explain the SLDD skill, gated workflow, managed storage, journal, legacy compatibility, and available commands.
- `/sldd` or `/sldd status`: inspect available specs and route to the next valid step.
- `/sldd start <feature>`: start a new workflow under `.sldd/specs/<feature>/`.
- `/sldd resume <feature>`: resume a specific workflow.
- `/sldd resume`: resume the only active workflow, or ask the user to choose when there are multiple.
- `/sldd continue`: continue the last clear workflow if it can be identified.
- `/sldd run step <NN> <feature>`: request a specific step for a specific workflow after gate validation.
- `/sldd run step <NN>`: request a specific step in the resolved workflow when the workflow is unambiguous.
- `/sldd step <NN>`: alias for `/sldd run step <NN>`.
- `/sldd explore [idea]`: load Step 88 exploration. If idea text follows the command, use it as the initial exploration seed.

Slash commands are convenience syntax only. Always enforce the same gates, journal checks, approvals, and resume rules as natural-language requests.

For `/sldd explore [idea]`:

1. Load Step 88 without creating or mutating journals, workflow state, or artifacts by default.
2. If an inline idea is provided, treat the text after `/sldd explore` as the initial exploration seed.
3. If no idea is provided, ask the user for the rough idea before continuing.
4. Establish lightweight project context before asking idea-specific clarification questions.
5. If a context or clarification question can be answered by read-only repository inspection, inspect the repository instead of asking the user.
6. Ask one focused clarification question at a time, provide a recommended answer or default assumption, and ask the user to accept, revise, or reject it.
7. Keep exploration conversational until the user explicitly chooses to formalize, save an optional exploration summary, route to Step 99, or stop.
8. Do not route to Step 01, route to Step 99, or save `00-exploration-summary.md` without explicit user approval.

For `/sldd run step <NN> <feature>`, `/sldd run step <NN>`, and the `/sldd step <NN>` alias:

1. Require a valid step id. If it is missing or invalid, stop and ask for correction.
2. Resolve the workflow from the feature argument, user input, current context, or the only active workflow. If the workflow is ambiguous, ask the user to choose.
3. Validate prerequisites, referenced artifacts, Step 99 freshness when applicable, and Step 04/Step 05 evidence before loading the target step.
4. If prerequisites are missing or stale, stop and route to the missing prerequisite instead of loading the requested step.
5. If the target step is `pending`, load the requested step file only when its gates are satisfied.
6. If the target step is `requires_rerun`, load the requested step file only when its gates are satisfied. After it completes through its normal approval or confirmation flow, mark later completed steps in gate order as `requires_rerun`.
7. If the target step is `complete`, stop before loading the step and ask the user to choose:
   - `1. Run it again only.` Warn that later completed steps will not be marked `requires_rerun`; use only when the user accepts downstream consistency risk.
   - `2. Run it again and mark later completed steps as requires_rerun.`
   - `3. Do nothing.`
8. For option 1, run the step only after explicit confirmation. Do not automatically invalidate later steps. If the target step artifact, files, or journal entry changes, add a journal-only note that Step `<NN>` was run again without downstream invalidation by explicit user choice.
9. For option 2, run the step only after explicit confirmation. After the target step completes through its normal approval or confirmation flow, mark later completed steps in gate order as `requires_rerun`.
10. For each invalidated later step, set `reason` to `Step <NN> was run again; this later step must be reviewed again.`
11. When invalidating Step 04 or Step 05, clear its `evidence`; keep any existing `artifact` link as a historical reference.

All completed-step choices remain subject to the target step's gate checks, approval protocol, save flow, and hard Red/Green contracts.

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
Step 99 completion requires an approved and saved `existing-codebase-understanding.md` artifact.

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
| `existing-codebase-understanding.md` | `templates/existing-codebase-understanding.md` |
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
