# Step 01: Workflow-Set Plan

## Objective

Create or revise the parent workflow-set plan for a large idea that should be decomposed into independent child workflows.

## Gate + Resume Checks

- Allow this step to save or update a reviewable workflow-set plan draft before gate approval.
- If no parent journal exists, save the draft artifact only; do not create `_spec-journal.json` until the current plan draft is explicitly approved.
- If a parent journal exists, require `name` and `kind: "workflow-set"`.
- If an existing journal has no `name` or `kind`, stop and report it as invalid.
- If an existing journal has top-level `feature`, stop and report it as invalid.
- If an existing journal has `kind: "feature"`, stop and ask whether the user wants a different workflow-set name.
- If an existing journal has an unknown `kind`, stop and ask for correction.
- Do not create child workflows in this step.
- If the idea fits one feature workflow, recommend the normal Step 01 flow instead.

## Draft Output

Load `templates/01-workflow-set-plan.md` before drafting the artifact.

The plan must include the large idea, source inputs, decomposition rationale, proposed child workflows, child names, titles, kinds, scopes, predecessor relationships by name, all-or-nothing scaffold policy, and approval status.

## Draft Materialization

Save or update the plan as a reviewable draft unless the user explicitly requests no file writes. Draft materialization creates review state only:

1. Write or update `01-workflow-set-plan.md`.
2. If a valid parent journal already exists, update it with `01-workflow-set-plan` still `pending`.
3. If no parent journal exists, leave `_spec-journal.json` absent until explicit plan approval.
4. Preserve proposed child workflows in the draft artifact; persist them to `workflowSet.children` only when a valid parent journal exists or when explicit plan approval creates the parent journal.
5. Ask for explicit plan approval, revisions, scaffold approval after plan completion, or hold.

Writing the draft does not approve the plan, does not create a new parent journal, and does not approve child scaffolding. Scaffold approval never substitutes for completing the plan; Step 02 may run only after `01-workflow-set-plan` is complete and scaffold approval is explicit.

## Approval Protocol

- Save or update `01-workflow-set-plan.md` as a reviewable draft before gate approval.
- When a valid parent journal exists, draft persistence must keep `01-workflow-set-plan` as `pending` in `_spec-journal.json`, preserve the artifact link, and set `reason` to `draft pending explicit approval` or an equivalent review reason.
- When no parent journal exists, draft persistence must not create `_spec-journal.json`; approval of the current draft is the trigger for parent journal creation.
- The existence of `01-workflow-set-plan.md` does not satisfy the workflow-set plan gate.
- On rejection, requested changes, hold, or ambiguous approval, update the draft when needed, keep the plan pending, and do not route to Step 02.
- Only explicit approval of the current draft may mark the plan complete.
- Do not infer approval to scaffold children from approval to draft or complete the plan.
- If the user approves scaffold while the plan is still pending, ask whether to approve the current plan draft first and keep Step 02 blocked until that completion is saved.
- If writes are unavailable, stop and report the limitation.

## Draft Save Flow

1. Create or update `.sldd/specs/<workflow-set-name>/01-workflow-set-plan.md`.
2. If a valid parent journal exists, keep `01-workflow-set-plan` pending, preserve the artifact link, update `workflowSet.children` from the draft, and set `reason` to `draft pending explicit approval`.
3. If no parent journal exists, do not create `_spec-journal.json` during draft save; report the draft path and state that the parent journal will be created only after explicit plan approval.
4. For explicit no-write mode, do not create or update files.
5. Ask whether to approve the current plan draft, revise it, approve scaffold after plan completion, or hold.

## Gate Approval Flow

1. On explicit approval of the current plan draft, create or update `_spec-journal.json` with `name`, `workflow: "sldd"`, and `kind: "workflow-set"`.
2. When creating a new parent journal, initialize it with:
   - `schema_version: 1`
   - `name: "<workflow-set-name>"`
   - `workflow: "sldd"`
   - `kind: "workflow-set"`
   - `steps["01-workflow-set-plan"].status: "complete"`
   - `steps["01-workflow-set-plan"].artifact: "01-workflow-set-plan.md"`
   - `steps["02-scaffold-children"].status: "pending"`
   - `steps["03-verify-workflow-set"].status: "pending"`
   - `workflowSet.children` from the approved plan, with scaffold state `proposed`
3. For existing parent journals, mark `01-workflow-set-plan` complete with the artifact link and update `workflowSet.children` from the approved plan.
4. Keep `02-scaffold-children` pending.
5. Do not create child workflows in this step.
6. Ask whether to continue to Step 02, separately approve scaffold, revise, or hold.

## Response Format

1. Gate and resume check result
2. Saved draft summary with required workflow-set plan headings
3. Pending journal update and explicit plan approval request
4. Separate scaffold approval reminder and continue/revise/hold prompt
