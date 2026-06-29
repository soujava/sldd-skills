# Step 03: Low-Level Design and Version Policy

## Objective

Produce approved low-level design and version policy aligned to Step 02, tracing Step 01 requirements and Step 02 decisions to contracts, data models, errors, tests, dependencies, and implementation order.

## Gate + Resume Checks

- Require Step 01 and Step 02 complete.
- For existing codebases, require Step 99 complete and current.
- Reject implementation/test generation at this step.
- Reject inconsistent journal states.

## Draft Output

Load `templates/03-low-level-design-and-version-policy.md` before drafting the artifact.

Use `00-exploration-summary.md` only as non-binding context for rationale, alternatives, assumptions, and candidate technical ideas. Approved numbered artifacts override it.

Map Step 01 requirements and Step 02 design choices into concrete low-level decisions and an ordered implementation plan.

The draft must explicitly state:

- how each approved requirement is covered by API contracts, data models, error handling, tests, or implementation steps
- which Step 02 design decisions constrain Step 04 tests and Step 05 implementation
- whether the current dependency set is sufficient
- which new dependencies are required, if any
- why each dependency is needed
- version pinning or compatibility constraints for each new dependency
- the impact on runtime behavior, tests, and maintenance

The draft must include a dedicated `Mandatory Architecture Decisions` section. For every approved architecture decision that constrains Step 04, Step 05, or Step 06, record:

- Decision ID
- decision summary
- source requirement or Step 02 decision
- required implementation mechanism
- required dependency or runtime capability, if any
- expected files, layers, or components affected
- test or verification strategy
- whether fallback, stub, in-memory, demo-only, or degraded substitution is allowed
- blocking behavior when the required mechanism cannot be implemented or tested

Classify each decision as `mandatory`, `optional`, `deferred`, or `prohibited`. Decisions classified as `mandatory` are Step 05 blockers: Step 05 must not mark `green_confirmed` if any mandatory decision is absent, substituted, or implemented with an unapproved fallback. Decisions classified as `prohibited` must not appear in Step 05 production code unless Step 03 is rerun and explicitly changes that classification.

Save the draft for review, keep the step pending, then wait for explicit approval.

## Approval Protocol

- Save or update the Step 03 artifact as a reviewable draft before gate approval.
- Draft persistence must keep `03-low-level-design` as `pending` in `_spec-journal.json`, preserve the artifact link, and set `reason` to `draft pending explicit approval` or an equivalent review reason.
- The existence of `03-low-level-design-and-version-policy.md` does not satisfy the Step 03 gate.
- On rejection, requested changes, hold, or ambiguous approval, update the draft when needed, keep the step pending, and do not route to Step 04+.
- Only explicit approval of the current draft may mark Step 03 complete.
- If writes are unavailable, stop and report the limitation.

## Draft Save Flow

1. Save only Step 03 content to the resolved workflow directory as `03-low-level-design-and-version-policy.md`; for new workflows, this is `.sldd/specs/<feature-name>/03-low-level-design-and-version-policy.md`.
2. Update journal-only `_spec-journal.json` with `steps["03-low-level-design"].status: "pending"`, the artifact link, and `reason: "draft pending explicit approval"`.
3. Ask for explicit approval, revision requests, or hold.

## Gate Approval Flow

1. On explicit approval of the current draft, mark `03-low-level-design` as `complete` in journal-only `_spec-journal.json` with the artifact link.
2. Ask whether to continue to the next step or hold.

For legacy or user-provided workflow paths, save the draft and update progress in the resolved directory instead.

## Response Format

1. Gate and resume check result
2. Saved draft summary with required Step 03 headings
3. Pending journal update and explicit approval request
4. Continue/hold prompt after approval, or revision/hold prompt while pending
