# Workflow Decomposition Refinement

Historical source input for the completed `add-workflow-decomposition-to-sldd-feature` SLDD workflow.

The current implemented behavior is documented in `skills/sldd/SKILL.md`, `skills/sldd/steps/`, `skills/sldd/templates/`, `skills/sldd/schema/_spec-journal.schema.json`, `README.md`, and `AGENTS.md`. This file preserves earlier discussion context and may contain superseded step names, commands, schema examples, or scaffold states.

## Purpose

This file records incremental refinements for the proposed SLDD workflow decomposition capability.

The goal is to preserve decisions and open questions while the idea is being discussed step by step.

## Current Proposal Context

SLDD may benefit from an optional workflow decomposition capability for large ideas.

Instead of forcing every large request into a single feature workflow, the agent can recommend creating a `workflow-set`: a normal SLDD workflow with `kind: "workflow-set"`, its own `_spec-journal.json`, and relationships to child workflows.

Child workflows remain independent workflows with their own journals and gates.

## Refinement 1: Decomposition Can Start From Structured Input Or Exploration

Workflow decomposition should not be limited to structured user input such as OpenAPI files, roadmaps, epics, or predefined requirement documents.

It should also be possible for decomposition to emerge from an exploration process.

Two valid origins exist:

- **Structured input:** The user provides a large existing artifact, such as an OpenAPI specification, product epic, migration plan, or requirements document. The agent can inspect or summarize the artifact and detect whether it should become a workflow set.
- **Exploration:** The user starts with a rough idea. During Step 88 exploration, the conversation reveals multiple capabilities, dependencies, risks, and parallelizable workstreams. The agent may then recommend transitioning into workflow-set planning.

## Agreed Rule

Exploration may recommend workflow decomposition, but it must not silently create decomposition artifacts.

The transition must be explicit:

```text
Step 88 Exploration
  -> user approval
  -> Step 89 Workflow Set Planning
```

The agent should say something like:

```text
The exploration has revealed multiple capabilities with clear dependencies.

I recommend pausing open exploration and starting workflow-set planning so we can decompose this into coordinated SLDD workflows.

Do you want to continue with decomposition?
```

## Rationale

This keeps exploration lightweight while still allowing the agent to prevent oversized Step 01 artifacts.

It also preserves user control:

- The agent can detect and recommend decomposition.
- The user decides whether to transition.
- No workflow-set journal, backlog, child workflow, or Step 01 draft is created without approval.

## Example Exploration Summary Before Transition

Before moving from exploration to workflow-set planning, Step 88 may produce a short summary to use as input for Step 89.

Example:

```markdown
## Exploration Summary

Emerging idea:
- Build a publishing platform similar to Medium.

Detected capabilities:
- Identity and authentication
- Profile management
- Article publishing
- Comments
- Favorites
- Personalized feed
- Tags

Reason decomposition is recommended:
- Multiple independent capabilities
- Clear dependencies between capabilities
- Some workflows can run in parallel
- A single Step 01 would mix unrelated acceptance criteria
```

## Open Questions

- Should `Step 89: Workflow Set Planning` be a formal SLDD step, or a mode inside exploration?
- Should the exploration summary be optional or required before Step 89?
- Should workflow-set planning have its own templates and schema extensions?
- How should approval work: approve only the decomposition plan first, or also approve scaffolding child workflows in the same interaction?

## Refinement 2: Explicit Transition Into Workflow-Set Planning

Once the agent recommends decomposition, the next step is not to create child workflows immediately.

The next step is to ask the user to approve a transition from the current mode into workflow-set planning.

Valid transition sources:

- From structured input analysis, such as an OpenAPI document or roadmap.
- From Step 88 exploration, after the emerging idea becomes large enough to warrant decomposition.
- From a direct user command such as `/sldd decompose <idea>` or `/sldd plan workflow-set <idea>`.

The transition should create or resume a parent workflow only after approval.

Example parent workflow:

```text
.sldd/specs/<workflow-set-name>/
  _spec-journal.json
  01-workflow-set-intent.md
```

At this point, the workflow-set exists as a normal SLDD workflow with:

```json
{
  "kind": "workflow-set",
  "status": "in_progress"
}
```

No child workflows are created yet.

## Transition Contract

The approved transition should capture:

- The source idea or input being decomposed.
- Why decomposition was recommended.
- The intended workflow-set name.
- Whether the workflow-set is being newly created or resumed.
- The fact that child workflow scaffolding is not yet approved.

Example agent prompt:

```text
I will start a workflow-set planning workflow named `realworld-api`.

This will create only the parent workflow-set journal and intent draft.
It will not create child workflows yet.

Continue?
```

## Rationale

This separates three decisions that should not be conflated:

- Whether the idea should be decomposed.
- Whether to create a parent workflow-set.
- Whether to scaffold child workflows.

Keeping these decisions separate prevents the agent from turning an exploratory conversation into many files without explicit user control.

## Refinement 3: Combine Workflow-Set Intent And Initial Plan

The previous idea separated workflow-set intent from the decomposition plan. This was judged too heavy.

Simplified rule:

> After the user approves the transition into workflow-set planning, create one parent planning artifact that combines intent, decomposition rationale, proposed child workflows, dependencies, and scaffolding approval status.

This artifact still does not create child workflows automatically.

Suggested artifact:

```text
.sldd/specs/<workflow-set-name>/01-workflow-set-plan.md
```

Suggested parent structure:

```text
.sldd/specs/<workflow-set-name>/
  _spec-journal.json
  01-workflow-set-plan.md
```

Suggested journal state:

```json
{
  "kind": "workflow-set",
  "steps": {
    "01-workflow-set-plan": {
      "status": "pending",
      "artifact": "01-workflow-set-plan.md"
    },
    "02-scaffold-children": {
      "status": "pending"
    },
    "03-verify-set": {
      "status": "pending"
    }
  }
}
```

The combined plan should answer:

- What large idea is being decomposed?
- Why is a workflow-set justified instead of a single feature workflow?
- What source inputs or exploration summary are being used?
- What child workflows are proposed?
- What is the scope of each child workflow?
- What are the required predecessors?
- Which workflows can run in parallel?
- What is the recommended execution order?
- What is explicitly out of scope?
- Whether child workflow scaffolding is approved or still pending.

## Why Combine Intent And Plan

The combined artifact keeps the workflow-set lightweight while preserving the important gate:

- The agent may propose decomposition.
- The user must approve the plan.
- Child workflows are not created until the approved plan explicitly allows scaffolding.

This avoids an unnecessary two-step parent flow while still preventing automatic file generation.

## Example Workflow-Set Plan Outline

```markdown
# Workflow-Set Plan: RealWorld API

## Workflow Kind

`workflow-set`

## Large Idea

Implement the RealWorld API behavior described by the official OpenAPI specification.

## Source Inputs

- Official RealWorld OpenAPI specification.
- Repository scaffold and SLDD workspace rules.

## Why Decomposition Is Recommended

- The idea includes multiple business capabilities.
- There are clear dependencies between capabilities.
- Some workstreams can run in parallel after foundational workflows are complete.
- A single feature workflow would produce an oversized Step 01 and mix unrelated acceptance criteria.

## Proposed Child Workflows

| Workflow | Scope | Predecessors | Parallel-Safe With |
|---|---|---|---|
| `user-registration-and-login` | Register and log in users | none | none in phase 1 |
| `current-user-management` | Get and update current user | `user-registration-and-login` | `profiles-and-following`, `article-authoring` |
| `profiles-and-following` | Profiles and follow/unfollow | `user-registration-and-login` | `current-user-management`, `article-authoring` |
| `article-authoring` | Create, get, update, delete articles | `user-registration-and-login` | `current-user-management`, `profiles-and-following` |

## Recommended Execution Order

1. `user-registration-and-login`
2. `current-user-management`, `profiles-and-following`, and `article-authoring` in parallel after the first workflow is complete

## Out Of Scope

- Implementing production API behavior.
- Creating child workflows before approval.
- Marking child Step 01 artifacts complete automatically.

## Scaffolding Approval

Pending explicit approval.
```

## Refinement 4: Approve, Revise, Or Stop Before Scaffolding

After `01-workflow-set-plan.md` is created, the agent must stop and ask the user what to do with the proposed decomposition.

The plan is a proposal, not authorization to create child workflows.

The user should have explicit choices:

1. Approve the plan and scaffold child workflows as drafts.
2. Revise the plan before scaffolding.
3. Keep the plan only and do not scaffold children yet.
4. Cancel workflow-set planning.

The agent should not infer approval from silence or from having created the plan.

## Approval Effects

If the user approves scaffolding:

- Mark `01-workflow-set-plan` as `complete` in the workflow-set journal.
- Record explicit approval in the workflow-set journal.
- Proceed to `02-scaffold-children`.
- Create only the approved child workflows.
- Initialize child workflow Step 01 as `pending`, not `complete`.

If the user asks for revision:

- Keep `01-workflow-set-plan` as `pending` or mark it `requires_rerun`, depending on whether the plan was previously complete.
- Update the plan.
- Ask again for approval.

If the user keeps the plan only:

- Keep the workflow-set resumable.
- Do not create child workflows.
- Record that scaffolding was deferred by user choice.

If the user cancels:

- Mark the workflow-set as cancelled if the journal supports it.
- Do not create child workflows.

## Example Approval Prompt

```text
The workflow-set plan has been drafted.

Choose the next action:

1. Approve the plan and scaffold child workflows as drafts.
2. Revise the plan before scaffolding.
3. Keep the plan only; do not scaffold yet.
4. Cancel this workflow-set.
```

## Rationale

This step keeps decomposition safe.

The agent may propose structure, precedence, and parallelization. The user remains responsible for approving whether those proposed child workflows should actually exist in the repository.

## Refinement 5: Child Workflow Draft Representation

When the user approves scaffolding child workflows, each child workflow should be created at the beginning of the normal SLDD flow.

The standard child workflow still starts at Step 01.

The scaffolded child contains a pre-filled Step 01 artifact, but Step 01 remains `pending` until explicitly approved.

Recommended child structure:

```text
.sldd/specs/<child-workflow>/
  _spec-journal.json
  01-product-intent-specification.md
```

Recommended journal representation:

```json
{
  "kind": "feature",
  "name": "user-registration-and-login",
  "steps": {
    "01-product-intent": {
      "status": "pending",
      "artifact": "01-product-intent-specification.md",
      "origin": {
        "type": "workflow-set-scaffold",
        "journal": "../realworld-api/_spec-journal.json",
        "artifact": "../realworld-api/01-workflow-set-plan.md"
      }
    }
  }
}
```

The `origin` metadata is the preferred representation.

It records that the draft Step 01 was produced by a workflow-set scaffold operation without introducing a new step status.

## Meaning Of Draft

`draft` does not need to be a separate step status.

The effective meaning is:

```text
Step 01 is pending, but its artifact already exists and was pre-filled from a workflow-set plan.
```

When the child workflow is resumed, the agent should detect this state and offer actions such as:

1. Approve the drafted Step 01 as-is.
2. Revise the drafted Step 01.
3. Regenerate the drafted Step 01 from the parent workflow-set plan.
4. Defer or discard the child workflow.

## Step 01 Draft Must Be Self-Contained

The generated `01-product-intent-specification.md` should contain enough context for the child workflow to be resumed later without relying on the original conversation.

It should include:

- Workflow kind.
- Parent workflow-set name.
- Origin journal and artifact paths.
- Included scope.
- Excluded scope.
- Required predecessors.
- Successors or dependents when known.
- Parallel-safe workflows when known.
- Product intent.
- Draft acceptance criteria.
- Explicit approval status.

Example excerpt:

```markdown
# Product Intent: User Registration And Login

## Workflow Kind

`feature`

## Parent Workflow

`realworld-api`

## Origin

This Step 01 draft was scaffolded from the workflow-set plan:

- Parent journal: `../realworld-api/_spec-journal.json`
- Parent artifact: `../realworld-api/01-workflow-set-plan.md`

## Scope

Included:

- `POST /users`
- `POST /users/login`

Excluded:

- `GET /user`
- `PUT /user`
- Profiles
- Articles
- Comments
- Favorites
- Tags

## Workflow Precedence

Required predecessors:

- None

Successors:

- `current-user-management`
- `profiles-and-following`
- `article-authoring`

Parallel-safe with:

- None in phase 1

## Product Intent

Users need to register and authenticate so they can access protected RealWorld API operations.

## Acceptance Criteria Draft

- Given a valid username, email, and password, when `POST /users` is called, then the API returns `201` with a RealWorld `user` response.
- Given valid credentials, when `POST /users/login` is called, then the API returns `200` with a RealWorld `user` response and token.
- Given invalid credentials, when `POST /users/login` is called, then the API returns `401`.
- Given invalid request bodies, then the API returns `422` using the RealWorld error format.

## Approval Status

Pending explicit Step 01 approval.
```

This preserves the existing SLDD gate model while making scaffolded child workflows resumable.

## Refinement 6: Scaffold Children Execution Rules

After the workflow-set plan is approved, the agent may execute `02-scaffold-children`.

This step creates the approved child workflows as normal SLDD workflows with pre-filled, pending Step 01 artifacts.

## Scaffold Inputs

`02-scaffold-children` must use only the approved workflow-set plan as its source of truth.

It should not invent additional child workflows during scaffolding.

If the agent discovers that the plan is insufficient or inconsistent, it should stop and route back to revising `01-workflow-set-plan.md`.

## Scaffold Outputs

For each approved child workflow, create:

```text
.sldd/specs/<child-workflow>/
  _spec-journal.json
  01-product-intent-specification.md
```

The child journal must initialize Step 01 as `pending` with `origin.type: "workflow-set-scaffold"`.

The child Step 01 artifact must be self-contained enough to resume later.

## Idempotency Rules

Scaffolding should be safe to re-run.

If a child workflow directory does not exist:

- Create it.
- Create `_spec-journal.json`.
- Create `01-product-intent-specification.md`.
- Record the child as `scaffolded` in the workflow-set journal.

If a child workflow directory already exists and was created by the same workflow-set:

- Do not overwrite approved artifacts.
- If Step 01 is still `pending` and the artifact is unchanged or safely replaceable, the agent may offer to refresh it from the parent plan.
- If Step 01 is `complete`, do not modify it. Record that the child already exists and is approved or in progress.

If a child workflow directory already exists but was not created by the same workflow-set:

- Stop and ask the user how to proceed.
- Do not overwrite or merge automatically.

## Conflict Rules

The agent must stop before modifying child workflows when:

- A target child directory exists without matching `origin` metadata.
- The child Step 01 artifact was edited after scaffolding.
- The child workflow has advanced beyond Step 01.
- The workflow-set plan changed in a way that conflicts with already scaffolded children.

Possible user choices:

1. Keep the existing child workflow unchanged.
2. Create a new child workflow with a different name.
3. Update only pending scaffolded drafts.
4. Manually reconcile the workflow-set plan first.

## Workflow-Set Journal Updates

After scaffolding, update the parent workflow-set journal with:

- Each child workflow name.
- Child journal path.
- Child scaffold status.
- Child Step 01 status.
- Source artifact used for scaffolding.
- Timestamp or evidence note if supported.

Example parent child entry:

```json
{
  "name": "user-registration-and-login",
  "status": "scaffolded",
  "journal": "../user-registration-and-login/_spec-journal.json",
  "step01Status": "pending",
  "originArtifact": "01-workflow-set-plan.md"
}
```

## Completion Criteria

`02-scaffold-children` can be marked complete only when:

- All approved child workflows were created or accounted for.
- No unresolved conflicts remain.
- The workflow-set journal references the child workflows.
- Each newly scaffolded child is initialized with Step 01 `pending`, not `complete`.

This preserves safe reexecution and makes the workflow-set resumable after scaffolding.

## Refinement 7: Workflow-Set Is Not A Child Execution Orchestrator

The workflow-set should not track or control the internal execution progress of child workflows.

Earlier examples included fields such as `step01Status` in the parent workflow-set journal. This was rejected because it duplicates child workflow state and creates synchronization problems when child workflows run independently or in parallel worktrees.

Decision:

> The workflow-set plans and scaffolds child workflows. It does not orchestrate their execution.

The child workflow journal remains the source of truth for child step status.

The parent workflow-set journal remains the source of truth for decomposition and scaffolding coordination.

## Parent Should Track Stable Coordination State Only

The parent may track stable coordination information such as:

- The child was proposed in the plan.
- The child was scaffolded.
- The child was deferred.
- The child was rejected.
- The child encountered a scaffold conflict.
- The child journal path, if scaffolded.
- The parent plan artifact used as origin.
- The child's predecessors and phase from the approved plan.

The parent should not persist execution-derived fields such as:

- `step01Status`
- `currentStep`
- `approved`
- `in_progress`
- `complete`
- `lastExecutedStep`

Those belong to the child workflow journal.

## Recommended Parent Child Entry

Use a scaffold/coordination state instead of execution status:

```json
{
  "name": "article-authoring",
  "relationship": "child",
  "scaffold": {
    "state": "created",
    "journal": "../article-authoring/_spec-journal.json",
    "originArtifact": "01-workflow-set-plan.md"
  },
  "phase": 2,
  "predecessors": [
    "user-registration-and-login"
  ]
}
```

## Effective Status Is Computed On Demand

When the agent needs a status view for a workflow-set, it should compute it dynamically:

1. Read the workflow-set journal.
2. Read referenced child workflow journals.
3. Derive each child's current step and readiness.
4. Report the aggregate status as a view, not persisted parent state.

Example:

```text
/sldd status realworld-api
```

The agent may report:

```text
Next unblocked child workflows:
- current-user-management
- profiles-and-following
- article-authoring
```

But it should not need to update the parent journal just because a child advanced from Step 01 to Step 02.

## Rationale

If the parent tracked child execution status, the workflow-set would become an orchestrator. That would significantly change the current SLDD model by requiring synchronization, locks, cross-worktree updates, and conflict handling for parallel child execution.

Keeping the workflow-set as a planner/scaffolder preserves the current model:

```text
Workflow-set: plan and scaffold.
Child workflow: execute independently.
Aggregate status: compute on demand.
```

## Refinement 8: Simplify Coordination States

The workflow-set child coordination states should be simpler than originally proposed.

The useful scaffold states are:

```text
proposed -> created | conflict
```

This avoids turning the workflow-set into a lifecycle manager for child workflows.

## State Meanings

`proposed` means:

```text
The child workflow is listed in the approved or draft workflow-set plan, but no child workflow files have been created yet.
```

`created` means:

```text
The child workflow has been scaffolded in the filesystem and has its own `_spec-journal.json` and pending `01-product-intent-specification.md`.
```

`conflict` means:

```text
The agent attempted to create or reconcile the child workflow but found a condition requiring user decision.
```

Examples of conflict conditions:

- The target child workflow directory already exists.
- The existing journal has no matching workflow-set origin.
- The existing Step 01 artifact was edited after scaffolding.
- The proposed child name collides with another workflow.
- The workflow-set plan changed in a way that conflicts with an existing child workflow.

## Removed States

The following states are no longer recommended as scaffold states:

- `approved-for-scaffold`
- `deferred`
- `rejected`

Rationale:

- Approval belongs to the workflow-set step transition, not to each child state.
- Deferred children can remain in the plan as proposed but not selected for scaffold, or be removed from the scaffold batch.
- Rejected children should be removed from the active plan or recorded as a decision, not tracked as scaffold state.

If historical trace is needed, use `decisions` or notes in `01-workflow-set-plan.md`, not extra lifecycle states.

## Simplified Parent Child Entry

Before scaffolding:

```json
{
  "name": "article-authoring",
  "relationship": "child",
  "scaffold": {
    "state": "proposed"
  },
  "phase": 2,
  "predecessors": [
    "user-registration-and-login"
  ]
}
```

After successful scaffolding:

```json
{
  "name": "article-authoring",
  "relationship": "child",
  "scaffold": {
    "state": "created",
    "journal": "../article-authoring/_spec-journal.json",
    "originArtifact": "01-workflow-set-plan.md"
  },
  "phase": 2,
  "predecessors": [
    "user-registration-and-login"
  ]
}
```

On conflict:

```json
{
  "name": "article-authoring",
  "relationship": "child",
  "scaffold": {
    "state": "conflict",
    "reason": "Directory already exists without matching workflow-set origin.",
    "existingJournal": "../article-authoring/_spec-journal.json"
  },
  "phase": 2,
  "predecessors": [
    "user-registration-and-login"
  ]
}
```

## Simplified Lifecycle

```text
proposed
  -> created
  -> conflict

conflict
  -> created
  -> proposed, if the plan is revised and scaffold is retried later
```

The scaffold state answers only:

```text
Has this proposed child workflow been materialized successfully?
```

It does not answer whether the child workflow is approved, in progress, complete, deferred, or rejected.

## Refinement 9: Resuming A Workflow-Set Computes A Dynamic View

When a user resumes a workflow-set, the agent should not treat the parent journal as an execution dashboard.

Instead, it should compute a fresh status view from the parent and child journals.

The parent workflow-set journal provides:

- The proposed child list.
- Scaffold state: `proposed`, `created`, or `conflict`.
- Child journal paths for created children.
- Predecessor relationships.
- Phase/order guidance.

Each child workflow journal provides:

- The child's actual step statuses.
- Whether Step 01 is pending or complete.
- Whether later SLDD gates are pending, complete, or require rerun.

## Resume Algorithm

When running something like:

```text
/sldd resume realworld-api
```

or:

```text
/sldd status realworld-api
```

the agent should:

1. Read the workflow-set journal.
2. Read the workflow-set plan artifact.
3. For each child with `scaffold.state: "created"`, read the child journal.
4. For each child with `scaffold.state: "proposed"`, report it as not yet scaffolded.
5. For each child with `scaffold.state: "conflict"`, report the conflict and required decision.
6. Compute predecessor readiness from child journals, not from cached parent state.
7. Present a derived view to the user.

## Derived View Example

Example response:

```text
Workflow-set: realworld-api

Scaffold state:
- user-registration-and-login: created
- current-user-management: created
- article-authoring: proposed
- profiles-and-following: conflict

Child execution state, computed from child journals:
- user-registration-and-login: Step 01 complete; next step is Step 99
- current-user-management: Step 01 pending draft; needs approval
- article-authoring: not scaffolded yet
- profiles-and-following: blocked by scaffold conflict

Next safe actions:
1. Resume user-registration-and-login at Step 99.
2. Review and approve current-user-management Step 01 draft.
3. Resolve profiles-and-following scaffold conflict.
4. Scaffold article-authoring if still desired.
```

## No Parent Mutation For Child Progress

The agent should not update the parent workflow-set journal just because a child advanced from one SLDD step to another.

Parent mutation is appropriate only when coordination/scaffold information changes, such as:

- A proposed child is created.
- A scaffold conflict is recorded or resolved.
- The workflow-set plan is revised.
- A child is added to or removed from the plan.
- A child journal path changes.

This keeps parallel child execution safe and avoids cross-worktree synchronization requirements.

## Refinement 10: Revising A Workflow-Set Plan After Scaffolding

A workflow-set plan may need to change after some child workflows have already been scaffolded.

The agent must treat scaffolded children as independent workflows and avoid rewriting them automatically.

## Revision Scenarios

Common reasons to revise the workflow-set plan:

- Add a missing child workflow.
- Rename a proposed child workflow.
- Split one proposed child into multiple children.
- Merge proposed children before they are created.
- Change predecessor relationships.
- Change recommended execution phases.
- Remove a proposed child from the active plan.
- Clarify scope boundaries after reviewing a child Step 01 draft.

## Safe Revision Rules

If the changed child is still `proposed`:

- The workflow-set plan can be updated directly.
- No child files need to be modified because none exist yet.

If the changed child is already `created`:

- Do not overwrite the child journal.
- Do not overwrite the child Step 01 artifact.
- Record the plan change in the workflow-set plan.
- Report that the created child may need manual review or its own SLDD rerun.

If the created child's Step 01 is still pending and originated from this workflow-set:

- The agent may offer to refresh the draft from the revised parent plan.
- Refresh requires explicit user approval.

If the created child has Step 01 complete or has advanced beyond Step 01:

- Do not refresh automatically.
- Treat changes as downstream-impacting.
- Recommend resuming the child workflow and deciding whether its completed steps require rerun.

## Removed Or Rejected Children

Because scaffold states are intentionally simple, removing or rejecting a child should be represented in the plan or decisions, not as a scaffold state.

If a child is still `proposed`:

- It may be removed from the active plan.
- Optionally record a decision explaining why.

If a child is already `created`:

- Do not delete it automatically.
- Record that the parent plan no longer recommends it.
- Ask the user whether to keep it independent, archive it later, or handle it manually.

## Plan Revision Journal Handling

When the workflow-set plan changes after approval:

- Mark `01-workflow-set-plan` as `requires_rerun` or create a new revision note, depending on the existing SLDD journal policy.
- After the revised plan is approved, mark it complete again.
- Do not automatically mark child workflow steps as `requires_rerun` from the parent.

The parent can warn about possible downstream impact, but child workflow invalidation should happen inside each child workflow's own SLDD gate logic.

## Rationale

This preserves the independence of child workflows.

The workflow-set can evolve as a coordination artifact, but it must not silently rewrite or invalidate child workflows that may be running in parallel worktrees.

## Refinement 11: Child Workflows Enforce Predecessor Readiness

Workflow-set predecessor relationships should be copied into each child workflow as part of its own resumable context.

The parent plan may define predecessor relationships such as:

```json
{
  "name": "article-authoring",
  "predecessors": [
    "user-registration-and-login"
  ]
}
```

The workflow-set uses this relationship only for planning and scaffolding.

The child workflow owns enforcement.

Decision:

> A child workflow must verify its required predecessors before approving its own Step 01.

This keeps the parent from tracking child execution state while still preventing out-of-order workflow approval.

## Child Step 01 Predecessor Gate

When resuming a child workflow whose Step 01 is `pending`, the agent should inspect the child's declared predecessors before approving Step 01.

Default rule:

```text
A predecessor is ready only when the predecessor workflow Step 06 verification is complete.
```

If a required predecessor is not complete:

- The child Step 01 may be inspected.
- The child Step 01 draft may be revised.
- The child Step 01 must not be marked complete.
- The agent should report which predecessor blocks approval.

This means a child can exist as a scaffolded draft before its predecessors are done, but it cannot become approved scope until its predecessors are complete.

## Child Journal Predecessor Metadata

The child workflow should include predecessor information in its own journal and Step 01 artifact.

Example child journal excerpt:

```json
{
  "kind": "feature",
  "name": "article-authoring",
  "relationships": {
    "parents": [
      "../realworld-api/_spec-journal.json"
    ],
    "predecessors": [
      "../user-registration-and-login/_spec-journal.json"
    ]
  },
  "steps": {
    "01-product-intent": {
      "status": "pending",
      "artifact": "01-product-intent-specification.md",
      "origin": {
        "type": "workflow-set-scaffold",
        "journal": "../realworld-api/_spec-journal.json",
        "artifact": "../realworld-api/01-workflow-set-plan.md"
      }
    }
  }
}
```

Example Step 01 section:

```markdown
## Workflow Precedence

Required predecessors:

- `user-registration-and-login`

Approval gate:

- This Step 01 must not be marked complete until `user-registration-and-login` has completed Step 06 verification.
```

## Parent Status View

The workflow-set parent may still list predecessor relationships from the approved plan, but it should not persist readiness, blocked, in-progress, or done states for children.

If the user asks for workflow-set status, the agent may compute a temporary report by reading child journals. That report is informational only and should not be written back to the parent as child execution state.

Example informational view:

```text
Workflow-set: realworld-api

Child approval gates:
- article-authoring: Step 01 approval blocked until user-registration-and-login Step 06 is complete
- comments: Step 01 approval blocked until article-authoring Step 06 is complete
```

## Rationale

This keeps dependency enforcement local to the workflow that needs the dependency.

The workflow-set does not own child progress. It only provides the decomposition plan and predecessor relationships used to scaffold child workflows.

## Refinement 12: Resume Behavior For Workflow-Sets

The command `/sldd resume <name>` can support both normal feature workflows and workflow-set workflows.

The agent should first inspect the target journal and branch behavior by `kind`:

```text
kind: feature       -> resume the normal SLDD feature workflow
kind: workflow-set  -> resume the workflow-set coordination workflow
```

## Workflow-Set Resume Rule

When `/sldd resume <workflow-set>` is called:

1. If the workflow-set itself has pending or incomplete parent steps, resume the next parent workflow-set step.
2. If the workflow-set parent steps are complete, list child workflows and compute their current state by reading each child journal.
3. If multiple child workflows are pending or available, do not auto-select one.
4. Show the computed child overview and ask the user to explicitly resume the child workflow they want.

Example:

```text
/sldd resume realworld-api
```

If `realworld-api` still has parent work to do:

```text
Workflow-set `realworld-api` has pending parent step `02-scaffold-children`.
Resume that step?
```

If the parent workflow-set is complete:

```text
Workflow-set `realworld-api` has no pending parent steps.

Child workflows:
- user-registration-and-login: Step 06 complete
- current-user-management: Step 01 pending
- profiles-and-following: Step 01 pending
- article-authoring: Step 01 pending

Multiple child workflows are pending.
Run `/sldd resume <child-workflow>` for the workflow you want to continue.
```

## Why This Is Acceptable

This provides a simple global view without making the workflow-set an orchestrator.

The workflow-set does not persist child execution state and does not choose a child automatically when there is ambiguity.

It only computes a temporary view from child journals and returns control to the user.

## Single Available Child Case

If exactly one child workflow is unambiguously pending and unblocked, the agent may offer to resume it, but should still ask for confirmation before switching context.

Example:

```text
Only one child workflow appears ready to continue: `current-user-management`.

Resume it now?
```

This preserves explicit user control while making the common case convenient.

## Refinement 13: Resuming A Scaffolded Child Workflow

When a scaffolded child workflow is resumed, it behaves like a normal feature workflow starting at Step 01.

The difference is that Step 01 may already have a pre-filled artifact created from the workflow-set plan.

The agent should detect this state:

```json
{
  "status": "pending",
  "artifact": "01-product-intent-specification.md",
  "origin": {
    "type": "workflow-set-scaffold"
  }
}
```

## Child Resume Behavior

When resuming a child with a pending scaffolded Step 01, the agent should:

1. Read the child journal.
2. Read the child Step 01 artifact.
3. Read declared predecessor journals, if any.
4. Verify whether each predecessor has completed Step 06.
5. Present the Step 01 draft and predecessor gate result.
6. Ask the user what to do next.

## Allowed Actions

If all required predecessors are complete, offer:

1. Approve Step 01 as-is.
2. Revise Step 01 before approval.
3. Regenerate Step 01 from the parent workflow-set plan.
4. Leave Step 01 pending.

If required predecessors are not complete, offer:

1. Review or revise the Step 01 draft, keeping it pending.
2. Regenerate Step 01 from the parent workflow-set plan, keeping it pending.
3. Leave Step 01 pending.

Do not offer to approve Step 01 while required predecessors are incomplete.

## Example Blocked Resume

```text
Workflow: article-authoring
Kind: feature
Origin: workflow-set scaffold from `realworld-api`

Step 01 draft exists and is pending.

Predecessor gate:
- user-registration-and-login: not complete; Step 06 verification is pending

Step 01 cannot be approved yet.

Available actions:
1. Review or revise the Step 01 draft, keeping it pending.
2. Regenerate Step 01 from the parent workflow-set plan.
3. Leave this workflow pending.
```

## Example Unblocked Resume

```text
Workflow: article-authoring
Kind: feature
Origin: workflow-set scaffold from `realworld-api`

Step 01 draft exists and is pending.

Predecessor gate:
- user-registration-and-login: complete; Step 06 verification complete

Available actions:
1. Approve Step 01 as-is.
2. Revise Step 01 before approval.
3. Regenerate Step 01 from the parent workflow-set plan.
4. Leave this workflow pending.
```

## After Step 01 Approval

Once Step 01 is approved, the child continues through the normal SLDD flow:

```text
Step 99 -> Step 02 -> Step 03 -> Step 04 -> Step 05 -> Step 06
```

The workflow-set parent is not updated just because the child Step 01 was approved.

If a user later resumes the workflow-set, the agent computes the child's state by reading the child journal.

## Refinement 14: Regenerating A Scaffolded Child Step 01 Draft

A scaffolded child Step 01 draft may need to be regenerated from the parent workflow-set plan.

This can happen when:

- The parent workflow-set plan was revised.
- The child draft is incomplete.
- The user wants to discard local edits and return to the parent plan.
- The child was scaffolded before the decomposition rules were clarified.

## Regeneration Preconditions

Regeneration is allowed only when:

- The child Step 01 status is `pending`.
- The child Step 01 has `origin.type: "workflow-set-scaffold"`.
- The parent workflow-set journal and plan artifact still exist.
- The user explicitly approves regeneration.

Regeneration must not happen automatically during resume.

## When Regeneration Is Not Allowed

Do not regenerate automatically if:

- Child Step 01 is `complete`.
- The child has advanced beyond Step 01.
- The child no longer has matching workflow-set origin metadata.
- The parent plan artifact is missing.
- The existing draft has user edits and the user has not approved overwrite.

In those cases, the agent should recommend manual review or a normal SLDD rerun inside the child workflow.

## Safe Regeneration Behavior

Before overwriting `01-product-intent-specification.md`, the agent should detect whether the file appears modified since scaffold.

If modification tracking is available, use it.

If not available, be conservative and ask for confirmation before overwrite.

Recommended options:

1. Replace the draft with a regenerated version from the parent plan.
2. Keep the current draft unchanged.
3. Create a side-by-side regenerated draft for comparison.

Side-by-side example:

```text
01-product-intent-specification.regenerated.md
```

## Journal Updates

If the draft is regenerated in place:

- Keep Step 01 as `pending`.
- Keep the original `origin` metadata.
- Add a note that the draft was regenerated from the parent workflow-set plan.

Example:

```json
{
  "steps": {
    "01-product-intent": {
      "status": "pending",
      "artifact": "01-product-intent-specification.md",
      "origin": {
        "type": "workflow-set-scaffold",
        "journal": "../realworld-api/_spec-journal.json",
        "artifact": "../realworld-api/01-workflow-set-plan.md"
      },
      "notes": [
        "Draft regenerated from parent workflow-set plan by explicit user approval."
      ]
    }
  }
}
```

If a side-by-side draft is created:

- Do not change the active artifact pointer unless the user chooses to replace it.
- Record the comparison artifact as an auxiliary artifact if the journal supports it.

## Rationale

Regeneration is useful, but it is also a write operation against a child workflow.

Keeping it explicit prevents the workflow-set from silently overwriting child-specific refinements.

## Refinement 15: Workflow-Set Verification And Completion

A workflow-set can be completed even though its child workflows are not implemented or verified.

The workflow-set's completion means:

```text
The decomposition plan was approved, and approved child workflows were scaffolded or accounted for.
```

It does not mean:

```text
All child workflows are complete.
The product idea is fully implemented.
All child Step 01 artifacts are approved.
```

## Workflow-Set Verification Scope

The workflow-set verification step should check coordination artifacts only:

- `_spec-journal.json` exists and has `kind: "workflow-set"`.
- `01-workflow-set-plan.md` exists and reflects the approved decomposition.
- Each child listed for scaffold has either `scaffold.state: "created"` or `scaffold.state: "conflict"` with a recorded reason.
- Each created child journal exists.
- Each created child journal has `kind: "feature"` or another expected child kind.
- Each created child has Step 01 `pending`, not `complete`, unless it was later approved independently through the child workflow.
- Each created child Step 01 has `origin.type: "workflow-set-scaffold"`.
- Each created child Step 01 artifact is self-contained enough to resume.
- Predecessor relationships from the plan were copied into child journals and Step 01 artifacts.

## Workflow-Set Completion Criteria

The workflow-set can be marked complete when:

- The plan is approved.
- The approved scaffold operation has run.
- Created children are linked from the parent.
- Conflicts, if any, are recorded and explicitly accepted as unresolved or deferred.
- No unexpected partial scaffold state remains.

Completion should not require child workflows to pass Step 06.

## Suggested Parent Steps After Simplification

The workflow-set parent can have a compact flow:

```text
01-workflow-set-plan
02-scaffold-children
03-verify-workflow-set
```

Where:

- `01-workflow-set-plan` defines and approves the decomposition.
- `02-scaffold-children` creates approved child workflow drafts.
- `03-verify-workflow-set` verifies coordination consistency.

## Rationale

This keeps the workflow-set's lifecycle bounded.

The parent workflow-set is done when it has safely prepared the coordinated child workflows. Execution and verification of product behavior remain responsibilities of child workflows.

## Refinement 16: Journal Compatibility And Schema Evolution

Workflow decomposition should evolve the SLDD journal model without breaking existing feature workflows.

Existing journals may not have a `kind` field.

Default compatibility rule:

```text
If `_spec-journal.json` has no `kind`, treat it as `kind: "feature"`.
```

This preserves current behavior for existing SLDD workflows.

## Common Journal Fields

All workflow kinds should support a small common shape:

```json
{
  "schemaVersion": "1.0",
  "kind": "feature",
  "name": "example-workflow",
  "status": "in_progress",
  "steps": {},
  "relationships": {},
  "artifacts": [],
  "decisions": []
}
```

Required fields may remain minimal for backward compatibility.

Recommended fields:

- `schemaVersion`
- `kind`
- `name`
- `status`
- `steps`
- `relationships`
- `artifacts`
- `decisions`

## Kind-Specific Sections

Kind-specific data should live in kind-specific sections, for example:

```json
{
  "kind": "workflow-set",
  "workflowSet": {
    "children": [],
    "decompositionStrategy": "business-capability"
  }
}
```

Feature-specific scope and predecessor data should stay in approved artifacts or standard journal fields:

```json
{
  "kind": "feature",
  "relationships": {
    "predecessors": []
  }
}
```

This avoids mixing workflow-set coordination fields into normal feature workflows.

## Step Names By Kind

Feature workflows keep the current SLDD steps:

```text
01-product-intent
99-codebase-context
02-high-level-design
03-low-level-design
04-tests-red
05-implementation-green
06-verification
```

Workflow-set workflows use their own compact steps:

```text
01-workflow-set-plan
02-scaffold-children
03-verify-workflow-set
```

The router should choose the valid step set based on `kind`.

## Migration Policy

No automatic migration is required for existing workflows.

When an old workflow is resumed:

- If `kind` is missing, infer `feature`.
- Continue using the existing feature workflow gates.
- Do not rewrite the journal solely to add `kind` unless a normal journal update is already being made.

When a new workflow is created:

- Write `kind` explicitly.
- Use the correct step set for that kind.

## Rationale

This keeps the new decomposition model additive.

The SLDD skill can support workflow sets while preserving existing workflow behavior and avoiding a disruptive journal migration.

## Refinement 17: Command Surface For Workflow Decomposition

Workflow decomposition should be available through explicit commands and through agent recommendation during exploration or Step 01 startup.

Possible commands:

```text
/sldd decompose <idea>
/sldd plan workflow-set <idea>
/sldd scaffold workflow-set <workflow-set-name>
/sldd resume <workflow-or-workflow-set-name>
```

## `/sldd decompose <idea>`

Purpose:

```text
Analyze a large idea and propose whether it should become a workflow-set.
```

Behavior:

- Does not write files by default.
- Produces a proposed decomposition summary in the conversation.
- Recommends a workflow-set name.
- Identifies candidate child workflows.
- Identifies preliminary predecessors and parallelization.
- Asks for approval before creating the workflow-set journal and plan artifact.

## `/sldd plan workflow-set <idea>`

Purpose:

```text
Create or resume a workflow-set planning workflow after approval.
```

Behavior:

- Creates or resumes `.sldd/specs/<workflow-set-name>/`.
- Creates or updates `_spec-journal.json` with `name` and `kind: "workflow-set"`.
- Creates or updates `01-workflow-set-plan.md`.
- Does not create child workflows.
- Stops for approval before `02-scaffold-children`.

## `/sldd scaffold workflow-set <workflow-set-name>`

Purpose:

```text
Create approved child workflows from an approved workflow-set plan.
```

Behavior:

- Requires `01-workflow-set-plan` to be complete or explicitly approved.
- Creates only approved/proposed child workflows selected for scaffold.
- Initializes child workflows with Step 01 `pending`.
- Uses `origin.type: "workflow-set-scaffold"` in child Step 01 metadata.
- Stops on conflicts.
- Does not mark child Step 01 complete.

## Recommendation During Exploration

During Step 88 exploration or before Step 01 of a normal workflow, the agent may recommend decomposition if the idea appears too large.

The agent should ask before switching modes:

```text
This idea appears large enough to benefit from a workflow-set.

Do you want me to decompose it before starting a normal Step 01?
```

If the user agrees, route to workflow-set planning.

## Confirmation Rules

The agent must ask for explicit confirmation before:

- Creating a workflow-set journal.
- Writing `01-workflow-set-plan.md`.
- Marking `01-workflow-set-plan` complete.
- Scaffolding child workflows.
- Regenerating child Step 01 drafts.
- Overwriting any existing workflow artifact.

## Rationale

The command surface separates analysis, planning, scaffolding, and resume behavior.

This keeps workflow decomposition powerful but controlled, and prevents accidental generation of many workflow files from an exploratory conversation.

## Refinement 18: Minimal Templates For Workflow Decomposition

Workflow decomposition should introduce a small number of templates.

Avoid creating a large template system initially.

## Required Templates

Two templates are enough for the first version:

```text
templates/01-workflow-set-plan.md
templates/01-product-intent-from-workflow-set.md
```

## `01-workflow-set-plan.md` Template

Purpose:

```text
Capture the approved decomposition plan for a large idea.
```

Suggested sections:

```markdown
# Workflow-Set Plan: <Name>

## Workflow Kind

`workflow-set`

## Large Idea

<Describe the large idea being decomposed.>

## Source Inputs

- <Exploration summary, document, URL, issue, roadmap, or other input.>

## Why Decomposition Is Recommended

- <Reason 1>
- <Reason 2>

## Proposed Child Workflows

| Workflow | Kind | Scope | Predecessors | Notes |
|---|---|---|---|---|
| `<child>` | `feature` | <scope> | <predecessors> | <notes> |

## Execution Guidance

- <Recommended phases or ordering.>
- <Parallelization opportunities.>

## Out Of Scope

- <What this workflow-set will not do.>

## Scaffold Selection

- <Which proposed children should be scaffolded now.>
- <Which proposed children should remain only planned, if any.>

## Approval

Status: Pending explicit approval.
```

## `01-product-intent-from-workflow-set.md` Template

Purpose:

```text
Create a self-contained Step 01 draft for a child workflow.
```

Suggested sections:

```markdown
# Product Intent: <Child Workflow Name>

## Workflow Kind

`feature`

## Parent Workflow-Set

`<workflow-set-name>`

## Origin

This Step 01 draft was scaffolded from:

- Parent journal: `<relative-path>`
- Parent artifact: `<relative-path>`

## Scope

Included:

- <Included capability, endpoint, behavior, module, or task.>

Excluded:

- <Explicit exclusions.>

## Workflow Precedence

Required predecessors:

- `<predecessor>`

Approval gate:

- This Step 01 must not be marked complete until required predecessors have completed Step 06 verification.

## Product Intent

<Intent of this child workflow.>

## Acceptance Criteria Draft

- <Draft acceptance criterion.>

## Open Questions

- <Questions to resolve before Step 01 approval.>

## Approval Status

Pending explicit Step 01 approval.
```

## Template Rules

- Templates should make approval state explicit.
- Child Step 01 templates must be resumable without the original conversation.
- Workflow-set templates must distinguish planning from scaffolding.
- Templates should include predecessor information in human-readable form.
- Templates should not include implementation details beyond scope boundaries.

## Rationale

These two templates cover the core decomposition flow without adding unnecessary complexity.

Additional templates can be added later only if repeated usage shows a concrete need.

## Refinement 19: When To Recommend Or Avoid Decomposition

The agent should not recommend workflow decomposition for every non-trivial request.

Workflow decomposition is useful only when the idea is large enough that a single SLDD workflow would become unclear, unsafe, or difficult to execute.

## Recommend Decomposition When

Recommend workflow-set planning when several of these signals are present:

- The idea includes multiple independent capabilities.
- The idea spans several endpoints, screens, modules, bounded contexts, or business components.
- There are clear predecessor relationships.
- Some work can safely run in parallel after foundational work is complete.
- The request would create an oversized Step 01 with unrelated acceptance criteria.
- There is a high risk of scope creep if handled as one workflow.
- Work will likely involve multiple worktrees or branches.
- The user provides a large structured input, such as OpenAPI, roadmap, epic, migration plan, or legacy specification.
- The user describes a broad initiative, such as a complete API, full module, migration, platform, or roadmap.

## Avoid Decomposition When

Avoid recommending workflow-set planning when:

- The request has one clear product outcome.
- The work fits naturally into one Step 01.
- Dependencies are minimal or internal to one capability.
- Parallel execution is not useful.
- The decomposition would produce artificial child workflows.
- The overhead of parent planning exceeds the coordination benefit.
- The user explicitly asks to keep the work as one workflow.

## Ambiguous Cases

When unclear, the agent should ask one focused question instead of forcing decomposition.

Example:

```text
This can be handled either as one workflow or decomposed into a workflow-set.

I recommend a single workflow unless you expect the authentication, profile, and article workstreams to be developed independently.

Do you want one workflow or a decomposed workflow-set?
```

## Default Bias

The default bias should be:

```text
Prefer one workflow unless decomposition clearly improves safety, clarity, or parallel execution.
```

This prevents workflow-set planning from becoming unnecessary ceremony.

## Refinement 20: Naming And Identity Rules

Workflow decomposition needs stable names because parent and child workflows reference each other by paths and identifiers.

Names should be human-readable, filesystem-safe, and stable after scaffolding.

## Workflow-Set Name

The workflow-set name should describe the large idea, not the mechanism.

Good examples:

```text
realworld-api
billing-platform
tenant-migration
content-publishing
```

Avoid names that describe only the process:

```text
workflow-decomposition
generated-workflows
openapi-to-sldd
```

Unless the actual product idea is the generator itself.

## Child Workflow Names

Child workflow names should describe business capability or bounded scope.

Good examples:

```text
user-registration-and-login
article-authoring
profiles-and-following
article-listing-and-feed
```

Avoid names that are too technical or endpoint-specific unless the scope is truly one endpoint:

```text
post-users
get-articles-slug
endpoint-group-1
```

## Name Stability

Before scaffolding, names can be revised freely in the workflow-set plan.

After scaffolding, names become stable because they map to directories and journal paths.

Renaming a created child workflow should require explicit user approval and should be treated as a separate maintenance action.

The workflow-set should not silently rename created children.

## Collision Handling

Before scaffolding a child, check whether `.sldd/specs/<child-name>/` already exists.

If it does not exist:

- Create it.

If it exists and has matching `origin.type: "workflow-set-scaffold"` pointing to the same parent:

- Treat it as an existing scaffolded child.
- Do not overwrite approved artifacts.

If it exists without matching origin:

- Set the child's scaffold state to `conflict` in the parent.
- Ask the user to choose a resolution.

Possible resolutions:

1. Keep existing workflow and link it manually as the child.
2. Choose a different child workflow name.
3. Stop scaffolding and revise the workflow-set plan.

## Identifier Versus Display Title

The workflow directory name should be the stable identifier.

The display title can be changed more freely inside artifacts.

Example:

```json
{
  "name": "article-authoring",
  "title": "Article Authoring"
}
```

Use `name` for paths and references. Use `title` for human-readable display.

## Rationale

Stable names reduce broken references between parent and child workflows and make resuming workflows predictable.

## Refinement 21: Optional Naming Affix For New Workflow Kinds

It may be useful to distinguish workflow kinds in directory names for newly created workflows.

This should be a convention for new workflows only.

Existing workflows should not be renamed or migrated just to follow the convention.

## Candidate Conventions

Two reasonable options:

Prefix style:

```text
set-realworld-api
wf-user-registration-and-login
wf-article-authoring
```

Suffix style:

```text
realworld-api-set
user-registration-and-login-feature
article-authoring-feature
```

## Recommended Convention

Prefer suffixes because they keep the meaningful domain name first:

```text
realworld-api-set
user-registration-and-login-feature
article-authoring-feature
```

The suffix should mirror `kind`:

- `-set` for `kind: "workflow-set"`
- `-feature` for `kind: "feature"`

Examples:

```text
.sldd/specs/realworld-api-set/
.sldd/specs/user-registration-and-login-feature/
.sldd/specs/article-authoring-feature/
```

## Compatibility Rule

The `kind` field remains the source of truth.

The name suffix is only a human-readable convention.

If the suffix and `kind` disagree, the agent should trust `kind` and warn about the naming mismatch.

If `kind` is absent, existing compatibility rules apply and the workflow is treated as `kind: "feature"`.

## When To Apply

Apply affix naming when creating new workflow-set or child workflows through decomposition.

Do not apply automatically to:

- Existing workflows.
- Legacy workflows.
- User-provided workflow names unless the user agrees.
- Workflows already referenced by existing journals or artifacts.

## Rationale

Affixes make directory listings easier to understand while preserving the normalized model where `kind` controls behavior.

Keeping this convention new-workflow-only avoids disruptive path changes.

## Refinement 22: Name Approval And Suggested Names

When creating a workflow-set or scaffolding child workflows, the agent may suggest normalized names, including the optional kind suffix for new workflows.

However, the user should approve the final names before files are created.

## Suggested Name Flow

During workflow-set planning, include a table with proposed identifiers and display titles:

```markdown
| Name | Title | Kind | Scope |
|---|---|---|---|
| `realworld-api-set` | RealWorld API | `workflow-set` | Full RealWorld API decomposition |
| `user-registration-and-login-feature` | User Registration And Login | `feature` | Register and log in users |
| `article-authoring-feature` | Article Authoring | `feature` | Create, read, update, delete articles |
```

Before writing files, ask the user to confirm or revise names.

## Name Fields

Use separate fields for identifier and display title:

```json
{
  "name": "article-authoring-feature",
  "title": "Article Authoring",
  "kind": "feature"
}
```

Rules:

- `name` is the stable identifier and directory name.
- `title` is human-readable and may be revised more freely.
- References between workflows should use journal paths or stable `name` values.

## Aliases

Aliases may be useful for discoverability, especially if suffixes are used.

Example:

```json
{
  "name": "user-registration-and-login-feature",
  "title": "User Registration And Login",
  "aliases": [
    "user-registration-and-login"
  ]
}
```

Aliases are optional.

If supported, aliases should be used only for lookup convenience, not as canonical references.

The canonical reference remains the workflow path and `name`.

## Rationale

Name approval prevents the agent from creating many files with names the user does not want.

Separating `name`, `title`, and optional `aliases` keeps filesystem identity stable while preserving readable documentation.

## Refinement 23: Incremental Implementation Strategy

Workflow decomposition should be added incrementally to avoid overcomplicating SLDD in one change.

## Phase 1: Recommendation Only

Add the large-idea heuristic to the SLDD skill.

Behavior:

- Detect when a user request may be too large for one workflow.
- Recommend decomposition.
- Ask whether the user wants workflow-set planning.
- Do not add new commands yet.
- Do not create workflow-set artifacts automatically.

This phase improves guidance without changing storage or journal schema.

## Phase 2: Workflow-Set Planning Artifact

Add support for creating a workflow-set parent workflow.

Behavior:

- Support `kind: "workflow-set"` in new journals.
- Add `01-workflow-set-plan.md` template.
- Add compact parent steps:
  - `01-workflow-set-plan`
  - `02-scaffold-children`
  - `03-verify-workflow-set`
- Create only the parent workflow-set and plan.
- Do not scaffold children yet.

This phase makes decomposition resumable.

## Phase 3: Child Workflow Scaffolding

Add safe child scaffold support.

Behavior:

- Scaffold child workflow directories from an approved plan.
- Create child `_spec-journal.json` with `name` and `kind: "feature"`.
- Create child `01-product-intent-specification.md` as a self-contained draft.
- Set child Step 01 to `pending` with `origin.type: "workflow-set-scaffold"`.
- Use simplified scaffold states: `proposed`, `created`, `conflict`.
- Stop on conflicts.

This phase turns approved plans into resumable child workflows.

## Phase 4: Resume Enhancements

Enhance `/sldd resume <name>` behavior.

Behavior:

- Detect `name` and `kind`.
- Resume feature workflows as today.
- Resume workflow-set parent steps when pending.
- If workflow-set parent is complete, list children by reading child journals.
- Do not auto-select a child when multiple are pending.
- Ask before switching to a single available child.

This phase improves usability without making the parent an orchestrator.

## Phase 5: Regeneration And Maintenance

Add optional maintenance operations.

Behavior:

- Regenerate pending child Step 01 drafts from the parent plan with explicit approval.
- Handle plan revisions after scaffolding.
- Provide collision/conflict resolution prompts.
- Optionally support aliases for workflow lookup.

This phase can wait until the core flow proves useful.

## Recommended First Implementation

Start with Phase 1 and Phase 2 only.

Do not implement scaffolding until workflow-set planning has been tested with real examples.

This keeps the first change small and validates whether the concept improves SLDD usage before adding file-generation complexity.

## Refinement 24: Risks And Guardrails

Workflow decomposition adds coordination power, but it also risks adding too much process.

The feature should include guardrails to keep SLDD lightweight and safe.

## Risk: Over-Decomposition

The agent might recommend workflow-sets for tasks that fit a single workflow.

Guardrails:

- Default to one workflow unless decomposition clearly improves safety, clarity, or parallelization.
- Ask one clarifying question in ambiguous cases.
- Let the user explicitly choose a single workflow.
- Avoid creating workflow-sets for small or linear tasks.

## Risk: Workflow-Set Becomes Orchestrator

The parent might start tracking child execution state or controlling child progress.

Guardrails:

- Parent stores only plan/scaffold coordination.
- Child workflows own their step statuses.
- Parent does not persist child readiness or progress.
- Aggregate views are computed on demand and not written back as child execution state.
- Child workflows enforce predecessor gates locally.

## Risk: Accidental File Explosion

The agent might create many workflows from an exploratory conversation.

Guardrails:

- Decomposition recommendation does not write files.
- Workflow-set planning requires explicit approval.
- Child scaffolding requires explicit approval after the plan exists.
- Generated child Step 01 artifacts remain pending.

## Risk: Bypassing SLDD Gates

Generated drafts might be treated as approved scope.

Guardrails:

- Scaffolded child Step 01 status is always `pending`.
- Step 01 completion requires explicit approval.
- Predecessor checks happen before child Step 01 approval.
- Step 02+ cannot run until child Step 01 is complete.

## Risk: Cross-Worktree Synchronization

Parallel child workflows may run in separate worktrees.

Guardrails:

- Parent does not update when children advance.
- Child state is read from child journals on demand.
- Created children are independent workflows.
- The workflow-set only records stable paths, plan relationships, and scaffold state.

## Risk: Overwriting User Work

Regeneration or res-scaffolding may overwrite edited artifacts.

Guardrails:

- Never overwrite approved artifacts automatically.
- Never regenerate child Step 01 without explicit approval.
- Stop on missing or mismatched origin metadata.
- Prefer side-by-side regenerated drafts when unsure.

## Risk: Naming Confusion

Suffixes and aliases could create ambiguity.

Guardrails:

- `kind` is the source of truth.
- `name` is the stable identifier.
- `title` is display text.
- `aliases` are optional lookup aids only.
- Existing workflows are not renamed automatically.

## Summary Guardrail

The central safety rule is:

```text
Workflow-set planning may propose structure.
Only explicit user approval may create or modify workflow files.
Only child workflows may approve and execute their own SLDD gates.
```

## Refinement 25: End-To-End Flow

The refined workflow decomposition flow is:

```text
1. User presents an idea or explores one.
2. Agent detects that the idea may be too large for a single workflow.
3. Agent recommends workflow-set planning and asks for approval.
4. If approved, agent creates or resumes a workflow-set parent.
5. Agent drafts `01-workflow-set-plan.md`.
6. User approves, revises, keeps, or cancels the plan.
7. If user approves scaffolding, agent creates child workflows.
8. Each child workflow starts at Step 01 pending with a self-contained draft.
9. Child workflow validates predecessors before approving Step 01.
10. Child workflows proceed independently through normal SLDD gates.
11. Resuming the workflow-set later shows parent state or a computed child overview.
```

## Detailed Flow

### 1. Idea Intake

The idea may come from:

- Direct user request.
- Step 88 exploration.
- OpenAPI or another structured artifact.
- Roadmap, epic, migration plan, or legacy requirements.

### 2. Decomposition Recommendation

The agent applies the large-idea heuristic.

If decomposition appears useful, the agent asks before switching modes.

No files are written at this stage.

### 3. Workflow-Set Parent Creation

After approval, create or resume:

```text
.sldd/specs/<workflow-set-name>/
  _spec-journal.json
  01-workflow-set-plan.md
```

The journal has:

```json
{
  "kind": "workflow-set"
}
```

### 4. Workflow-Set Plan Approval

The plan proposes:

- Child workflows.
- Names and titles.
- Scope boundaries.
- Predecessors.
- Execution guidance.
- Scaffold selection.

The agent stops for approval.

### 5. Child Scaffolding

After approval, create selected children:

```text
.sldd/specs/<child-name>/
  _spec-journal.json
  01-product-intent-specification.md
```

Each child Step 01 is:

```json
{
  "status": "pending",
  "origin": {
    "type": "workflow-set-scaffold"
  }
}
```

### 6. Child Execution

The user resumes a child explicitly:

```text
/sldd resume <child-name>
```

The child checks its predecessors before Step 01 approval.

Once Step 01 is approved, the child follows the normal feature workflow:

```text
99 -> 02 -> 03 -> 04 -> 05 -> 06
```

### 7. Workflow-Set Resume

The user can resume the parent:

```text
/sldd resume <workflow-set-name>
```

If the parent has pending steps, resume the parent.

If the parent is complete, list children by reading their journals.

If multiple children are pending, ask the user to resume one explicitly.

## Final Shape

Workflow-set:

```text
kind: workflow-set
steps:
  01-workflow-set-plan
  02-scaffold-children
  03-verify-workflow-set
```

Child feature:

```text
kind: feature
steps:
  01-product-intent
  99-codebase-context
  02-high-level-design
  03-low-level-design
  04-tests-red
  05-implementation-green
  06-verification
```

Responsibility split:

```text
Workflow-set: decomposition, planning, scaffolding, coordination verification.
Feature child: scope approval, predecessor gate, design, tests, implementation, verification.
```

## Refinement 26: Acceptance Criteria For Adding This To SLDD

Before implementing workflow decomposition in the SLDD skill, define acceptance criteria for the capability itself.

## Core Acceptance Criteria

- Given a large idea, when the agent detects multiple capabilities or dependencies, then it recommends workflow-set planning before starting a normal Step 01.
- Given an ambiguous idea, when decomposition may or may not be useful, then the agent asks one clarifying question instead of forcing workflow-set planning.
- Given a user rejects decomposition, then the agent proceeds with the normal single-workflow SLDD flow.
- Given a user approves decomposition, then the agent creates or resumes a `kind: "workflow-set"` parent workflow only after confirmation.
- Given a workflow-set parent, then it uses the compact steps `01-workflow-set-plan`, `02-scaffold-children`, and `03-verify-workflow-set`.
- Given a workflow-set plan, then child workflows are not created until the user explicitly approves scaffolding.
- Given child workflows are scaffolded, then each child Step 01 is `pending` and includes `origin.type: "workflow-set-scaffold"`.
- Given a scaffolded child workflow is resumed, then the agent verifies predecessor completion before allowing Step 01 approval.
- Given a workflow-set is resumed after parent completion, then the agent lists children by reading child journals and does not auto-select a child when multiple are pending.
- Given existing workflows without `name` or `kind`, then the agent rejects them as invalid instead of inferring `kind: "feature"`.

## Safety Acceptance Criteria

- The agent never marks child Step 01 complete during scaffolding.
- The agent never persists child execution state in the parent workflow-set journal.
- The agent never overwrites existing child artifacts without explicit approval.
- The agent stops on scaffold conflicts instead of guessing.
- The agent does not migrate or rename existing workflows automatically.
- The agent treats `kind` as source of truth when suffix naming disagrees with journal metadata.

## Usability Acceptance Criteria

- A workflow-set plan is human-readable and includes child names, scope, predecessors, and scaffold selection.
- A scaffolded child Step 01 draft is self-contained enough to resume without the original conversation.
- `/sldd resume <name>` works for both `feature` and `workflow-set` workflows.
- Workflow-set status/resume output makes clear whether it is showing parent steps or a computed child overview.

## Minimal First Release Criteria

For an initial implementation, only these may be required:

- Large-idea heuristic recommendation.
- `kind: "workflow-set"` parent support.
- `01-workflow-set-plan.md` creation.
- Required `name` and `kind` validation for existing workflows.

Child scaffolding can be deferred to a later release.

## Refinement 27: Consolidated Decisions And Remaining Open Questions

This section consolidates the current refinement state so the proposal can be resumed later without re-reading every intermediate step.

## Consolidated Decisions

- Workflow decomposition is optional and should be recommended only when it improves clarity, safety, or parallel execution.
- Decomposition can start from structured input or emerge during Step 88 exploration.
- Exploration may recommend decomposition, but must not create artifacts without approval.
- A `workflow-set` is a normal workflow with `kind: "workflow-set"`.
- Existing workflows without `name` or `kind` are invalid.
- Workflow-set parent steps are compact: `01-workflow-set-plan`, `02-scaffold-children`, `03-verify-workflow-set`.
- `01-workflow-set-plan.md` combines intent and initial decomposition plan.
- Child workflows are not created until scaffold is explicitly approved.
- Scaffolded child workflows start with Step 01 `pending`, never `complete`.
- Scaffolded child Step 01 uses `origin.type: "workflow-set-scaffold"`.
- Child Step 01 artifacts must be self-contained and resumable.
- Workflow-set parent does not persist child execution status.
- Child workflows validate their own predecessors before approving Step 01.
- Default predecessor readiness is predecessor Step 06 complete.
- `/sldd resume <name>` branches behavior by `kind`.
- Resuming a completed workflow-set parent lists children by reading child journals and does not auto-select when multiple children are pending.
- Scaffold coordination states are simplified to `proposed`, `created`, and `conflict`.
- `kind` is the source of truth; suffix naming is optional and for new workflows only.
- Existing workflows should not be renamed or migrated automatically.

## Remaining Open Questions

- Should workflow-set support be added as a formal new step file, or implemented as routing behavior plus templates?
- Should regenerated child Step 01 drafts use side-by-side files by default, or only when overwrite risk is detected?

## Recommended Next Decision

The next useful decision is the first implementation scope.

Recommended initial scope:

```text
Phase 1 + Phase 2 + Phase 3
```

That means:

- Add large-idea decomposition recommendation.
- Add `kind: "workflow-set"` support for new parent workflows.
- Add `01-workflow-set-plan.md` template.
- Add backward-compatible `kind` inference for existing workflows.
- Add child workflow scaffolding.

This includes safe child file generation from an approved workflow-set plan.

## Refinement 28: Closed Decisions For First Version

The following open questions were resolved for the first version:

## Child Scaffolding

Decision:

```text
Implement child workflow scaffolding in the first version.
```

This means the first implementation includes:

- `01-workflow-set-plan`
- `02-scaffold-children`
- `03-verify-workflow-set`
- child `_spec-journal.json` creation
- child `01-product-intent-specification.md` draft creation
- `origin.type: "workflow-set-scaffold"`
- scaffold states `proposed`, `created`, `conflict`

## Predecessor Requirement

Decision:

```text
Child Step 01 approval always requires predecessor Step 06 completion.
```

No weaker readiness policy is included in the first version.

This keeps the rule simple and safe.

## Aliases

Decision:

```text
Aliases are included in the first version only if they provide immediate value.
```

Aliases are optional convenience metadata, not required for the core workflow decomposition flow.

If omitted initially, lookup should rely on canonical `name` and filesystem path.

## Suffix Naming

Decision:

```text
Suffix naming is the default for decomposition-created workflows.
```

Default suffixes:

- `-set` for `kind: "workflow-set"`
- `-feature` for `kind: "feature"`

Examples:

```text
realworld-api-set
user-registration-and-login-feature
article-authoring-feature
```

The `kind` field remains the source of truth. Suffixes are a naming convention for new workflows only.

## Workflow-Set Verification Artifact

Decision:

```text
Workflow-set verification does not need its own artifact in the first version.
```

`03-verify-workflow-set` may update the journal and report verification results in the conversation.

A dedicated verification artifact can be added later if repeated usage shows a need.

## Refinement 29: First Version Scope

The first version should include recommendation, workflow-set planning, child scaffolding, and basic resume support.

## Included Capabilities

### Large-Idea Recommendation

- Detect likely large ideas before starting a normal Step 01.
- Recommend workflow-set planning when appropriate.
- Ask for confirmation before creating artifacts.

### Workflow-Set Creation

- Create `.sldd/specs/<name>-set/` for new workflow-sets by default.
- Create `_spec-journal.json` with `name` and `kind: "workflow-set"`.
- Create `01-workflow-set-plan.md`.
- Use compact workflow-set steps:
  - `01-workflow-set-plan`
  - `02-scaffold-children`
  - `03-verify-workflow-set`

### Child Scaffolding

- Create `.sldd/specs/<name>-feature/` for child feature workflows by default.
- Create child `_spec-journal.json` with `name` and `kind: "feature"`.
- Create child `01-product-intent-specification.md`.
- Set child Step 01 to `pending`.
- Add `origin.type: "workflow-set-scaffold"` to child Step 01 metadata.
- Copy predecessor metadata into child journal and Step 01 artifact.
- Stop on conflicts.

### Predecessor Gate

- When resuming a child workflow, check predecessor journals before Step 01 approval.
- Require predecessor Step 06 completion.
- Allow review/revision of Step 01 draft while blocked.
- Do not allow Step 01 completion while predecessors are incomplete.

### Resume Behavior

- `/sldd resume <feature>` continues normal feature workflow behavior.
- `/sldd resume <workflow-set>` resumes parent steps if pending.
- If workflow-set parent steps are complete, list child workflows by reading child journals.
- Do not auto-select when multiple children are pending.

### Verification

- `03-verify-workflow-set` checks coordination consistency.
- No dedicated verification artifact is required in the first version.
- Verification results may be reported in the conversation and journal evidence/notes.

## Excluded From First Version

- Advanced readiness policies weaker than predecessor Step 06 completion.
- Parent orchestration of child execution.
- Persisted child execution state in parent journal.
- Automatic migration or renaming of existing workflows.
- Automatic child Step 01 completion.
- Automatic artifact overwrite.
- Dedicated workflow-set verification report artifact.
- Aliases, unless there is immediate lookup value during implementation.
- Sophisticated dashboard beyond simple child listing on workflow-set resume.

## First Version Success Criteria

The first version is successful if a user can:

1. Ask SLDD to decompose a large idea.
2. Approve a workflow-set plan.
3. Scaffold child workflows from that plan.
4. Resume a child workflow later with enough context in its Step 01 draft.
5. Be blocked from approving a child Step 01 until predecessors complete Step 06.
6. Resume the workflow-set and see a simple child overview without parent orchestration.

## Refinement 30: First Version Journal Shapes

The first version should keep journal shapes minimal and explicit.

## Workflow-Set Journal Shape

Example:

```json
{
  "schemaVersion": "1.0",
  "kind": "workflow-set",
  "name": "realworld-api-set",
  "title": "RealWorld API",
  "status": "in_progress",
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
        "name": "user-registration-and-login-feature",
        "title": "User Registration And Login",
        "kind": "feature",
        "scaffold": {
          "state": "proposed"
        },
        "predecessors": []
      },
      {
        "name": "article-authoring-feature",
        "title": "Article Authoring",
        "kind": "feature",
        "scaffold": {
          "state": "proposed"
        },
        "predecessors": [
          "user-registration-and-login-feature"
        ]
      }
    ]
  }
}
```

After successful scaffold:

```json
{
  "name": "article-authoring-feature",
  "title": "Article Authoring",
  "kind": "feature",
  "scaffold": {
    "state": "created",
    "journal": "../article-authoring-feature/_spec-journal.json",
    "originArtifact": "01-workflow-set-plan.md"
  },
  "predecessors": [
    "user-registration-and-login-feature"
  ]
}
```

## Child Feature Journal Shape

Example:

```json
{
  "schemaVersion": "1.0",
  "kind": "feature",
  "name": "article-authoring-feature",
  "title": "Article Authoring",
  "status": "in_progress",
  "relationships": {
    "parents": [
      "../realworld-api-set/_spec-journal.json"
    ],
    "predecessors": [
      "../user-registration-and-login-feature/_spec-journal.json"
    ]
  },
  "steps": {
    "01-product-intent": {
      "status": "pending",
      "artifact": "01-product-intent-specification.md",
      "origin": {
        "type": "workflow-set-scaffold",
        "journal": "../realworld-api-set/_spec-journal.json",
        "artifact": "../realworld-api-set/01-workflow-set-plan.md"
      }
    },
    "99-codebase-context": {
      "status": "pending"
    },
    "02-high-level-design": {
      "status": "pending"
    },
    "03-low-level-design": {
      "status": "pending"
    },
    "04-tests-red": {
      "status": "pending"
    },
    "05-implementation-green": {
      "status": "pending"
    },
    "06-verification": {
      "status": "pending"
    }
  }
}
```

## Conflict Shape

If scaffold fails for a child, use:

```json
{
  "name": "article-authoring-feature",
  "title": "Article Authoring",
  "kind": "feature",
  "scaffold": {
    "state": "conflict",
    "reason": "Directory already exists without matching workflow-set origin.",
    "existingJournal": "../article-authoring-feature/_spec-journal.json"
  },
  "predecessors": [
    "user-registration-and-login-feature"
  ]
}
```

## Compatibility

For existing feature workflows, missing `kind` means `kind: "feature"`.

The first version should avoid requiring all common fields in old journals.

New workflow-set and scaffolded child journals should write `kind`, `name`, `title`, `status`, and `steps` explicitly.

## Refinement 31: Workflow-Set Plan Validation Before Scaffold

Before running `02-scaffold-children`, the agent must validate the approved `01-workflow-set-plan.md` and parent journal.

This prevents creating inconsistent child workflows.

## Required Validation Checks

The agent should verify:

- The workflow-set journal has `kind: "workflow-set"`.
- `01-workflow-set-plan` is complete or explicitly approved for scaffold.
- Every selected child has a stable `name`.
- Every selected child has a `title`.
- Every selected child has a `kind`, usually `feature`.
- Every selected child name follows the default suffix convention unless the user approved a custom name.
- Child names are unique within the workflow-set.
- Child names do not collide with existing `.sldd/specs/<name>/` directories unless they are matching existing scaffolded children.
- Every predecessor name refers to a known child workflow or an explicitly external workflow.
- There are no predecessor cycles.
- Each selected child has enough scope information to create a self-contained Step 01 draft.
- The scaffold selection is explicit.

## Cycle Detection

The plan must not contain cycles such as:

```text
A depends on B
B depends on C
C depends on A
```

If a cycle exists, the agent should stop and ask for plan revision.

## External Predecessors

Most predecessors should be child workflows in the same workflow-set.

If a predecessor is external, it must include a journal path or clear reference.

Example:

```json
{
  "name": "some-child-feature",
  "predecessors": [
    {
      "name": "existing-auth-feature",
      "journal": "../existing-auth-feature/_spec-journal.json",
      "external": true
    }
  ]
}
```

## Validation Failure Behavior

If validation fails:

- Do not scaffold any children.
- Report all validation issues found.
- Route back to revising `01-workflow-set-plan.md`.

Do not partially scaffold from an invalid plan.

## Rationale

Plan validation keeps scaffold deterministic and prevents avoidable conflicts or broken predecessor gates in child workflows.

## Refinement 32: Scaffold Atomicity And Partial Failure Handling

Child scaffolding should avoid partial creation when possible.

However, filesystem operations can fail midway, so the workflow-set must handle partial results safely.

## Preferred Behavior

Before writing any child files:

1. Validate the full plan.
2. Check all target directories.
3. Detect collisions and conflicts.
4. Prepare the full scaffold batch.

If any preflight check fails, do not create any child workflows.

## Write Order

For each child, write in a safe order:

1. Create child directory.
2. Write child `01-product-intent-specification.md`.
3. Write child `_spec-journal.json`.
4. Update parent child scaffold state to `created` only after child files are complete.

The parent should not mark a child as `created` before the child journal exists.

## Partial Failure

If a failure occurs after some children were created:

- Do not delete created children automatically.
- Update parent entries for successfully created children to `created`.
- Mark failed child entries as `conflict` with a reason.
- Leave not-yet-attempted children as `proposed`.
- Report the partial scaffold clearly to the user.

Example:

```json
{
  "name": "comments-feature",
  "scaffold": {
    "state": "conflict",
    "reason": "Failed to write child journal after creating directory. Manual inspection required."
  }
}
```

## Retry Behavior

On retry:

- Treat `created` children as already complete scaffold results.
- Re-check `conflict` children.
- Re-check `proposed` children.
- Do not overwrite existing files unless the user explicitly approves.

## Rationale

This provides practical atomicity without requiring complex rollback.

The system remains safe because completed children are valid independent workflows, and incomplete or suspicious results are surfaced as conflicts instead of hidden.

## Refinement 33: Predecessors Are Local Workflow Journal References

There is no need to distinguish whether a predecessor belongs to the same workflow-set or not.

The workflow-set and child workflows can only reason over workflow journals available in the same project workspace.

Decision:

> A predecessor is simply another local workflow journal that must exist and be complete before the dependent workflow can approve Step 01.

## Predecessor Representation

In the workflow-set plan, predecessors may be shown by workflow name for readability:

```json
{
  "name": "article-authoring-feature",
  "predecessors": [
    "user-registration-and-login-feature"
  ]
}
```

During scaffold, the child journal should store predecessor journal paths:

```json
{
  "relationships": {
    "predecessors": [
      "../user-registration-and-login-feature/_spec-journal.json"
    ]
  }
}
```

If the predecessor is an existing workflow not created by the same workflow-set, the same representation is used:

```json
{
  "relationships": {
    "predecessors": [
      "../existing-auth-feature/_spec-journal.json"
    ]
  }
}
```

No `external` flag is required.

## Predecessor Validation

Before scaffold:

- Each predecessor name or path must resolve to a local workflow journal, or to a child workflow that will be scaffolded in the same batch.
- Predecessor cycles are invalid.
- Missing predecessor journals block scaffold unless the predecessor is another child being created in the same scaffold batch.

## Child Step 01 Gate

When approving child Step 01:

- Every predecessor journal path must be readable.
- Every predecessor workflow must have Step 06 verification complete.
- If any predecessor journal is missing or incomplete, Step 01 approval is blocked.

## Rationale

The only fact that matters for dependency enforcement is whether the predecessor workflow journal exists locally and has completed Step 06.

Whether the predecessor came from the same workflow-set is irrelevant to the approval gate.

## Refinement 34: Predecessor Paths Belong To Child Journals

The workflow-set does not need to resolve predecessor execution state and should not own predecessor enforcement.

The workflow-set plan may record predecessor relationships by name for readability:

```json
{
  "name": "article-authoring-feature",
  "predecessors": [
    "user-registration-and-login-feature"
  ]
}
```

The child workflow journal is where executable predecessor references belong:

```json
{
  "relationships": {
    "predecessors": [
      "../user-registration-and-login-feature/_spec-journal.json"
    ]
  }
}
```

Decision:

> The workflow-set stores predecessor names as planning information. The scaffold operation materializes those predecessor references into child journal paths.

## What The Workflow-Set Does

The workflow-set is responsible for documenting intended predecessor relationships in the plan.

It does not need to:

- Check whether predecessors are complete.
- Persist predecessor readiness.
- Recompute child execution state.
- Enforce predecessor gates.

## What Scaffold Does

When creating a child workflow, scaffold writes the predecessor paths into that child journal.

For children created in the same workflow-set, paths are deterministic:

```text
../<predecessor-name>/_spec-journal.json
```

For predecessors that already exist outside the scaffold batch, the user or plan must provide enough information for the child journal to contain the correct path.

If the path cannot be determined unambiguously while creating the child journal, scaffold should stop and ask the user.

## What The Child Does

When the child workflow is resumed, it reads its own `relationships.predecessors` paths.

Before approving Step 01, the child verifies:

- Each predecessor journal exists and is readable.
- Each predecessor has Step 06 verification complete.

If any predecessor is missing or incomplete, the child Step 01 remains pending.

## Rationale

This keeps responsibilities clean:

```text
Workflow-set: names and planning relationships.
Scaffold: writes concrete child journal references.
Child workflow: enforces predecessor completion.
```

The workflow-set does not need to resolve or track predecessor state after scaffold.

## Refinement 35: Responsibility Matrix

The workflow decomposition model should keep responsibilities sharply separated.

## Responsibility Matrix

| Concern | Workflow-Set | Scaffold Operation | Child Workflow |
|---|---|---|---|
| Detect large idea | yes | no | no |
| Recommend decomposition | yes | no | no |
| Store decomposition plan | yes | no | no |
| Store child predecessor names | yes | no | copied from plan only |
| Create child files | no | yes | no |
| Convert predecessor names to child journal paths | no | yes | receives paths |
| Track scaffold state | yes | updates parent | no |
| Track child execution state | no | no | yes |
| Approve child Step 01 | no | no | yes |
| Enforce predecessor completion | no | no | yes |
| Run Step 02+ | no | no | yes |
| Compute overview on resume | yes, read-only view | no | no |
| Persist overview state | no | no | no |

## Key Rule

```text
The workflow-set owns the plan.
The scaffold operation materializes approved child drafts.
The child workflow owns execution and gates.
```

## Practical Consequence

If there is uncertainty about whether something belongs in the parent or child, use this rule:

```text
If it affects whether files should exist, it belongs to the workflow-set/scaffold.
If it affects whether a workflow step can complete, it belongs to that workflow's own journal and gates.
```

Examples:

- Child name collision: scaffold concern.
- Child Step 01 approval: child concern.
- Child predecessor Step 06 check: child concern.
- Child listed in decomposition plan: workflow-set concern.
- Child advanced to Step 03: child concern, not parent state.

## Rationale

This matrix prevents the workflow-set from gradually becoming an execution orchestrator while still allowing it to provide useful decomposition and scaffolding.

## Refinement 36: Explicit Approval Checkpoints

Workflow decomposition must have clear stop points where the agent asks for user approval.

These checkpoints prevent an exploratory conversation from turning into file generation or scope approval without consent.

## Required Approval Points

The agent must stop and ask before:

1. Switching from exploration or normal workflow startup into workflow-set planning.
2. Creating a new workflow-set directory and journal.
3. Writing or replacing `01-workflow-set-plan.md`.
4. Marking `01-workflow-set-plan` complete.
5. Running `02-scaffold-children`.
6. Creating child workflow directories.
7. Replacing an existing child Step 01 draft.
8. Marking any child Step 01 complete.
9. Resolving scaffold conflicts by linking, renaming, or overwriting anything.

## Approval Checkpoint Flow

Recommended flow:

```text
Recommendation
  -> approve workflow-set planning
  -> choose plan materialization mode
  -> optionally create parent workflow-set and plan artifact
  -> approve plan if not already approved
  -> approve scaffold
  -> create child drafts
  -> child workflows approve their own Step 01 later
```

## Plan Materialization Modes

After the agent proposes workflow-set planning, the user should be able to choose how the `01-workflow-set-plan.md` is handled.

Supported modes:

1. Write and mark complete.
2. Write as draft and wait for review.
3. Do not write files.

## Mode 1: Write And Mark Complete

Use when the user explicitly approves the proposed decomposition as final enough to become the workflow-set plan.

Effects:

- Create the workflow-set directory and journal if needed.
- Write `01-workflow-set-plan.md`.
- Mark `01-workflow-set-plan` as `complete`.
- Do not scaffold children unless scaffold is also explicitly approved.

This mode combines writing the plan and approving the plan, but not scaffolding children.

## Mode 2: Write As Draft And Wait For Review

Use when the user wants the plan saved but not approved yet.

Effects:

- Create the workflow-set directory and journal if needed.
- Write `01-workflow-set-plan.md`.
- Keep `01-workflow-set-plan` as `pending`.
- Stop for review.

This is the safest default when the plan is non-trivial.

## Mode 3: Do Not Write Files

Use when the user wants to continue discussing the decomposition in conversation only.

Effects:

- Do not create the workflow-set directory.
- Do not create or update a journal.
- Do not write `01-workflow-set-plan.md`.
- Keep the interaction exploratory.

## Recommended Prompt

```text
How should I handle the workflow-set plan?

1. Write it and mark it complete.
2. Write it as a draft and wait for review. (Recommended)
3. Do not write files yet.
```

## Combined Approvals

The user may approve multiple adjacent actions in one response if the agent states them clearly.

Example:

```text
Approve creating `realworld-api-set` and drafting `01-workflow-set-plan.md`?
```

This may combine parent creation and plan drafting.

Do not combine plan approval and child scaffolding unless the user explicitly approves both.

Unsafe combined approval:

```text
Create the plan and scaffold all children.
```

Safe combined approval:

```text
Approve this final plan and scaffold the selected child workflows listed in the Scaffold Selection section.
```

Even in combined approval, scaffolding must be explicitly named. Approval to write or complete the plan alone is not approval to create child workflows.

## Refinement 37: Workflow-Set Plan Step State By Materialization Mode

The selected materialization mode determines the state of `01-workflow-set-plan` and the next valid action.

## Mode Outcomes

| Mode | Files Written | Step State | Next Valid Action |
|---|---|---|---|
| Write and mark complete | yes | `complete` | Ask whether to run `02-scaffold-children` |
| Write as draft | yes | `pending` | Review, revise, or approve `01-workflow-set-plan` |
| Do not write files | no | no journal state | Continue exploration/conversation |

## Write And Mark Complete

Journal example:

```json
{
  "steps": {
    "01-workflow-set-plan": {
      "status": "complete",
      "artifact": "01-workflow-set-plan.md"
    },
    "02-scaffold-children": {
      "status": "pending"
    }
  }
}
```

After this, the agent may ask:

```text
The workflow-set plan is complete.

Do you want to scaffold the selected child workflows now?
```

## Write As Draft

Journal example:

```json
{
  "steps": {
    "01-workflow-set-plan": {
      "status": "pending",
      "artifact": "01-workflow-set-plan.md"
    },
    "02-scaffold-children": {
      "status": "pending"
    }
  }
}
```

After this, the agent should not offer scaffold as the next action.

It should offer:

1. Review the draft.
2. Revise the draft.
3. Approve the plan.
4. Leave it pending.

## Do Not Write Files

No journal exists or changes.

The agent remains in exploration/planning conversation mode.

The user can later request materialization.

## Rationale

This makes plan approval state explicit and avoids accidental child scaffolding from a draft or conversational proposal.

## Refinement 38: Scaffold Is All-Or-Nothing In First Version

Partial scaffold selection is useful, but it should be postponed.

First-version rule:

```text
If scaffold is approved, scaffold all proposed child workflows in the approved workflow-set plan.
If scaffold is not approved, scaffold none.
```

No `selectedForScaffold` field is required in the first version.

## Workflow-Set Plan Wording

The plan should make the all-or-nothing behavior clear:

```markdown
## Scaffold Policy

If scaffold is approved, all proposed child workflows in this plan will be created as Step 01 pending drafts.

Partial scaffold selection is not part of the first version.
```

## Scaffold Rule

`02-scaffold-children` should attempt to scaffold every child listed in the approved plan whose scaffold state is `proposed`.

Children already in `created` state are left unchanged.

Children in `conflict` state require user resolution before they can be scaffolded successfully.

## Future Improvement

Partial scaffold selection may be added later with an explicit field such as:

```json
"selectedForScaffold": true
```

But this is intentionally excluded from the first version.

## Rationale

All-or-nothing scaffold keeps the first version simpler and avoids adding another selection lifecycle before the core decomposition flow is validated.

## Refinement 39: All-Or-Nothing Approval Versus Partial Failure

The first version uses all-or-nothing scaffold approval, but filesystem execution may still fail partially.

These are different concepts.

## All-Or-Nothing Approval

All-or-nothing approval means:

```text
The user approves scaffolding all proposed children in the plan, or none of them.
```

It does not mean the implementation must roll back already-created files if an unexpected filesystem failure happens midway.

## Execution Behavior

The scaffold operation should still try to avoid partial writes through preflight validation.

Before creating children:

- Validate plan.
- Check names.
- Check collisions.
- Check predecessor references.
- Check target directories.

If preflight fails, create nothing.

## If Runtime Failure Happens

If a failure occurs after writing starts:

- Keep successfully created child workflows.
- Mark successfully created children as `created`.
- Mark failed children as `conflict` with reason.
- Leave not-yet-attempted children as `proposed`.
- Report partial failure clearly.

Do not delete created children automatically.

## Rationale

This keeps the user decision simple while avoiding unsafe rollback behavior.

The user's approval is all-or-nothing. The filesystem result is best-effort safe and recoverable if an unexpected failure occurs.

## Refinement 40: Status And Navigation Behavior

Workflow-set support should integrate with existing SLDD navigation/status behavior without adding a complex dashboard.

## Listing Workflows

When listing available workflows, show `kind` when available.

Example:

```text
Available workflows:
- realworld-api-set              workflow-set  in_progress
- user-registration-and-login-feature  feature  in_progress
- article-authoring-feature      feature       pending
```

If `kind` is missing, display `feature` by compatibility inference.

## `/sldd status`

When no workflow is specified, status may list active workflows grouped by kind:

```text
Workflow sets:
- realworld-api-set

Feature workflows:
- user-registration-and-login-feature
- article-authoring-feature
```

If there is exactly one active workflow-set and no active feature workflow, `/sldd status` may show that workflow-set's parent status.

If there are multiple active workflows, ask the user to choose.

## `/sldd status <workflow-set>`

For a workflow-set:

- Show parent step statuses.
- If parent is complete, show a simple computed child list by reading child journals.
- Do not persist computed child state in the parent journal.
- Do not auto-route into a child when multiple are actionable.

Example:

```text
Workflow-set: realworld-api-set

Parent steps:
- 01-workflow-set-plan: complete
- 02-scaffold-children: complete
- 03-verify-workflow-set: complete

Children:
- user-registration-and-login-feature: Step 06 complete
- current-user-management-feature: Step 01 pending
- article-authoring-feature: Step 01 pending
```

## `/sldd status <feature>`

For a feature workflow, preserve current behavior.

If the feature has a workflow-set parent, optionally show a short origin line:

```text
Parent workflow-set: realworld-api-set
```

## Rationale

Status should help users navigate workflow sets and children, but it should remain informational.

Execution still happens by explicitly resuming the chosen workflow.

## Refinement 41: Documentation Updates Needed

If workflow decomposition is added to the SLDD skill, the documentation should be updated in a few focused places.

## Skill Documentation

Update the main SLDD skill instructions to include:

- Large-idea decomposition heuristic.
- `workflow-set` as a workflow kind.
- The compact workflow-set step flow.
- The rule that workflow-set does not orchestrate child execution.
- The rule that child workflows enforce predecessor completion before Step 01 approval.
- The `kind` compatibility rule for existing workflows.

## Step Documentation

Add or update step docs for:

```text
01-workflow-set-plan
02-scaffold-children
03-verify-workflow-set
```

Each step doc should state:

- Purpose.
- Inputs.
- Outputs.
- Required approvals.
- What it must not do.

## Templates

Add templates for:

```text
01-workflow-set-plan.md
01-product-intent-from-workflow-set.md
```

No dedicated workflow-set verification artifact template is required in the first version.

## Schema Documentation

Document the new optional journal fields:

- `kind`
- `title`
- `workflowSet.children`
- `workflowSet.children[].scaffold.state`
- `relationships.parents`
- `relationships.predecessors`
- `steps.01-product-intent.origin`

Also document compatibility:

```text
Missing kind means feature.
```

## User-Facing Help

Update `/sldd help` with a short section:

```text
For large ideas, SLDD may recommend workflow-set planning. A workflow-set decomposes a large idea into child workflows, but child workflows still run independently through normal SLDD gates.
```

## Rationale

The feature changes routing and workflow structure, so users need clear docs. But documentation should stay concise and reinforce the main guardrails rather than expose every internal detail.

## Refinement 42: Verification Scenarios For The SLDD Feature

Workflow decomposition should be verified with focused scenarios before being considered ready.

## Journal Contract Scenarios

- Given an existing workflow journal without `name` or `kind`, when `/sldd resume <workflow>` runs, then it is rejected as invalid.
- Given an existing feature workflow, when `/sldd status` runs, then it is listed as `feature` from explicit `kind`.
- Given an existing workflow, the agent must not rename or migrate it automatically.

## Recommendation Scenarios

- Given a small single-capability idea, the agent should not recommend workflow-set planning.
- Given a large multi-capability idea, the agent should recommend workflow-set planning before Step 01.
- Given an ambiguous idea, the agent should ask one clarifying question.
- Given the user rejects decomposition, the agent should continue with normal single-workflow SLDD.

## Workflow-Set Planning Scenarios

- Given the user chooses `write as draft`, the workflow-set journal is created with `01-workflow-set-plan` pending.
- Given the user chooses `write and mark complete`, the workflow-set journal is created with `01-workflow-set-plan` complete and `02-scaffold-children` pending.
- Given the user chooses `do not write files`, no workflow-set files are created.

## Scaffold Scenarios

- Given an approved workflow-set plan, when scaffold is approved, all proposed children are created.
- Each created child has `kind: "feature"`.
- Each created child has Step 01 `pending`.
- Each created child Step 01 has `origin.type: "workflow-set-scaffold"`.
- The parent child scaffold state becomes `created` only after the child journal exists.
- Given a name collision, scaffold stops and records `conflict` instead of overwriting.
- Given preflight validation fails, no children are created.

## Predecessor Gate Scenarios

- Given a child has a predecessor whose Step 06 is not complete, the child Step 01 cannot be approved.
- Given all predecessor Step 06 statuses are complete, the child Step 01 may be approved after user confirmation.
- Given a predecessor journal path is missing, the child Step 01 cannot be approved.

## Resume And Status Scenarios

- Given `/sldd resume <workflow-set>` and parent steps are pending, the agent resumes the parent workflow-set step.
- Given `/sldd resume <workflow-set>` and parent steps are complete, the agent lists children by reading child journals.
- Given multiple child workflows are pending, the agent does not auto-select one.
- Given `/sldd resume <feature>`, the agent uses normal feature workflow behavior.

## Non-Goals For Verification

The first version does not need to verify:

- Partial scaffold selection.
- Advanced readiness policies.
- Parent orchestration of child execution.
- Aliases unless implemented.
- Dedicated workflow-set verification artifacts.

## Rationale

These scenarios test the core safety properties: no accidental file generation, no gate bypass, no parent orchestration, and no breakage of existing workflows.

## Refinement 43: Implementation Sequence

To implement workflow decomposition safely, apply the change in small ordered commits or tasks.

## Suggested Sequence

1. Update SLDD routing to infer `kind: "feature"` when `kind` is missing.
2. Add `kind: "workflow-set"` recognition to status/resume routing.
3. Add the large-idea decomposition heuristic to the pre-Step 01 and exploration flow.
4. Add the `01-workflow-set-plan.md` template.
5. Add workflow-set journal creation with suffix naming default `-set`.
6. Add workflow-set parent step handling for `01-workflow-set-plan`.
7. Add scaffold preflight validation.
8. Add child scaffold generation with suffix naming default `-feature`.
9. Add child Step 01 predecessor gate enforcement.
10. Add workflow-set resume/status child overview as a read-only computed view.
11. Add `03-verify-workflow-set` consistency checks.
12. Update `/sldd help` and skill documentation.
13. Add verification scenarios/tests for compatibility, planning, scaffold, predecessor gates, and resume behavior.

## Implementation Guardrails

- Do not implement child execution orchestration.
- Do not persist child execution progress in parent journals.
- Do not introduce partial scaffold selection in the first version.
- Do not migrate existing workflows automatically.
- Do not add aliases unless needed during implementation.
- Do not add a dedicated workflow-set verification artifact yet.

## Recommended First Task

Start with journal routing compatibility:

```text
If kind is missing, treat the workflow as feature.
If kind is workflow-set, use workflow-set step routing.
```

This is the foundation for all later behavior and should be verifiable without creating scaffolded children.

## Definition Of Done For First Version

The first version is done when:

- Existing workflows still resume unchanged.
- A new workflow-set can be created with `01-workflow-set-plan.md`.
- An approved workflow-set can scaffold all proposed children.
- Scaffolded children have Step 01 pending and self-contained drafts.
- Child Step 01 approval is blocked until predecessors complete Step 06.
- `/sldd resume <workflow-set>` shows parent progress or child overview without selecting a child automatically.
- The documentation and help text explain the feature and guardrails.

## Refinement 44: Draft Skill Text

The following is a compact draft of the behavior that could be added to the SLDD skill instructions.

## Workflow Decomposition

Before starting Step 01 for a new request, evaluate whether the idea is too large for one workflow.

Recommend workflow-set planning when the request has multiple capabilities, clear dependencies, parallelizable workstreams, or would produce an oversized Step 01.

Do not force decomposition. If the user rejects decomposition, continue with the normal single-workflow SLDD flow.

If the user approves decomposition, create or resume a workflow with:

```json
{
  "kind": "workflow-set"
}
```

Existing journals without `name` or `kind` are invalid. A valid feature journal declares:

```json
{
  "name": "example-feature",
  "kind": "feature"
}
```

## Workflow-Set Steps

Workflow-set workflows use these steps:

```text
01-workflow-set-plan
02-scaffold-children
03-verify-workflow-set
```

Feature workflows continue using the normal SLDD steps:

```text
01-product-intent
99-codebase-context
02-high-level-design
03-low-level-design
04-tests-red
05-implementation-green
06-verification
```

## Workflow-Set Plan

The workflow-set plan is stored in:

```text
01-workflow-set-plan.md
```

It must include:

- The large idea.
- Source inputs.
- Why decomposition is recommended.
- Proposed child workflows.
- Child names, titles, kinds, and scopes.
- Predecessor relationships by child name.
- Scaffold policy.
- Approval status.

The first version uses all-or-nothing scaffold:

```text
If scaffold is approved, scaffold all proposed children.
If scaffold is not approved, scaffold none.
```

## Plan Materialization Modes

When presenting a workflow-set plan, ask how to handle it:

```text
1. Write it and mark it complete.
2. Write it as a draft and wait for review. (Recommended)
3. Do not write files yet.
```

Writing or completing the plan does not authorize child scaffolding unless the user explicitly approves scaffold.

## Child Scaffolding

When `02-scaffold-children` runs, create all proposed child workflows from the approved plan.

New workflow-set names use suffix `-set` by default.

New feature child names use suffix `-feature` by default.

Each child workflow gets:

```text
_spec-journal.json
01-product-intent-specification.md
```

Each child journal must set Step 01 to `pending` and include origin metadata:

```json
{
  "status": "pending",
  "artifact": "01-product-intent-specification.md",
  "origin": {
    "type": "workflow-set-scaffold",
    "journal": "../<workflow-set>/_spec-journal.json",
    "artifact": "../<workflow-set>/01-workflow-set-plan.md"
  }
}
```

Do not mark child Step 01 complete during scaffold.

## Predecessors

The workflow-set plan records predecessor relationships by name.

During scaffold, child journals receive concrete predecessor journal paths in `relationships.predecessors`.

Before approving a child Step 01, the child workflow must verify that every predecessor journal exists and has Step 06 verification complete.

If any predecessor is missing or incomplete, child Step 01 remains pending.

## Parent And Child Responsibilities

Workflow-set responsibilities:

- Plan decomposition.
- Store child names and predecessor relationships.
- Scaffold approved child drafts.
- Verify coordination consistency.

Child workflow responsibilities:

- Own Step 01 approval.
- Enforce predecessor completion.
- Continue through normal SLDD gates.

The workflow-set must not persist child execution progress or orchestrate child execution.

## Resume Behavior

`/sldd resume <name>` branches by `kind`.

For `kind: "feature"`, use normal feature workflow behavior.

For `kind: "workflow-set"`:

- If parent steps are pending, resume the next workflow-set step.
- If parent steps are complete, list child workflows by reading child journals.
- If multiple children are pending, do not auto-select a child.
- Ask the user to explicitly resume the child workflow they want.

## Scaffold States

The parent tracks only scaffold state:

```text
proposed
created
conflict
```

It does not track child Step status.

## Safety Rules

- Do not create workflow-set files without approval.
- Do not scaffold children without approval.
- Do not overwrite existing artifacts without approval.
- Stop on scaffold conflicts.
- Do not migrate or rename existing workflows automatically.
- Treat `kind` as source of truth; suffixes are naming conventions only.

## Refinement 45: Version Boundary

This refinement defines what belongs to the first workflow decomposition version and what is intentionally postponed.

## First Version Commitments

The first version should support:

- Large-idea decomposition recommendation.
- Workflow-set parent workflows with `kind: "workflow-set"`.
- Backward compatibility where missing `kind` means `feature`.
- Default suffix naming for new decomposition-created workflows: `-set` and `-feature`.
- `01-workflow-set-plan.md` creation.
- Plan materialization modes: write complete, write draft, or do not write.
- All-or-nothing child scaffold approval.
- Child workflow creation with Step 01 pending.
- `origin.type: "workflow-set-scaffold"` on scaffolded child Step 01.
- Predecessor names in the plan and predecessor journal paths in child journals.
- Child-owned predecessor gate requiring predecessor Step 06 complete.
- Workflow-set resume/status behavior that lists children read-only after parent completion.
- Scaffold states limited to `proposed`, `created`, and `conflict`.
- No dedicated workflow-set verification artifact.

## Explicitly Postponed

The following are out of scope for the first version:

- Partial scaffold selection.
- Advanced predecessor readiness policies weaker than Step 06 completion.
- Parent orchestration of child execution.
- Persisted child progress or readiness in the parent journal.
- Automatic migration of old journals.
- Automatic rename of existing workflows.
- Dedicated workflow-set verification report artifact.
- Rich dashboard UI or advanced aggregate reporting.
- Alias support unless an immediate lookup problem appears during implementation.
- Automatic regeneration of child Step 01 drafts without explicit user approval.

## Revisit Triggers

Postponed items should only be revisited when there is concrete usage pressure.

Examples:

- Add partial scaffold selection only if users repeatedly want to scaffold subsets from large plans.
- Add aliases only if suffix naming makes resume/status lookup awkward.
- Add a verification artifact only if journal notes and conversational output are insufficient for auditability.
- Add advanced readiness policies only if Step 06 predecessor completion proves too strict in real workflows.

## Rationale

This version boundary keeps the first implementation useful but bounded.

The first version proves the core model: detect large ideas, create a workflow-set, scaffold child drafts, and let children enforce their own gates.

## Refinement 46: Next Practical Steps

The refinement is now mature enough to become an implementation proposal for the SLDD skill.

## Recommended Next Actions

1. Create a formal SLDD change/workflow for adding workflow decomposition to the SLDD skill.
2. Use this refinement document as source input.
3. Convert the first-version scope into Step 01 product intent for the SLDD skill change.
4. Create high-level design for routing by `kind`, workflow-set steps, templates, and scaffold behavior.
5. Create low-level design for journal shape, validation rules, and resume/status routing.
6. Add tests or verification scenarios based on Refinement 42.
7. Implement in small increments following Refinement 43.

## Suggested Change Name

```text
add-workflow-decomposition-to-sldd
```

If suffix naming is used for this change itself, a feature workflow could be:

```text
add-workflow-decomposition-to-sldd-feature
```

## Source Artifacts

Use these files as source context:

```text
workflow-decomposition-refinement.md
add-workflow-decomposition-idea.md
add-workflow-decompose-sldd.md
```

## Recommended First Implementation Slice

Even though the first version includes scaffold, implementation should still be sliced:

1. Add `kind` compatibility and routing.
2. Add workflow-set plan creation.
3. Add scaffold generation.
4. Add child predecessor gate.
5. Add resume/status overview.
6. Add verification and docs.

## Final Position

The refined proposal is no longer an OpenAPI-specific generator.

It is a general SLDD capability:

> Detect large ideas and decompose them into workflow-set parent workflows and independently executable child workflows, while preserving SLDD gates and user approval.

## Refinement 47: Handoff Checklist

Use this checklist when resuming the work in another session or turning the refinement into implementation artifacts.

## Confirmed Model

- Workflow decomposition is general, not OpenAPI-specific.
- `workflow-set` is a normal workflow kind.
- Feature workflows remain normal workflows.
- Workflow-set parent plans and scaffolds; it does not execute children.
- Child workflows own their own SLDD gates.
- Child Step 01 approval requires all predecessor workflows to have Step 06 complete.
- Existing journals without `name` or `kind` are invalid.
- New decomposition-created names use suffixes by default: `-set` and `-feature`.
- Scaffold is all-or-nothing in the first version.
- Partial scaffold selection is postponed.

## Files To Create In The Skill Change

Likely new or updated skill files:

```text
steps/01-workflow-set-plan.md
steps/02-scaffold-children.md
steps/03-verify-workflow-set.md
templates/01-workflow-set-plan.md
templates/01-product-intent-from-workflow-set.md
```

Likely updated existing docs/files:

```text
SKILL.md
steps/00-navigation.md
steps/88-exploration.md
steps/01-product-intent.md
schema/_spec-journal.schema.json
```

Exact file names should be verified against the current SLDD skill structure before editing.

## Behaviors To Preserve

- Normal feature workflow routing must continue unchanged.
- Existing workflows must not be rewritten just to add `kind`.
- Existing workflows must not be renamed to add suffixes.
- Step 04/05 Red/Green evidence rules remain unchanged for feature workflows.
- Workflow-set verification does not replace child Step 06 verification.

## First Implementation Test Data

A small artificial idea can test the feature without using a full OpenAPI:

```text
Build a publishing product with authentication, article authoring, and comments.
```

Expected decomposition:

```text
publishing-product-set
auth-feature
article-authoring-feature
comments-feature
```

Expected predecessor chain:

```text
auth-feature -> article-authoring-feature -> comments-feature
```

This is simpler than the full RealWorld API and should be enough to test routing, scaffold, predecessor gates, and resume behavior.

## Handoff Summary

The next agent/session should not restart the design from scratch.

It should treat this document as the refined decision record and either:

1. Create a formal SLDD workflow for implementing the skill change.
2. Continue refining one of the remaining open questions.
3. Start implementation using the first-version boundary and checklist above.

## Refinement 48: Scope Clarification

This refinement is about improving the SLDD skill itself.

It is not about implementing the RealWorld API.

The RealWorld OpenAPI example was used only as a concrete scenario to discover and validate the need for workflow decomposition.

## Current Subject

The current subject is:

```text
Add workflow decomposition support to the SLDD skill.
```

This means adding support for:

- Detecting large ideas.
- Recommending workflow-set planning.
- Creating workflow-set parent workflows.
- Creating workflow-set plans.
- Scaffold child workflows as Step 01 pending drafts.
- Letting child workflows enforce predecessor completion before Step 01 approval.
- Preserving existing feature workflow behavior.

## Out Of Scope For This Refinement

The following are not the current target:

- Implementing the RealWorld API.
- Creating RealWorld feature workflows right now.
- Generating workflows specifically from OpenAPI.
- Designing RealWorld persistence, authentication, or endpoints.

Those may become later use cases or test examples, but they are not the subject of this SLDD skill improvement.

## Why This Matters

Keeping the scope clear prevents the design from drifting back into the original example.

The feature should remain general and useful for any large idea, not only API specifications.

## Refinement 49: Close Remaining Open Questions

The remaining open questions are closed for the first version as follows.

## Step Files Versus Routing Only

Decision:

```text
Workflow-set should have its own step files.
```

Add:

```text
steps/01-workflow-set-plan.md
steps/02-scaffold-children.md
steps/03-verify-workflow-set.md
```

Rationale:

- Keeps workflow-set behavior explicit.
- Matches the existing SLDD progressive-disclosure model.
- Avoids burying workflow-set behavior entirely in routing logic.

## Regeneration Default

Decision:

```text
Regeneration should default to side-by-side output when overwrite risk is unclear.
```

Default behavior:

- If the child Step 01 draft is clearly unchanged from scaffold and user approves replacement, overwrite is allowed.
- If the draft may have user edits or modification tracking is unavailable, create a side-by-side file.

Suggested side-by-side file:

```text
01-product-intent-specification.regenerated.md
```

Rationale:

- Avoids overwriting user edits.
- Still supports comparison and manual adoption.

## Aliases

Decision:

```text
Aliases are out of scope for the first version.
```

Rationale:

- Canonical `name` and journal path are sufficient for the first version.
- Suffix naming is default, so lookup should remain predictable.
- Aliases can be added later if suffixes make commands awkward.

## Workflow-Set Verification Artifact

Decision remains:

```text
No dedicated verification artifact in the first version.
```

`03-verify-workflow-set` updates journal state and reports results in the conversation.

## Partial Scaffold Selection

Decision remains:

```text
Out of scope for the first version.
```

Scaffold remains all-or-nothing.

## Advanced Readiness Policies

Decision remains:

```text
Out of scope for the first version.
```

Child Step 01 approval requires predecessor Step 06 completion.

## Result

There are no remaining design-blocking open questions for the first version.

The next refinement should consolidate final decisions and remove ambiguity from the working notes.

## Refinement 50: Final Decision Summary

This section is the current source of truth for the first version.

If earlier refinement notes conflict with this section, this section wins.

## Feature Scope

Add workflow decomposition support to the SLDD skill.

The feature is general and not OpenAPI-specific.

It lets the agent recommend decomposing large ideas into a workflow-set parent and independent child workflows.

## Workflow Kinds

Supported first-version kinds:

- `feature`
- `workflow-set`

Compatibility:

```text
Missing kind means feature.
```

## Workflow-Set Steps

Workflow-set steps:

```text
01-workflow-set-plan
02-scaffold-children
03-verify-workflow-set
```

Workflow-set step files should exist under `steps/`.

## Feature Steps

Feature workflows keep the existing SLDD flow:

```text
01-product-intent
99-codebase-context
02-high-level-design
03-low-level-design
04-tests-red
05-implementation-green
06-verification
```

## Naming

For new workflows created by decomposition:

- `-set` suffix for `workflow-set`
- `-feature` suffix for `feature`

Examples:

```text
publishing-product-set
auth-feature
article-authoring-feature
```

The `kind` field remains the source of truth.

Existing workflows are not renamed.

Aliases are not included in the first version.

## Workflow-Set Plan

The plan artifact is:

```text
01-workflow-set-plan.md
```

It combines intent and decomposition plan.

It should include:

- Large idea.
- Source inputs.
- Decomposition rationale.
- Proposed child workflows.
- Child names, titles, kinds, and scopes.
- Predecessor relationships by name.
- All-or-nothing scaffold policy.
- Approval status.

## Plan Materialization Modes

When presenting the plan, offer:

1. Write it and mark it complete.
2. Write it as a draft and wait for review.
3. Do not write files yet.

Writing or completing the plan does not approve child scaffold unless scaffold is explicitly approved.

## Scaffold Policy

First-version scaffold is all-or-nothing:

```text
If scaffold is approved, scaffold all proposed children in the approved plan.
If scaffold is not approved, scaffold none.
```

No partial selection field is included.

## Scaffold States

Parent scaffold states:

```text
proposed
created
conflict
```

These states describe materialization only, not child execution progress.

## Child Workflow Scaffold

Each scaffolded child gets:

```text
_spec-journal.json
01-product-intent-specification.md
```

Child Step 01 is always `pending` at scaffold time.

Child Step 01 includes:

```json
{
  "origin": {
    "type": "workflow-set-scaffold"
  }
}
```

The child Step 01 artifact must be self-contained and resumable.

## Predecessors

The workflow-set plan records predecessors by child name.

The scaffold operation writes predecessor journal paths into each child journal.

The child workflow enforces predecessor completion before Step 01 approval.

Rule:

```text
Child Step 01 cannot be marked complete until every predecessor workflow has Step 06 verification complete.
```

No advanced readiness policy is included in the first version.

## Parent Versus Child Responsibility

Workflow-set parent:

- detects/recommends decomposition;
- stores the plan;
- scaffolds children;
- verifies coordination consistency;
- does not execute children.

Child feature workflow:

- owns Step 01 approval;
- enforces predecessors;
- runs the normal SLDD flow;
- owns implementation and verification.

The parent must not persist child execution state.

## Resume And Status

`/sldd resume <name>` branches by `kind`.

For `feature`, preserve existing behavior.

For `workflow-set`:

- resume pending parent steps first;
- if parent is complete, list children by reading child journals;
- do not auto-select a child when multiple are pending.

Status output may compute a read-only child overview, but must not write child progress into the parent journal.

## Verification

`03-verify-workflow-set` has no dedicated artifact in the first version.

It checks coordination consistency, updates journal state, and reports results in conversation.

## Regeneration

Regenerating child Step 01 drafts requires explicit user approval.

When overwrite risk is unclear, default to side-by-side output:

```text
01-product-intent-specification.regenerated.md
```

## Explicitly Out Of Scope

- OpenAPI-specific generation.
- Partial scaffold selection.
- Aliases.
- Parent orchestration of child execution.
- Persisted child progress in the parent.
- Advanced readiness policies.
- Dedicated workflow-set verification artifact.
- Automatic migration or renaming of existing workflows.

## Refinement 51: Formal SLDD Change Plan

The next step is to turn this refinement into a normal SLDD workflow for changing the SLDD skill.

## Proposed Workflow Name

Use the default suffix convention for new feature workflows:

```text
add-workflow-decomposition-to-sldd-feature
```

## Workflow Kind

```text
feature
```

This is a feature workflow because it changes the SLDD skill behavior.

It is not a workflow-set itself.

## Source Inputs

Use these files as source input:

```text
workflow-decomposition-refinement.md
add-workflow-decomposition-idea.md
add-workflow-decompose-sldd.md
```

The primary source of truth is:

```text
workflow-decomposition-refinement.md#refinement-50-final-decision-summary
```

## Step 01 Product Intent Draft

The Step 01 intent for the SLDD skill change should say:

```text
Improve the SLDD skill so it can recommend and manage workflow decomposition for large ideas by creating workflow-set parent workflows and scaffolded child feature workflows, while preserving existing feature workflow behavior and SLDD gates.
```

## Step 01 Acceptance Criteria Draft

- Given an existing SLDD workflow journal without `name` or `kind`, when it is resumed, then it is rejected as invalid.
- Given a large multi-capability idea, when the agent evaluates it before Step 01, then it recommends workflow-set planning.
- Given the user rejects decomposition, then normal single-feature workflow behavior continues.
- Given the user approves workflow-set planning, then a `kind: "workflow-set"` parent workflow can be created.
- Given a workflow-set plan is presented, then the user can choose write complete, write draft, or do not write.
- Given a workflow-set plan is complete and scaffold is approved, then all proposed child workflows are scaffolded.
- Given a child workflow is scaffolded, then its Step 01 is `pending` and includes `origin.type: "workflow-set-scaffold"`.
- Given a child workflow has predecessors, then Step 01 approval is blocked until every predecessor has Step 06 complete.
- Given `/sldd resume <workflow-set>`, then parent steps are resumed first; after parent completion, children are listed from their journals without auto-selecting when multiple are pending.
- Given a scaffold conflict, then the agent records `conflict` and stops instead of overwriting.

## Step 02 Design Topics

High-level design should cover:

- Routing by `kind`.
- Backward compatibility for missing `kind`.
- Workflow-set step model.
- Template additions.
- Journal shape additions.
- Scaffold validation and atomicity.
- Child predecessor gate enforcement.
- Resume/status behavior.

## Step 03 Low-Level Design Topics

Low-level design should define:

- Exact journal fields.
- Exact step file contents.
- Exact template contents.
- Plan validation algorithm.
- Scaffold write order.
- Conflict handling.
- Predecessor completion check.
- Status/resume branching logic.

## Step 04 Test Topics

Tests or verification scenarios should cover Refinement 42, especially:

- Backward compatibility.
- Recommendation behavior.
- Plan materialization modes.
- Scaffold success.
- Scaffold conflict.
- Predecessor gate.
- Workflow-set resume/status.

## Implementation Guidance

Implementation should follow Refinement 43 sequence and preserve all guardrails from Refinement 50.

Do not implement postponed features in the first version.

## Refinement 52: Refinement Closure

The workflow decomposition idea has enough detail to proceed into a formal SLDD workflow.

Further discussion should avoid redesigning the core model unless new constraints appear.

## Closed Core Decisions

The following decisions are closed for the first version:

- Workflow decomposition is a general SLDD capability, not OpenAPI-specific.
- `workflow-set` is a normal workflow kind.
- Feature workflows remain independent and use the existing SLDD gates.
- Workflow-set parent has dedicated step files.
- Workflow-set parent plans and scaffolds, but does not execute children.
- Scaffold is all-or-nothing.
- Child Step 01 is pending after scaffold.
- Child workflows enforce predecessor Step 06 completion before Step 01 approval.
- Parent does not persist child execution progress.
- Existing workflows must declare required `name` and `kind` fields.
- Suffix naming is default for new decomposition-created workflows.

## Do Not Reopen Unless Needed

Do not reopen these topics unless implementation reveals a concrete problem:

- Partial scaffold selection.
- Advanced readiness policies.
- Parent orchestration.
- Aliases.
- Dedicated verification artifact.
- Automatic migration or rename.

## Next Recommended Action

Start the formal workflow:

```text
/sldd start add-workflow-decomposition-to-sldd-feature
```

Then create Step 01 using:

```text
workflow-decomposition-refinement.md#refinement-50-final-decision-summary
workflow-decomposition-refinement.md#refinement-51-formal-sldd-change-plan
```

## Final Note

This refinement document should now be treated as a decision record and source artifact, not as an implementation artifact.

## Approval Recording

When approval affects persisted state, record it in the relevant journal when possible.

Examples:

- Workflow-set plan approved.
- Child scaffold approved.
- Child Step 01 approved.
- Conflict resolution approved.

The journal should record the outcome, not the full conversation transcript.

## Rationale

Explicit checkpoints preserve SLDD's gated nature while still allowing efficient approval when the user is clear.
