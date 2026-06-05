# Requirements Traceability

| Requirement | High-Level Design Response |
|---|---|
| Existing journals without `name` or `kind` are invalid | Add required journal contract validation before routing/status logic. |
| Large ideas trigger decomposition recommendation | Add a large-idea heuristic before normal Step 01 and during exploration. |
| User can reject decomposition | Keep normal feature workflow as the fallback path. |
| Workflow-set parent can be created | Add `workflow-set` as a recognized workflow kind with compact parent steps. |
| Plan materialization modes | Add workflow-set planning behavior that can write complete, write draft, or avoid writing files. |
| Child scaffold requires explicit approval | Keep plan completion separate from `02-scaffold-children`. |
| Scaffolded children start with Step 01 pending | Scaffold child feature workflows with pending Step 01 and origin metadata. |
| Child predecessor gate | Enforce predecessor Step 06 completion inside child workflow approval behavior. |
| Workflow-set resume/status | Branch by `kind` and compute child overview read-only from child journals. |
| Scaffold conflicts stop instead of overwriting | Add scaffold preflight and conflict state recording. |

# Architecture Diagram

```text
User request / SLDD command
        |
        v
skills/sldd/SKILL.md
  - command routing
  - journal resolution
  - required `name` and `kind` validation
  - step map selection
        |
        +------------------------------+
        |                              |
        v                              v
Feature workflow                 Workflow-set workflow
  01 -> 99 -> 02 -> 03           01-workflow-set-plan
  -> 04 -> 05 -> 06              -> 02-scaffold-children
                                  -> 03-verify-workflow-set
                                        |
                                        v
                              Scaffolded child feature workflows
                              - Step 01 pending
                              - origin.type workflow-set-scaffold
                              - predecessor paths in child journal
```

# Component Responsibilities

`SKILL.md` responsibilities:

- Preserve command interpretation and global gate rules.
- Infer `kind: "feature"` when missing.
- Route `feature` and `workflow-set` workflows to the correct step sets.
- Document workflow decomposition guardrails and command/status behavior.

Feature step responsibilities:

- Preserve existing feature workflow behavior.
- Add only the behavior needed for large-idea recommendation and scaffolded child predecessor gates.
- Keep Step 04/05 Red-Green behavior unchanged.

Workflow-set step responsibilities:

- `01-workflow-set-plan`: create or revise the decomposition plan and enforce materialization approval modes.
- `02-scaffold-children`: validate the approved plan and create child feature workflow drafts.
- `03-verify-workflow-set`: verify coordination consistency without requiring child implementation completion.

Template responsibilities:

- `01-workflow-set-plan.md`: capture the large idea, children, scopes, predecessors, scaffold policy, and approval status.
- `01-product-intent-from-workflow-set.md`: create a self-contained child Step 01 draft.

Schema responsibilities:

- Add optional fields needed for `kind`, workflow-set children, relationships, and origin metadata.
- Preserve compatibility for existing strict feature journals.

README responsibilities:

- Explain workflow decomposition, workflow kinds, storage, commands, and guardrails for users.

# Data Flow

Recommendation flow:

1. User presents an idea or starts exploration.
2. Router or Step 88 applies large-idea heuristic.
3. If decomposition is useful, agent recommends workflow-set planning.
4. User explicitly approves or rejects decomposition.
5. Rejection continues normal feature workflow.

Workflow-set planning flow:

1. User approves workflow-set planning.
2. Agent creates or resumes a `kind: "workflow-set"` parent workflow.
3. Agent drafts `01-workflow-set-plan.md` from approved source inputs.
4. User chooses write complete, write draft, or do not write files.
5. Plan completion does not scaffold children unless scaffold is explicitly approved.

Scaffold flow:

1. `02-scaffold-children` validates the approved plan.
2. Preflight checks names, uniqueness, predecessor references, cycles, and target directory collisions.
3. If preflight passes, the scaffold operation creates child directories and artifacts.
4. Parent child scaffold state changes from `proposed` to `created` only after child files are complete.
5. On conflict, parent records `conflict` and stops without overwriting.

Child execution flow:

1. User resumes a child feature workflow explicitly.
2. Child Step 01 draft is reviewed.
3. Child workflow reads predecessor journal paths from its own journal.
4. Step 01 approval is blocked until every predecessor has Step 06 complete.
5. Once approved, child continues through normal feature gates.

# Security and Observability Requirements

- Do not create workflow-set or child workflow files without explicit approval.
- Do not overwrite existing workflow artifacts without explicit approval.
- Do not store child execution state in parent workflow-set journals.
- Do not store artifact bodies, logs, or implementation reports in `_spec-journal.json`.
- Use journal notes only for concise approval outcomes and coordination evidence.
- Status and resume views may compute child state by reading child journals, but must not persist that computed state in the parent.

# Trade-Offs and Alternatives

- Dedicated workflow-set step files are chosen over routing-only behavior because they preserve progressive disclosure and keep parent step behavior explicit.
- All-or-nothing scaffold is chosen over partial scaffold selection to reduce first-version complexity.
- Missing `kind` inference is chosen over automatic migration to avoid rewriting existing workflows.
- Parent read-only child overview is chosen over orchestration to avoid cross-worktree synchronization problems.
- No dedicated workflow-set verification artifact is chosen for the first version; journal state and conversational report are sufficient unless usage proves otherwise.
- Aliases are excluded because canonical names and paths are sufficient initially.

# High-Level Test Scenario Map

- Backward compatibility: missing `kind` resumes as `feature` and existing workflows are not rewritten or renamed.
- Recommendation: small ideas do not trigger decomposition; large ideas do; ambiguous ideas produce one clarification question.
- Planning: materialization modes produce the correct filesystem and journal effects.
- Scaffold success: all proposed children are created with pending Step 01 and origin metadata.
- Scaffold conflict: name collision records `conflict` and stops without overwrite.
- Predecessor gate: incomplete or missing predecessors block child Step 01 approval.
- Resume/status: workflow-set parent steps resume first; completed parent computes child overview without auto-selecting.
- Documentation: `/sldd help` and README describe workflow decomposition and guardrails.
