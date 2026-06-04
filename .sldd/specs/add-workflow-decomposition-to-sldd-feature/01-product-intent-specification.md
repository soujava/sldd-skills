# Problem Statement

The SLDD skill currently supports a linear feature workflow, but it does not provide a formal way to decompose large ideas into coordinated but independently executable workflows.

Large initiatives can produce oversized Step 01 artifacts, mixed acceptance criteria, unclear dependencies, and unsafe execution ordering. SLDD needs a general workflow decomposition capability that lets the agent recommend a workflow-set for large ideas, create a parent planning workflow, scaffold child feature workflows as pending Step 01 drafts, and preserve all existing SLDD gates.

This change improves the SLDD skill so it can recommend and manage workflow decomposition for large ideas by creating workflow-set parent workflows and scaffolded child feature workflows, while preserving existing feature workflow behavior and SLDD gates.

# Target Users

- Developers using SLDD to implement large features, modules, platforms, migrations, or roadmap-sized work.
- AI agents using the SLDD skill to route work safely through gates.
- Maintainers of the SLDD skill who need decomposition behavior to remain explicit, resumable, and compatible with existing workflows.

# Formalized Exploration Decisions

Source of truth:

- `workflow-decomposition-refinement.md#refinement-50-final-decision-summary`
- `workflow-decomposition-refinement.md#refinement-51-formal-sldd-change-plan`
- `workflow-decomposition-refinement.md#refinement-52-refinement-closure`

Closed first-version decisions:

- Workflow decomposition is a general SLDD capability, not OpenAPI-specific.
- Supported workflow kinds are `feature` and `workflow-set`.
- Missing `kind` means `feature` for backward compatibility.
- Feature workflows keep the existing SLDD gate flow.
- Workflow-set workflows use dedicated parent steps:
  - `01-workflow-set-plan`
  - `02-scaffold-children`
  - `03-verify-workflow-set`
- Workflow-set step files should exist under `steps/`.
- New decomposition-created workflow-set names use `-set`.
- New decomposition-created feature workflow names use `-feature`.
- `kind` remains the source of truth.
- Existing workflows are not renamed or migrated automatically.
- Aliases are out of scope for the first version.
- `01-workflow-set-plan.md` combines intent and decomposition plan.
- Plan materialization modes are:
  - write and mark complete;
  - write as draft and wait for review;
  - do not write files yet.
- Writing or completing the plan does not approve child scaffolding.
- Child scaffold is all-or-nothing in the first version.
- Parent scaffold states are `proposed`, `created`, and `conflict`.
- Scaffolded child Step 01 is always `pending`.
- Scaffolded child Step 01 includes `origin.type: "workflow-set-scaffold"`.
- Child Step 01 artifacts must be self-contained and resumable.
- Child Step 01 approval is blocked until every predecessor workflow has Step 06 verification complete.
- Workflow-set parent plans, scaffolds, and verifies coordination consistency.
- Workflow-set parent does not execute child workflows.
- Workflow-set parent must not persist child execution state.
- Child feature workflows own Step 01 approval, predecessor enforcement, implementation, and verification.
- `/sldd resume <name>` branches by `kind`.
- Workflow-set status may compute a read-only child overview but must not write child progress into the parent journal.
- `03-verify-workflow-set` has no dedicated artifact in the first version.
- Regenerating child Step 01 drafts requires explicit user approval.
- When overwrite risk is unclear, regeneration defaults to side-by-side output:
  - `01-product-intent-specification.regenerated.md`

# Success Metrics

- Existing feature workflows continue to resume unchanged.
- A journal without `kind` is treated as `feature`.
- A large multi-capability idea triggers a recommendation for workflow-set planning before normal Step 01.
- A user can reject decomposition and continue with normal single-feature SLDD behavior.
- A user can approve workflow-set planning and create a `kind: "workflow-set"` parent workflow.
- A workflow-set plan supports the three materialization modes.
- A complete workflow-set plan can scaffold all proposed children after explicit scaffold approval.
- Scaffolded child workflows are resumable from self-contained Step 01 drafts.
- Scaffolded child Step 01 remains `pending` until explicitly approved by the child workflow.
- Child predecessor gates block Step 01 approval until all predecessors have Step 06 verification complete.
- Workflow-set resume/status lists child workflows from journals without auto-selecting when multiple children are pending.
- Scaffold conflicts are recorded as `conflict` and stop execution instead of overwriting artifacts.
- Documentation and help text explain the feature and guardrails.

# Out of Scope

- OpenAPI-specific generation.
- Partial scaffold selection.
- Aliases.
- Parent orchestration of child execution.
- Persisted child progress or readiness in the parent journal.
- Advanced predecessor readiness policies.
- Dedicated workflow-set verification artifact.
- Automatic migration of old journals.
- Automatic renaming of existing workflows.
- Automatic child Step 01 approval.
- Automatic artifact overwrite.
- Reopening closed first-version decisions unless implementation reveals a concrete problem.

# Risks and Assumptions

Risks:

- Workflow-set support could overcomplicate SLDD if recommended too often.
- Parent workflows could accidentally become execution orchestrators.
- Child scaffolding could create too many files without clear approval checkpoints.
- Generated child Step 01 drafts could be mistaken for approved scope.
- Cross-worktree child execution could create synchronization problems if the parent stores child progress.
- Regeneration could overwrite user edits if not handled conservatively.

Assumptions:

- The first version should favor safety and explicit approval over convenience.
- Missing `kind` compatibility is required before workflow-set routing can be safely added.
- The workflow-set parent only owns decomposition and scaffold coordination.
- Child workflows remain normal feature workflows after scaffold.
- Predecessor readiness means predecessor Step 06 verification is complete.
- All-or-nothing scaffold is acceptable for the first version.
- Existing SLDD Red/Green Step 04 and Step 05 contracts remain unchanged.

# Acceptance Criteria (Given/When/Then)

- Given an existing SLDD workflow journal without `kind`, when it is resumed, then it behaves as `kind: "feature"`.
- Given an existing feature workflow, when status or resume routing runs, then existing behavior is preserved.
- Given a large multi-capability idea, when the agent evaluates it before Step 01, then it recommends workflow-set planning.
- Given an ambiguous idea, when decomposition may or may not help, then the agent asks one focused clarification question instead of forcing decomposition.
- Given the user rejects decomposition, when the workflow continues, then normal single-feature SLDD behavior continues.
- Given the user approves workflow-set planning, when a parent workflow is created, then the parent journal has `kind: "workflow-set"`.
- Given a workflow-set parent, when it is routed, then it uses `01-workflow-set-plan`, `02-scaffold-children`, and `03-verify-workflow-set`.
- Given a feature workflow, when it is routed, then it uses the existing feature steps: `01-product-intent`, `99-codebase-context`, `02-high-level-design`, `03-low-level-design`, `04-tests-red`, `05-implementation-green`, and `06-verification`.
- Given a workflow-set plan is presented, when the user chooses materialization, then the user can choose write complete, write draft, or do not write files.
- Given a workflow-set plan is written or marked complete, when scaffold has not been explicitly approved, then no child workflows are created.
- Given a workflow-set plan is complete and scaffold is explicitly approved, when `02-scaffold-children` runs, then all proposed child workflows in the approved plan are scaffolded.
- Given a child workflow is scaffolded, when its journal is created, then it has `kind: "feature"`.
- Given a child workflow is scaffolded, when its Step 01 journal entry is created, then Step 01 is `pending`.
- Given a child workflow is scaffolded, when its Step 01 journal entry is created, then it includes `origin.type: "workflow-set-scaffold"`.
- Given a child workflow is scaffolded, when its Step 01 artifact is created, then the artifact is self-contained and resumable without the original conversation.
- Given a child workflow has predecessors, when the child Step 01 is reviewed for approval, then approval is blocked until every predecessor workflow has Step 06 verification complete.
- Given a predecessor journal is missing, when the child Step 01 is reviewed for approval, then Step 01 remains pending.
- Given `/sldd resume <workflow-set>`, when parent steps are pending, then the next parent workflow-set step is resumed first.
- Given `/sldd resume <workflow-set>`, when parent steps are complete, then children are listed by reading child journals.
- Given multiple child workflows are pending, when workflow-set resume/status presents the child overview, then the agent does not auto-select a child.
- Given a scaffold name collision or unsafe existing directory, when scaffold preflight runs, then the agent records `conflict` and stops instead of overwriting.
- Given regeneration of a child Step 01 draft is requested, when overwrite risk is unclear, then the agent creates `01-product-intent-specification.regenerated.md` side-by-side unless the user explicitly approves replacement.
