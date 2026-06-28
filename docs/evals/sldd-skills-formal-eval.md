# SLDD Skill Formal Evaluation

Date: 2026-06-20 (initial: 2026-06-05; behavioral: 2026-06-17; current refresh: 2026-06-20)
Repository: `soujava/sldd-skills`
Scope: `skills/sldd/SKILL.md`, `skills/sldd/workflows/`, `skills/sldd/steps/`, `skills/sldd/templates/`, `skills/sldd/schema/`, `README.md`, `AGENTS.md`, `install-sldd-skills.sh`
Evaluation type: static prompt, gate, storage, schema, documentation, and process-control assessment
Evaluator: Codex

## 1. Decision Record

Decision: **Go**

Assurance level: **Medium**

The SLDD skill is coherent for controlled use as a single executable, gate-based workflow skill. The architecture remains centered on `skills/sldd/SKILL.md` as the only executable entrypoint, with workflow behavior under `skills/sldd/workflows/`, step behavior under `skills/sldd/steps/<kind>/`, templates under `skills/sldd/templates/`, and the structured journal schema under `skills/sldd/schema/`.

This evaluation specifically rechecked workflow-kind routing, kind-specific completion, and `/sldd resume` selection. The current contract is explicit:

- `feature` workflows complete at `steps["06-verification"].status == "complete"`.
- `workflow-set` workflows complete at `steps["03-verify-workflow-set"].status == "complete"`.
- `/sldd resume` without a workflow name excludes kind-complete workflows, filters blocked workflows through `relationships.predecessors`, resumes automatically only when exactly one active workflow is unblocked, asks when multiple are unblocked, and reports blockers when none are unblocked.

The previously open low-severity issue about abbreviated router journal examples has been resolved by replacing the snippets with minimal schema-valid feature and workflow-set skeletons.

## 2. Evaluation Boundaries

### Included

- Single executable skill entrypoint architecture.
- YAML frontmatter structure in `skills/sldd/SKILL.md`.
- Progressive disclosure from router to one workflow file and one step file.
- Workflow kind detection and kind-specific step maps.
- Kind-specific workflow completion rules.
- `/sldd resume` active-workflow selection.
- Step sequencing, prerequisites, approvals, save flows, and jump-ahead blocking.
- New workflow storage under `.sldd/specs/<feature-name>/`.
- Journal-only `_spec-journal.json` contract and JSON schema.
- Slash command behavior, including `/sldd help`, `/sldd run`, `/sldd step`, and `/sldd explore`.
- Step rerun invalidation through `requires_rerun`.
- Step 88 non-binding exploration semantics.
- Brownfield Step 99 requirement and reuse validation.
- Step 04 Red contract and Step 05 Green contract.
- Workflow-set planning, child scaffolding, child predecessor gates, parent/child boundaries, and parent completion.
- README and AGENTS consistency for user-visible behavior and repository rules.
- Local installer behavior for the single-skill architecture.

### Excluded

- Live model execution.
- Multi-run behavioral benchmark.
- External documentation lookup.
- CI/CD validation.
- Runtime application code execution.
- LICENSE review.

## 3. Artifact Inventory

| Artifact | Role | Lines | Words | Evaluation |
|---|---|---:|---:|---|
| `skills/sldd/SKILL.md` | Single executable router | 217 | 1,442 | Pass |
| `workflows/feature.md` | Feature workflow routing and gates | 102 | 794 | Pass |
| `workflows/workflow-set.md` | Workflow-set routing and gates | 91 | 598 | Pass |
| `steps/feature/00-navigation.md` | Navigation, resume, and rerun routing | 134 | 1,278 | Pass |
| `steps/feature/01-product-intent.md` | Product intent and acceptance criteria | 48 | 398 | Pass |
| `steps/workflow-set/01-workflow-set-plan.md` | Workflow-set parent planning | 64 | 471 | Pass |
| `steps/feature/02-high-level-design.md` | High-level technical design | 46 | 298 | Pass |
| `steps/workflow-set/02-scaffold-children.md` | Workflow-set child scaffolding | 74 | 486 | Pass |
| `steps/feature/03-low-level-design.md` | Low-level design and version policy | 67 | 467 | Pass |
| `steps/workflow-set/03-verify-workflow-set.md` | Workflow-set coordination verification | 49 | 314 | Pass |
| `steps/feature/04-tests-red.md` | Tests-first Red phase | 98 | 925 | Pass |
| `steps/feature/05-implementation-green.md` | Minimal Green implementation | 108 | 1,150 | Pass |
| `steps/feature/06-verification.md` | Verification and Go/No-Go report | 53 | 285 | Pass |
| `steps/feature/88-exploration.md` | Pre-Step-01 exploration | 146 | 1,549 | Pass |
| `steps/feature/99-codebase-context.md` | Brownfield context gate | 47 | 420 | Pass |
| `templates/*.md` | Markdown artifact formats | 181 | 395 | Pass |
| `schema/_spec-journal.schema.json` | Structured journal schema | 327 | n/a | Pass with runtime-check caveat |
| `README.md` | User-facing process documentation | 369 | 2,264 | Pass |
| `AGENTS.md` | Repository agent instructions | 73 | 1,017 | Pass |
| `install-sldd-skills.sh` | Local development symlink installer | 125 | 352 | Pass |

Runtime skill package total: **1,818 lines** (+34 from initial eval).

Runtime Markdown instruction content: **11,335 words** (+1,002 from initial eval).

Repository documentation and installer in scope add **567 lines / 3,633 words**.

## 4. Methodology

This evaluation used static inspection only. The goal was to determine whether the current skill files define a coherent and enforceable process contract when read by an AI agent.

Evidence classes:

1. Structural evidence: frontmatter, directory layout, router map, step files, templates, and schema.
2. Process evidence: gates, sequencing, approvals, save flows, direct execution, and rerun invalidation.
3. Storage evidence: `.sldd/specs` layout, `_spec-journal.json`, and rejection of legacy `SPEC.md` files as current journals.
4. Workflow-set evidence: parent planning, all-or-nothing scaffold, conflict handling, child journal origin, predecessor gates, kind-specific parent completion, and parent/child responsibility boundaries.
5. Resume evidence: active workflow filtering, predecessor blocking, and ambiguity behavior for `/sldd resume`.
6. Risk evidence: ambiguity handling, bypass paths, missing prerequisites, stale state, and behavior drift.
7. Documentation evidence: README and AGENTS alignment with skill behavior and installer behavior.

Static checks performed:

```text
find skills/sldd -maxdepth 3 -type f
wc -l skills/sldd/SKILL.md skills/sldd/workflows/*.md skills/sldd/steps/*/*.md skills/sldd/templates/*.md skills/sldd/schema/_spec-journal.schema.json README.md AGENTS.md install-sldd-skills.sh docs/evals/sldd-skills-formal-eval.md
wc -w skills/sldd/SKILL.md skills/sldd/workflows/*.md skills/sldd/steps/*/*.md skills/sldd/templates/*.md README.md AGENTS.md install-sldd-skills.sh docs/evals/sldd-skills-formal-eval.md
jq empty skills/sldd/schema/_spec-journal.schema.json
rg -n "Workflow completion|Completion Rule|Active Workflow Selection|workflow-final|06-verification|03-verify-workflow-set|/sldd resume|kind-specific|red_confirmed|green_confirmed|requires_rerun" skills/sldd README.md AGENTS.md
rg -n "sldd-88-approval-helper|sldd-88-shared-templates-and-protocols|shared-templates-and-protocols|Shared Save Decision|Compact Step Template|skills/\*/SKILL.md|sldd-00-process-overview|Step 89|03-verify-set|current_step|top-level feature" skills/sldd README.md AGENTS.md install-sldd-skills.sh
git diff --check
```

Observed result:

- The runtime package contains one executable skill entrypoint: `skills/sldd/SKILL.md`.
- Workflow files, step files, templates, and schema are present in the expected locations.
- Required behavior anchors are present for kind-specific completion, `/sldd resume`, Red/Green evidence, reruns, and workflow-set verification.
- `jq empty skills/sldd/schema/_spec-journal.schema.json` passed.
- `git diff --check` passed after trailing whitespace was removed from newly edited lines.
- The stale-reference scan returned only intentional references to unsupported fields, such as text explaining that `current_step` must not be persisted.
- README now documents kind-specific completion and `/sldd resume` selection as first-class operational rules.
- AGENTS now preserves those same rules for future repository work.

## 5. Formal Control Assessment

Scoring:

- 0: not present
- 1: materially weak
- 2: weak or internally conflicted
- 3: acceptable with clarification needed
- 4: strong with residual runtime judgment
- 5: complete and explicit

| Control ID | Control Objective | Weight | Score | Weighted Result | Status |
|---|---|---:|---:|---:|---|
| C01 | Single executable SLDD entrypoint is preserved | 8 | 5 | 40 | Pass |
| C02 | Router uses progressive disclosure and exact step loading | 8 | 5 | 40 | Pass |
| C03 | Skill metadata is valid and stable | 5 | 5 | 25 | Pass |
| C04 | Feature step ordering prevents invalid jumps | 10 | 5 | 50 | Pass |
| C05 | Feature prerequisites are explicit per step | 10 | 5 | 50 | Pass |
| C06 | Approval is required before persistence/progress when needed | 10 | 4 | 40 | Pass |
| C07 | `_spec-journal.json` remains journal-only | 10 | 5 | 50 | Pass |
| C08 | JSON schema constrains journal status and evidence | 8 | 4 | 32 | Pass with caveat |
| C09 | Legacy `SPEC.md` files do not satisfy the current journal contract | 6 | 5 | 30 | Pass |
| C10 | `/sldd help` is informational and non-mutating | 6 | 5 | 30 | Pass |
| C11 | Explicit step reruns invalidate later completed steps | 9 | 5 | 45 | Pass |
| C12 | Exploration summary is non-binding context only | 8 | 5 | 40 | Pass |
| C13 | Brownfield Step 99 is enforced and reuse-validated | 8 | 4 | 32 | Pass |
| C14 | Step 04 enforces strict Red phase and direct-execution limits | 9 | 4 | 36 | Pass |
| C15 | Step 05 protects tests and implements only minimal Green changes | 9 | 4 | 36 | Pass |
| C16 | Step 05 respects repository and context-provided agent instructions | 7 | 5 | 35 | Pass |
| C17 | Step 06 requires explicit Go/No-Go | 6 | 4 | 24 | Pass |
| C18 | README matches user-visible process behavior | 7 | 5 | 35 | Pass |
| C19 | Installer targets single-skill architecture and removes legacy entries | 5 | 4 | 20 | Pass |
| C20 | Workflow-set recommendation is explicit and non-forcing | 7 | 5 | 35 | Pass |
| C21 | Workflow-set parent creation gate is coherent | 9 | 5 | 45 | Pass |
| C22 | Workflow-set scaffold and conflict semantics are coherent | 9 | 5 | 45 | Pass |
| C23 | Scaffolded child predecessor gate is explicit | 8 | 4 | 32 | Pass |
| C24 | Workflow-set parent does not own child execution progress | 7 | 5 | 35 | Pass |
| C25 | Workflow completion is kind-specific and documented | 8 | 5 | 40 | Pass |
| C26 | `/sldd resume` active-workflow selection is deterministic | 8 | 5 | 40 | Pass |
| C27 | Router journal examples are schema-valid | 5 | 5 | 25 | Pass |
| C28 | AGENTS preserves current process invariants | 6 | 5 | 30 | Pass |

Weighted score: **1,012 / 1,075**

Normalized score: **94.1 / 100**

Formal result: **Pass**

## 6. Findings

### Resolved Low: Abbreviated journal examples were schema-incomplete

The router previously showed `name` and `kind` snippets that were useful for explaining immediate persistence but were not complete journal skeletons under the schema.

Resolution:

- `skills/sldd/SKILL.md` now shows minimal schema-valid feature and workflow-set journal examples.
- The feature example includes `schema_version`, `name`, `workflow`, `kind`, and `steps`.
- The workflow-set example includes the required parent workflow-set steps and `workflowSet.children`.

Impact:

- Agents reading the router first are less likely to create invalid journals by copying an abbreviated snippet.

### Resolved Documentation Gap: Completion and resume rules were not first-class in README

The router and workflow files defined kind-specific completion, but README did not previously present it as a standalone operational rule.

Resolution:

- `README.md` now documents kind-specific completion for `feature` and `workflow-set`.
- `README.md` now documents `/sldd resume` active-workflow selection.
- `README.md` clarifies that a complete workflow-set parent does not imply complete child feature workflows.
- `AGENTS.md` now preserves these same invariants for future changes.

Impact:

- User-facing documentation now matches the router behavior for active workflow filtering, predecessor blocking, automatic resume, and ambiguity handling.

### Accepted Runtime Caveat: Predecessor truth requires journal reads

The schema can represent `relationships.predecessors`, but it cannot prove that predecessor journals exist or that their final kind-specific completion step is complete. The router and navigation step require runtime validation for this.

Impact:

- This is expected for a prompt skill. Agents must inspect predecessor journals at runtime before completing Step 01 or routing to Step 02+.

Recommendation:

- Keep predecessor validation as an explicit runtime check. Do not attempt to encode filesystem-dependent predecessor completion in the JSON schema.

### Accepted Runtime Caveat: Workflow-set parent completion is not child completion

Workflow-set completion is intentionally scoped to the parent coordination flow. A parent may complete while child workflows remain pending.

Impact:

- This is correct for the current architecture, but users may misread a complete parent as a complete initiative.

Resolution:

- README now states that parent completion means planning, scaffold, and coordination verification are complete, while child feature progress is computed from child journals.

## 7. Architecture Assessment

Requirement: `skills/sldd/SKILL.md` is the only executable SLDD skill entrypoint.

Result: **Pass**

Evidence:

- `skills/sldd/SKILL.md` contains the skill frontmatter and routes all workflow behavior.
- Workflow behavior lives under `skills/sldd/workflows/`.
- Step behavior lives under `skills/sldd/steps/`.
- Markdown artifact formats live under `skills/sldd/templates/`.
- Journal schema lives under `skills/sldd/schema/`.
- The installer links only `skills/sldd` and removes prior `sldd-*` entries from the target skills directory.
- README and AGENTS document the single-skill runtime architecture.

Residual risk:

- Installer cleanup removes target directories matching `sldd-*`. That matches the single-skill migration intent, but users with manual edits in installed target directories could lose them.

## 8. Gate Integrity Matrix

| Gate | Required Behavior | Enforced By | Status |
|---|---|---|---|
| Exploration remains pre-Step-01 | Do not create numbered artifacts unless formalization is requested | Step 88 | Pass |
| Workflow-set recommendation | Recommend decomposition for large ideas without forcing it | Router, Step 88, Step 01 | Pass |
| Workflow-set parent creation | Create parent workflow-set only after approval | Router, Step 00, Step 01 workflow-set | Pass |
| Workflow-set child scaffolding | Scaffold children only after explicit scaffold approval | Router, Step 01 workflow-set, Step 02 scaffold | Pass |
| Workflow-set parent/child boundary | Parent does not execute children or store child execution progress | Router, Step 00, Step 03 workflow-set | Pass |
| Workflow-set parent completion | Parent completes only at `03-verify-workflow-set` | Router, workflow-set workflow, README, AGENTS | Pass |
| Feature completion | Feature completes only at `06-verification` | Router, feature workflow, README, AGENTS | Pass |
| `/sldd resume` active filtering | Exclude kind-complete workflows before resolving active candidates | Router, README, AGENTS | Pass |
| `/sldd resume` unblocked selection | Auto-resume exactly one unblocked active workflow, otherwise ask or report blockers | Router, README, AGENTS | Pass |
| Child predecessor gate | Do not approve child Step 01 until predecessor Step 06 is complete | Router, Step 00, Step 01 | Pass |
| Step 01 before Step 02 | Block design until product intent is approved | Router, Step 00, Step 02 | Pass |
| Step 99 before Step 02 for brownfield work | Require current codebase context before design | Router, Step 00, Step 02, Step 99 | Pass |
| Step 99 reuse validation | Reuse only if current and relevant to approved Step 01 scope | Router, Step 00, Step 02, Step 88, Step 99 | Pass |
| Step 02 before Step 03 | Do not produce low-level design before high-level design | Step 03 | Pass |
| Step 02 and Step 03 before Step 04 | Do not write tests before approved design | Router, Step 04 | Pass |
| Step 04 Red before Step 05 Green | Require Red confirmation before implementation | Router, Step 05, schema | Pass |
| Step 04 direct execution | Execute directly only when approved artifacts are sufficient | Step 04 | Pass |
| Step 05 direct execution | Execute directly only when Red state, scope, commands, and instructions are clear | Step 05 | Pass |
| Step 05 does not modify tests | Preserve Step 04 test integrity | Step 05 | Pass |
| Step 05 respects repo/context instructions | Inspect and follow repository and agentic instructions present in context | Step 05 | Pass |
| Step 06 after Step 05 | Verify only after Green confirmation | Router, Step 06, schema | Pass |
| Rerun invalidation | Later completed steps become `requires_rerun` after rerun | Router, Step 00, schema | Pass |
| Approval before persistence/progress | Do not persist artifacts/checklist progress without required approval or Red/Green confirmation | Steps 01-06, 88, 99, workflow-set steps | Pass |
| `_spec-journal.json` journal-only | Do not store artifact bodies, logs, or reports in the journal | Router, Step 00, schema | Pass |

## 9. Per-Component Assessment

### `skills/sldd/SKILL.md`

Result: **Pass**

Strengths:

- Defines progressive disclosure and routes by `kind`.
- Keeps `/sldd help` informational only.
- Defines canonical storage under `.sldd/specs/<feature-name>/`.
- Rejects legacy `SPEC.md` files as non-journal state under the current `_spec-journal.json` contract.
- Defines Red and Green evidence requirements.
- Defines kind-specific completion and `/sldd resume` selection.
- Provides schema-valid minimal journal examples.

Residual risk:

- Router correctness still depends on runtime judgment for brownfield detection, Step 99 freshness, and predecessor journal validation.

### `workflows/feature.md`

Result: **Pass**

Strengths:

- Defines formal feature gate order.
- Requires Step 99 before Step 02 for existing codebases.
- Preserves Red-only Step 04 and minimal Green Step 05.
- Defines feature completion at `06-verification`.

### `workflows/workflow-set.md`

Result: **Pass**

Strengths:

- Defines parent sequence as `01-workflow-set-plan -> 02-scaffold-children -> 03-verify-workflow-set`.
- Keeps parent responsibilities limited to planning, scaffolding, and coordination verification.
- Defines workflow-set completion at `03-verify-workflow-set`.
- Keeps child execution progress out of the parent journal.

### Feature Steps

Result: **Pass**

Strengths:

- Step 00 centralizes routing, invalid jump blocking, targeted step handling, and interrupted Red/Green resume.
- Step 88 remains non-binding and recommends workflow-set planning without forcing artifacts.
- Step 99 provides an approved and saved brownfield context gate.
- Steps 01-03 preserve product intent and design approval before tests and implementation.
- Step 04 records Red evidence without production implementation.
- Step 05 protects tests and records Green evidence after minimal implementation.
- Step 06 requires Red and Green evidence before verification.

Residual risk:

- Direct execution in Steps 04 and 05 still depends on the agent detecting ambiguity, stale test state, and repository-specific constraints.

### Workflow-Set Steps

Result: **Pass**

Strengths:

- Step 01 separates parent planning from child scaffolding.
- Step 02 requires completed parent plan plus separate scaffold approval.
- Step 02 keeps child Step 01 pending and uses `origin.type: "workflow-set-scaffold"`.
- Step 03 verifies coordination consistency without requiring child workflows to complete.
- Accepted conflicts remain coordination states, not successful child creation.

Residual risk:

- Step 02 depends on runtime validation that the saved parent plan artifact matches parent journal children before scaffold.

## 10. Storage and Schema Assessment

Result: **Pass with runtime-check caveat**

Strengths:

- New workflows use `.sldd/specs/<feature-name>/`.
- `_spec-journal.json` is canonical for new workflows.
- Required journal fields are constrained by schema: `schema_version`, `name`, `workflow`, `kind`, and `steps`.
- Step status is limited to `pending`, `complete`, and `requires_rerun`.
- Evidence is limited to `red_confirmed`, `green_confirmed`, or `null`.
- Step 04 complete requires `red_confirmed`; Step 05 complete requires `green_confirmed`.
- Feature journals reject workflow-set step keys and top-level `workflowSet`.
- Workflow-set journals require workflow-set parent step keys and `workflowSet.children`.
- Router and steps prohibit artifact bodies, command logs, and implementation reports in the journal.

Residual risk:

- The schema cannot validate artifact existence, Step 99 freshness, Red/Green truth, predecessor completion, or parent/child consistency.

## 11. Documentation and Installer Assessment

Result: **Pass**

Strengths:

- README describes the single-skill architecture accurately.
- README documents `.sldd/specs`, `_spec-journal.json`, journal fields, invalid legacy journal handling, command syntax, `/sldd help`, `/sldd run`, `/sldd explore`, Step 99 behavior, workflow-set decomposition, child scaffold guardrails, kind-specific completion, and `/sldd resume` selection.
- AGENTS preserves the repository invariants for entrypoint, workflow/step/template/schema placement, journal fields, workflow-set boundaries, kind-specific completion, `/sldd resume`, Red/Green evidence, reruns, and Conventional Commit usage.
- Installer links `skills/sldd` into the selected skill directory and cleans legacy `sldd-*` entries.

Residual risk:

- Installer cleanup removes target directories matching `sldd-*`. This is practical for migration, but users with local edits in those installed target directories could lose them.

## 12. Recommendations

1. Add live scenario evals before raising assurance above Medium.
2. Prioritize live evals for:
   - `/sldd resume` with one active unblocked workflow and several complete workflows,
   - `/sldd resume` with multiple unblocked active workflows,
   - `/sldd resume` with only blocked active workflows,
   - workflow-set parent completion with pending child feature workflows,
   - child scaffold with a name collision,
   - child Step 01 blocked by incomplete predecessor,
   - Step 04 direct Red execution,
   - Step 05 direct Green execution.
3. Define objective No-Go examples for Step 06 if verification quality varies across users or agents.
4. Consider warning more explicitly in installer output before removing legacy target directories.

## 13. Final Decision

Final result: **Go**

The current SLDD skill preserves the single-entrypoint architecture, gated feature workflow, workflow-set parent flow, managed storage, structured journal, rerun invalidation, invalid legacy journal handling, Step 88/Step 99 boundary, and Step 04/Step 05 Red-Green contract.

The latest documentation updates close the observed gap around workflow completion and `/sldd resume` selection. The router examples now match the schema-required journal shape. Remaining risk is runtime validation work that a static schema cannot prove.

## 14. Behavioral Evaluation Addendum

Date: 2026-06-17 (static checks refreshed: 2026-06-20)

Evaluation type: single-run behavioral comparison using `codex exec` with explicit SLDD skill loading versus a no-skill baseline.

Workspace: `/tmp/sldd-eval-workspace/iteration-1`

Static prechecks (refreshed 2026-06-20):

```text
jq empty skills/sldd/schema/_spec-journal.schema.json
git diff --check
rg -n "Workflow completion|Completion Rule|Active Workflow Selection|workflow-final|06-verification|03-verify-workflow-set|/sldd resume|kind-specific|red_confirmed|green_confirmed|requires_rerun|Minimal Green|Strict Red-Phase" skills/sldd README.md AGENTS.md
```

Observed result (2026-06-20):

- JSON schema validation passed.
- `git diff --check` passed.
- Required routing, completion, Red/Green evidence, rerun, and workflow-set anchors were present.
- Stale-reference scan returned only intentional references to unsupported fields such as `current_step`.
- Single entrypoint: only `skills/sldd/SKILL.md` (no other `SKILL.md` in `skills/`).
- No stale references to removed patterns (`sldd-88-*`, `top-level feature`, `current_step` as stored field).

The behavioral run (2026-06-17) used the working tree with edits in:

- `skills/sldd/steps/feature/04-tests-red.md` — added architectural constraint testing requirements.
- `skills/sldd/steps/feature/05-implementation-green.md` — added prohibition against replacing approved mechanisms with fakes or in-memory substitutes.

As of 2026-06-17, those edits were committed as `fe84faa` and `9980285`, respectively. The current working tree (2026-06-20) has no uncommitted changes in any skill file.

### Behavioral Test Set

| Eval | Scenario | with skill | baseline | Result |
|---|---|---:|---:|---|
| `resume-blocking` | `/sldd resume` with completed, blocked, and multiple unblocked workflows | 5 / 5 | 3 / 5 | Skill avoided invalid auto-selection and avoided inventing a step path |
| `red-green-constraints` | Step 04/05 with approved PostgreSQL, JWT, and Auth -> Audit event constraints | 4 / 4 | 3 / 4 | Skill preserved strict Red stubs, Green evidence, and test integrity |
| `workflow-set-boundary` | Workflow-set parent complete while child features remain mixed | 4 / 4 | 0 / 4 | Skill preserved parent/child boundary and refused automatic child selection |

Aggregate result:

| Configuration | Assertions Passed | Pass Rate |
|---|---:|---:|
| with skill | 13 / 13 | 100% |
| baseline | 6 / 13 | 46% |

The strongest behavioral lift was in workflow-set semantics and active workflow selection. The baseline often applied reasonable generic judgment, but it failed on SLDD-specific rules:

- It auto-selected `fraud-check` during `/sldd resume` even though `shipping` was also unblocked.
- It invented `.sldd/steps/04-implementation.md`, which is not a valid SLDD step file.
- It treated workflow-set parent completion as dependent on child completion.
- It auto-selected the first incomplete child instead of asking when multiple children were actionable.

### Behavioral Findings

#### Pass: `/sldd resume` Ambiguity Handling

The with-skill run correctly excluded complete workflows by kind-specific completion:

- `payments`: `feature` complete at `06-verification`.
- `catalog-parent`: `workflow-set` complete at `03-verify-workflow-set`.

It also correctly identified `billing` as blocked by incomplete predecessor `fraud-check`, while treating `shipping` and `fraud-check` as two unblocked active candidates. Because multiple candidates were unblocked, it asked the user to choose and did not load a step file prematurely.

#### Pass: Step 04 / Step 05 Architectural Constraints

The with-skill run correctly treated Step 03 constraints as binding:

- PostgreSQL persistence
- JWT validation
- `Auth -> Audit` communication via event

It required Step 04 tests or verification checks for those approved mechanisms, preserved strict Red-only behavior, allowed only throwing compile stubs when needed, refused in-memory Green implementation, and refused Step 05 test modification.

#### Pass: Workflow-Set Parent / Child Boundary

The with-skill run correctly reported the workflow-set parent as complete because `03-verify-workflow-set` was complete. It separately reported child feature status from child journals, did not persist child execution progress in the parent, and refused automatic child selection because both `checkout` and `notifications` were actionable.

### Updated Decision

Decision: **Go**

Assurance level: **Medium+**

The previous static evaluation remains valid, and the behavioral comparison confirms that the SLDD skill materially improves adherence to the most SLDD-specific rules tested in this round. Assurance remains below High because this was a single-run comparison with three scenarios, not a multi-run variance benchmark.
