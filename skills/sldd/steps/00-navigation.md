# Step 00: Process Overview and Navigation

## Objective

Determine current state, block invalid jumps, and route to the correct next step.

## Artifact and Resume Rules

- Use user-provided paths when available.
- For new workflows, default to `.sldd/specs/<feature-name>/_spec-journal.json`.
- Treat `_spec-journal.json` as journal-only: progress, artifact links, evidence, and rerun notes only.
- Never write numbered step body content, logs, or reports into `_spec-journal.json`.
- Legacy `docs/specs/<feature-name>/SPEC.md` is readable for resume compatibility only.
- When resuming a legacy `SPEC.md`, continue in the legacy directory unless migration is explicitly requested.

Expected new-workflow artifacts:

- `00-exploration-summary.md` (optional contextual memory; not a progress artifact)
- `01-product-intent-specification.md`
- `99-existing-codebase-understanding.md` (optional persisted snapshot)
- `02-high-level-technical-design.md`
- `03-low-level-design-and-version-policy.md`
- Step 04 completion in `_spec-journal.json` with `evidence: "red_confirmed"`
- Step 05 completion in `_spec-journal.json` with `evidence: "green_confirmed"`
- `06-verification-and-feedback-report.md`

Approved numbered artifacts take precedence over `00-exploration-summary.md`.

## Start/Resume Flow

1. Parse natural-language intent or slash-style command.
2. Detect jump-ahead requests and stop if prerequisites are missing.
3. Resolve target journal:
   - user-provided path, or
   - `.sldd/specs/<feature-name>/_spec-journal.json`, or
   - legacy `docs/specs/<feature-name>/SPEC.md`.
4. Read journal state and validate referenced artifacts.
5. Detect out-of-order completions.
6. If the spec is still being clarified, route to Step 88.
7. For existing codebases, check whether Step 99 is required, complete, and still valid.
8. If any violation exists, stop and route to the missing step.
9. Route only to the next valid step file.

## Explicit Step Rerun Flow

When the command is `/sldd run <NN> <feature>`:

1. Treat it as an explicit rerun request, not normal next-step navigation.
2. Require both `<NN>` and `<feature>`. If either value is missing, malformed, or does not resolve to a supported step/workflow, stop and ask for correction.
3. Resolve the target workflow by checking `.sldd/specs/<feature>/_spec-journal.json` first, then legacy `docs/specs/<feature>/SPEC.md`.
4. Read journal state and validate all referenced artifacts before loading the target step.
5. Validate all prerequisites for the target step exactly as that step requires.
6. For existing codebases and target steps after Step 99, block rerun if Step 99 is required but missing, incomplete, stale, or scoped to a rejected direction.
7. For Step 04 and Step 05 reruns, re-evaluate current files and relevant test results before trusting journal evidence.
8. If prerequisite artifacts, journal order, Step 99 freshness, Step 04 evidence, or Step 05 evidence conflict, stop and report the conflict instead of loading the target step.
9. Load the requested step file, not the next automatic step.

After a successful rerun completes through the target step's normal approval or confirmation flow:

1. Mark the target step according to its normal save flow.
2. Mark later completed steps in gate order as `requires_rerun`.
3. Set each invalidated later step's `reason` to `Step <NN> was rerun; this later step must be reviewed again.`
4. Clear `evidence` when invalidating Step 04 or Step 05.
5. Keep existing `artifact` links as historical references.

## Interrupted Execution Resume

When resuming at Step 04 or Step 05:

1. Inspect `_spec-journal.json` or legacy `SPEC.md`.
2. Inspect current test and production file state.
3. Run or request the relevant test commands when the current Red/Green state cannot be trusted from files alone.
4. Re-evaluate Step 04 and Step 05 even if the journal marks them complete.
5. Treat Step 04 as complete only when Red is confirmed or later passing tests prove Step 05 has already advanced the workflow.
6. Treat Step 05 as complete only when relevant tests pass and Step 04 test integrity is preserved.
7. If checklist, files, and test results conflict, stop and ask for direction before updating progress.

## Approval Protocol

- This navigation step does not persist numbered artifacts.
- Before routing forward, ask for explicit confirmation to continue unless the user requested direct resume, continue, or rerun and the target step can execute without ambiguity.
- On pause or ambiguous confirmation, hold position and clarify instead of routing.

## Response Format

1. Resolved workflow and journal
2. Completed steps
3. Violations or conflicts, if any
4. Next required step + reason
5. Prompt for confirmation to continue when needed
