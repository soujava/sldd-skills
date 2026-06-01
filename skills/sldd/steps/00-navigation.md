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
- `existing-codebase-understanding.md` (required persisted snapshot for brownfield Step 02+ gates)
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

## Specific Step Run Flow

When the command is `/sldd run step <NN> <feature>`, `/sldd run step <NN>`, or the `/sldd step <NN>` alias:

1. Treat it as a gated targeted step request.
2. Require `<NN>`. If the value is missing, malformed, or does not resolve to a supported step, stop and ask for correction.
3. Resolve the target workflow from the feature argument, user input, current context, or the only active workflow. If multiple workflows are possible, stop and ask the user to choose.
4. Read journal state and validate all referenced artifacts before loading the target step.
5. Validate all prerequisites for the requested step exactly as that step requires.
6. For existing codebases and requested steps after Step 99, block the request if Step 99 is required but missing, incomplete, stale, or scoped to a rejected direction.
7. For Step 04 and Step 05 requests, re-evaluate current files and relevant test results before trusting journal evidence.
8. If prerequisite artifacts, journal order, Step 99 freshness, Step 04 evidence, or Step 05 evidence conflict, stop and report the conflict instead of loading the requested step.
9. If prerequisites are missing or stale, route to the missing prerequisite instead of loading the requested step.
10. If the target step is `pending`, load the requested step file only when its gates are satisfied.
11. If the target step is `requires_rerun`, load the requested step file only when its gates are satisfied. After it completes through its normal approval or confirmation flow, mark later completed steps in gate order as `requires_rerun`.

If the target step is already `complete`, stop before loading the step and ask:

```text
Step <NN> is already complete.

1. Run it again only.
   Risk: later completed steps will not be marked requires_rerun. Use this only when you accept downstream consistency risk.

2. Run it again and mark later completed steps as requires_rerun.

3. Do nothing.
```

After the user chooses:

1. For option 1, run the step only after explicit confirmation. Do not automatically invalidate later completed steps. If the target step artifact, files, or journal entry changes, add a journal-only note: `Step <NN> was run again without downstream invalidation by explicit user choice.`
2. For option 2, run the step only after explicit confirmation. After the target step completes through its normal approval or confirmation flow, mark later completed steps in gate order as `requires_rerun`.
3. For each invalidated later step, set `reason` to `Step <NN> was run again; this later step must be reviewed again.`
4. When invalidating Step 04 or Step 05, clear `evidence`; keep any existing `artifact` link as a historical reference.
5. For option 3, do not load the step, write artifacts, run commands, or update the journal.

All completed-step choices remain subject to the target step's gate checks, approval protocol, save flow, and hard Red/Green contracts.

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
- Before routing forward, ask for explicit confirmation to continue unless the user requested direct resume, continue, or a targeted step run and the target step can execute without ambiguity.
- On pause or ambiguous confirmation, hold position and clarify instead of routing.

## Response Format

1. Resolved workflow and journal
2. Completed steps
3. Violations or conflicts, if any
4. Next required step + reason
5. Prompt for confirmation to continue when needed
