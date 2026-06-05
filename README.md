# SLDD Skill

SLDD is a runtime skill for **Spec Loops Driven Development**: a gated, specs-driven workflow for disciplined AI-assisted development.

The skill keeps product intent, architecture, test design, implementation, and verification in separate approval phases so AI-assisted coding stays fast without bypassing engineering control.

## Based On

This work is based on Loiane Groner's article [Vibe Coding, But Production-Ready: A Specs-Driven Feedback Loop for AI-Assisted Development](https://loiane.com/2026/03/vibe-coding-with-specs-driven-feedback-loops/).

> The goal is not to stop vibe coding. The goal is to add engineering control around vibe coding so we can keep speed without sacrificing quality.

## Installation

Install with the Skills CLI:

```bash
npx skills add soujava/sldd-skills
```

Install manually for Claude Code:

```bash
git clone https://github.com/soujava/sldd-skills.git
cp -r sldd-skills/skills/sldd ~/.claude/skills/
```

Install manually for OpenCode:

```bash
git clone https://github.com/soujava/sldd-skills.git
cp -r sldd-skills/skills/sldd ~/.agents/skills/
```

For local development, install `skills/sldd` as a symlink:

```bash
./install-sldd-skills.sh
```

Use a different target directory:

```bash
./install-sldd-skills.sh --target ~/.claude/skills
```

Install a copy instead of a symlink:

```bash
./install-sldd-skills.sh --copy
```

The installer uses `skills/sldd` as the source skill, defaults to `$HOME/.agents/skills`, removes previous `sldd` and legacy `sldd-*` entries in the target directory, and creates exactly one installed skill at `<target>/sldd`. Restart or reload the consuming CLI after changing the skill.

## Architecture

SLDD is distributed as one executable skill entrypoint:

```text
skills/sldd/SKILL.md
```

`SKILL.md` is a workflow router. It resolves the workflow kind, validates journal state, interprets `/sldd` commands, then loads only the selected workflow file and current step file.

The skill package is organized as:

```text
skills/sldd/
  SKILL.md
  workflows/
  steps/
  templates/
  schema/
```

- `workflows/` defines kind-specific step order, gate rules, resume rules, and step maps.
- `steps/<kind>/` defines step behavior, approval protocol, save behavior, and response format.
- `templates/` defines Markdown artifact formats.
- `schema/_spec-journal.schema.json` defines the journal contract.

SLDD uses progressive disclosure:

```text
Initial load: SKILL.md
Then:         workflows/<kind>.md
Then:         steps/<kind>/<current-step>.md
Optional:     one template, only when the current step writes a Markdown artifact
```

Do not split SLDD into multiple executable skills. Keep `skills/sldd/SKILL.md` as the only runtime entrypoint.

## Workflow Kinds

SLDD supports two workflow kinds.

| Kind | Use for | Workflow file |
|---|---|---|
| `feature` | Isolated features, bugfixes, endpoints, business rules, local refactors, component documentation, and other single-workflow changes | `skills/sldd/workflows/feature.md` |
| `workflow-set` | Large initiatives, products, epics, multi-module work, broad system plans, decomposition requests, and work that needs child workflows | `skills/sldd/workflows/workflow-set.md` |

New journals persist `kind` as `feature` or `workflow-set`. Existing journals with `kind` use that value as source of truth. Existing journals without `kind` are treated as `feature` for legacy compatibility and are not rewritten solely to add `kind`.

When workflow type is ambiguous, SLDD prefers `feature` unless the request clearly requires decomposition or multiple independent deliverables.

## Spec Storage

New workflows store artifacts under:

```text
.sldd/specs/<feature-name>/
  _spec-journal.json
  00-exploration-summary.md
  01-product-intent-specification.md
  existing-codebase-understanding.md
  02-high-level-technical-design.md
  03-low-level-design-and-version-policy.md
  06-verification-and-feedback-report.md
```

Workflow-set parents use the same directory pattern and may also contain:

```text
01-workflow-set-plan.md
```

Child workflows scaffolded from a workflow-set are normal `feature` workflows with their own `.sldd/specs/<child-name>/_spec-journal.json`.

Commit `.sldd/specs` with the code changes it governs. The journal is canonical progress state; Markdown artifacts contain reviewed spec content.

Legacy workflows using `docs/specs/<feature-name>/SPEC.md` remain readable for resume compatibility. When SLDD resumes a legacy workflow, it keeps writing in that legacy directory unless the user explicitly requests migration.

## Journal Contract

`_spec-journal.json` records workflow state only: progress, artifact links, evidence, relationships, workflow kind, reasons, rerun notes, and workflow-set scaffold state. It must not contain numbered artifact body content, command logs, or implementation reports.

Required schema concepts include:

| Field | Meaning |
|---|---|
| `schema_version` | Journal schema version, currently `1` |
| `feature` | Workflow directory/name identifier |
| `workflow` | Always `sldd` |
| `kind` | `feature` or `workflow-set` |
| `current_step` | Current step id |
| `steps` | Per-step status, artifact links, evidence, reason, origin, and timestamps |
| `relationships.parents` | Parent workflow references for scaffolded children |
| `relationships.predecessors` | Workflow journals that must complete Step 06 before this workflow may complete Step 01 or route to Step 02+ |
| `workflowSet.children` | Workflow-set parent child definitions and scaffold state |
| `origin.type` | `workflow-set-scaffold` on scaffolded child Step 01 entries |
| `notes` | Concise journal-only notes |

Allowed step statuses are:

- `pending`
- `complete`
- `requires_rerun`

Step 04 completion requires `evidence: "red_confirmed"`. Step 05 completion requires `evidence: "green_confirmed"`. Non-complete Step 04 and Step 05 entries must omit evidence or set it to `null`.

Workflow-set child scaffold states are:

- `proposed`
- `created`
- `conflict`

Parent workflow-set journals must not persist child execution progress. Status and resume output may compute child progress by reading child journals.

## Feature Workflow

Feature workflows follow this gate order:

```text
88 exploration (optional) -> 00 navigation -> 01 -> 99 when needed -> 02 -> 03 -> 04 -> 05 -> 06
```

The formal gate order is:

```text
01 -> 99 -> 02 -> 03 -> 04 -> 05 -> 06
```

Step 99 is required before Step 02 for existing codebases. It is optional for greenfield work.

| Step | File | Purpose |
|---|---|---|
| 88 | `steps/feature/88-exploration.md` | Explore rough ideas before formal Step 01 |
| 00 | `steps/feature/00-navigation.md` | Resolve journal state and route to the next valid step |
| 01 | `steps/feature/01-product-intent.md` | Define product intent, scope, success criteria, risks, and acceptance criteria |
| 99 | `steps/feature/99-codebase-context.md` | Capture approved existing-codebase context for brownfield work |
| 02 | `steps/feature/02-high-level-design.md` | Define architecture, responsibilities, boundaries, data flow, and test map |
| 03 | `steps/feature/03-low-level-design.md` | Define contracts, models, error model, tests, dependencies, and version policy |
| 04 | `steps/feature/04-tests-red.md` | Write tests first and confirm Red |
| 05 | `steps/feature/05-implementation-green.md` | Make minimal production changes and confirm Green |
| 06 | `steps/feature/06-verification.md` | Audit compliance and produce a Go/No-Go decision |

Core feature gates:

- No implementation before Step 01, Step 02, and Step 03 are approved.
- Step 88 repository observations are conversational context only.
- Step 99 satisfies the brownfield gate only after `existing-codebase-understanding.md` is approved, saved, current, and marked complete.
- Step 04 writes tests only and records Red confirmation in the journal.
- Step 05 makes minimal production changes, does not modify Step 04 tests, follows applicable repository instructions, and records Green confirmation in the journal.
- Step 04 and Step 05 are journal-evidence phases, not mandatory Markdown report phases.
- Step 06 writes `06-verification-and-feedback-report.md`.

If `relationships.predecessors` exists, every predecessor journal must exist and have Step 06 complete before this workflow can complete Step 01 or load Step 02+.

## Workflow-Set Workflow

Workflow-set parents decompose large work into child feature workflows:

```text
01-workflow-set-plan -> 02-scaffold-children -> 03-verify-workflow-set
```

| Step | File | Purpose |
|---|---|---|
| `01-workflow-set-plan` | `steps/workflow-set/01-workflow-set-plan.md` | Define the decomposition plan |
| `02-scaffold-children` | `steps/workflow-set/02-scaffold-children.md` | Create approved child workflow drafts |
| `03-verify-workflow-set` | `steps/workflow-set/03-verify-workflow-set.md` | Verify coordination consistency |

Workflow-set parents plan, scaffold, and verify coordination. They do not execute children, approve child Step 01, enforce child implementation gates, or persist child execution progress.

Child scaffolding requires:

- completed and approved workflow-set plan;
- separate explicit scaffold approval;
- valid child names, scopes, dependencies, and predecessor references;
- no predecessor cycles;
- no unsafe overwrite without explicit approval.

Scaffold is all-or-nothing for valid proposed children. Filesystem collisions or unsafe overwrite risks may be recorded as `conflict` only after explicit user approval. `03-verify-workflow-set` may complete with accepted conflicts only when the user explicitly accepts that those children were not scaffolded and should remain recorded for later resolution.

Each created child gets:

```text
.sldd/specs/<child-name>/
  _spec-journal.json
  01-product-intent-specification.md
```

Created child journals use `kind: "feature"`. Child Step 01 remains `pending` and records `origin.type: "workflow-set-scaffold"`.

## Commands

When slash-style commands reach the skill as text, `sldd` interprets them as workflow commands:

```text
/sldd
/sldd help
/sldd status
/sldd start <feature>
/sldd resume <feature>
/sldd resume
/sldd continue
/sldd run step <NN> <feature>
/sldd run step <NN>
/sldd step <NN>
/sldd explore [idea]
```

Slash commands do not bypass gates. `/sldd run step 05 user-auth`, `/sldd run step 05`, and `/sldd step 05` still require approved Step 01, Step 02, Step 03, and Step 04 Red confirmation.

`/sldd help` is informational only. It explains the skill, command interface, gated workflow, `.sldd/specs` storage, `_spec-journal.json`, and legacy `SPEC.md` resume compatibility without loading workflow or step files and without mutating state.

`/sldd explore [idea]` starts Step 88 exploration. The skill establishes lightweight project context, inspects the repository instead of asking questions the codebase can answer, asks one focused clarification question at a time, includes a recommended answer or default assumption, and offers explicit exits: continue exploring, formalize Step 01, save an optional summary after approval, route to Step 99 when needed, or stop without saving.

When a requested step is already complete, SLDD stops before loading it and asks whether to:

1. Run it again only.
2. Run it again and mark later completed steps as `requires_rerun`.
3. Do nothing.

All reruns remain subject to the selected workflow gates, approval protocol, save flow, and Red/Green contracts.

## Usage

Explore a rough idea:

```text
/sldd explore Add a contributor onboarding checklist.
```

Start a feature workflow:

```text
/sldd start user-auth

Feature idea: Build user authentication with email/password and OAuth providers.
```

Resume a workflow:

```text
/sldd resume user-auth
```

Request a specific step:

```text
/sldd run step 04 user-auth
```

Ask for help:

```text
/sldd help
```

For brownfield work, run or complete Step 99 before Step 02. Conversational or unsaved codebase context does not satisfy the Step 99 gate.

For greenfield work, skip Step 99 and proceed from Step 01 to Step 02.

## Development Rules

- Keep `skills/sldd/SKILL.md` as the only executable SLDD skill entrypoint.
- Keep workflow behavior under `skills/sldd/workflows/`.
- Keep step behavior under `skills/sldd/steps/`.
- Keep artifact formats under `skills/sldd/templates/`.
- Keep journal schema files under `skills/sldd/schema/`.
- Preserve YAML frontmatter in `skills/sldd/SKILL.md`: `name`, `description`, and `metadata.type`.
- Preserve progressive disclosure: route through `SKILL.md`, then one workflow file, then one step file, and load templates only for produced Markdown artifacts.
- Preserve `.sldd/specs/<feature-name>/_spec-journal.json` as the canonical journal for new workflows.
- Preserve legacy `docs/specs/<feature-name>/SPEC.md` resume compatibility until explicitly removed.
- Preserve the Step 88/Step 99 boundary: exploration context is conversational; Step 99 is the approved and saved brownfield context gate.
- Preserve the Step 04/Step 05 Red-Green contract.
- Preserve workflow-set parent sequencing and boundaries.
- Update this README when user-visible process behavior, sequencing, gates, approval semantics, commands, journal fields, storage, templates, installer options, or step responsibilities change.

Use Conventional Commits for repository commits:

```text
<type>(optional-scope): <description>
```

## Further Reading

- [Vibe Coding, But Production-Ready: A Specs-Driven Feedback Loop for AI-Assisted Development](https://loiane.com/2026/03/vibe-coding-with-specs-driven-feedback-loops/)
- [Claude Code custom instructions](https://docs.anthropic.com/en/docs/claude-code/tutorials#custom-instructions)
- [OpenCode skills](https://opencode.ai/docs/skills)
- [Cursor rules](https://docs.cursor.com/context/rules-for-ai)
- [GitHub Copilot custom instructions](https://docs.github.com/en/copilot/customizing-copilot/adding-custom-instructions)

## License

The SLDD methodology and original article content are by Loiane Groner and licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).

This skills implementation is provided for community use.
