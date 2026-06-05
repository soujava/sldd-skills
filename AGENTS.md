# AGENTS.md

## Purpose

This repository contains the SLDD (Spec Loops Driven Development) skill: structured AI agent prompt files that enforce a gate-based, specs-driven workflow for disciplined AI-assisted development.

## Global Agent Behavior

### Do

- Keep `skills/sldd/SKILL.md` as the only executable SLDD skill entrypoint.
- Keep workflow behavior under `skills/sldd/workflows/`.
- Keep step behavior under `skills/sldd/steps/`.
- Keep artifact formats under `skills/sldd/templates/`.
- Keep journal schema files under `skills/sldd/schema/`.
- Preserve YAML frontmatter structure in `skills/sldd/SKILL.md` (`name`, `description`, `metadata.type`).
- Write skill and step content in plain, actionable Markdown. Document behavior, not implementation.
- Maintain consistency across all step files: tone, structure, gate enforcement patterns, approval protocol, and output format.
- Ensure every step has a clear objective, gate enforcement rules, approval protocol when applicable, save/progress behavior, and response format.
- Preserve progressive disclosure: `SKILL.md` routes and loads exactly the step file needed; templates are loaded only for produced Markdown artifacts.
- Preserve `.sldd/specs/<feature-name>/_spec-journal.json` as the canonical journal for new workflows.
- Preserve `name` and `kind` as required `_spec-journal.json` fields; journals without either field are invalid.
- Preserve `/sldd help` as an informational command that explains the skill and does not mutate journals, artifacts, or workflow state.
- Preserve `/sldd explore [idea]` as Step 88 exploration: establish lightweight project context first, inspect the repository instead of asking questions the codebase can answer, ask one focused clarification question at a time, include a recommended answer or default assumption, and offer explicit exits.
- Preserve Step 88 workflow-set recommendation behavior: recommend workflow-set planning for multiple capabilities, dependencies, parallel workstreams, or oversized Step 01 scope, but do not create workflow-set artifacts without explicit approval.
- Preserve the Step 88/Step 99 boundary: Step 88 repository observations are conversational context only; Step 99 is the approved and saved brownfield context gate for Step 02+.
- Preserve the Step 04/Step 05 Red-Green contract: Step 04 writes tests first only; Step 05 makes minimal production changes, does not modify Step 04 tests, and follows applicable repository or context-provided agent instructions.
- Preserve Step 04 and Step 05 as journal-evidence phases, not mandatory Markdown report artifact phases: Step 04 records `evidence: "red_confirmed"` and Step 05 records `evidence: "green_confirmed"` in `_spec-journal.json`.
- Preserve workflow-set parent sequencing: `01-workflow-set-plan -> 02-scaffold-children -> 03-verify-workflow-set`.
- Preserve workflow-set parent creation gates: new parent journals are created only through approved `01-workflow-set-plan`; existing journals without `name` or `kind` are invalid and are not routed automatically.
- Preserve workflow-set parent boundaries: parents plan and scaffold child workflows, but do not execute children, approve child Step 01, enforce child implementation gates, or persist child execution progress.
- Preserve workflow-set Step 03 behavior: verify coordination in the conversation and journal only; do not create a dedicated verification report artifact unless the workflow is explicitly changed.
- Preserve predecessor gates: when `relationships.predecessors` exists, Step 01 completion and Step 02+ routing are blocked until every listed predecessor journal has Step 06 complete.
- Preserve completed-step rerun choices: run again only, run again and mark later completed steps `requires_rerun`, or do nothing.
- Preserve workflow-set scaffold states: `proposed`, `created`, and `conflict`.
- Preserve journal schema concepts used by the current skill: `kind`, `current_step`, `relationships`, `workflowSet.children`, `origin.type`, `evidence`, `reason`, and `requires_rerun`.
- Preserve kind-specific journal step keys as step file basenames without `.md`; `kind: "feature"` journals may use only feature step basenames, and `kind: "workflow-set"` journals may use only workflow-set parent step basenames.
- Preserve `name` as the workflow/spec name field in `_spec-journal.json`; do not use or accept `feature` as a journal-name field.
- Preserve `workflowSet` as exclusive to `kind: "workflow-set"`; `kind: "feature"` journals must not include it.
- Update `README.md` when changing user-visible process behavior, sequencing, gates, approval semantics, commands, journal fields, storage, templates, installer options, or step responsibilities.
- Use Conventional Commits for commit messages, following the `<type>(optional-scope): <description>` format.

### Don't

- Do not add runtime application code, build scripts, package configuration, or CI/CD changes.
- Do not introduce conventions, frameworks, or patterns not already present in the SLDD skill architecture.
- Do not create additional executable SLDD skill entrypoints without explicit user instruction.
- Do not turn Step 88 exploration into Step 02/Step 03 design work or binding requirements before Step 01 approval.
- Do not treat Step 88 conversational context, repository observations, or `00-exploration-summary.md` as satisfying Step 99.
- Do not store numbered artifact body content, command logs, or implementation reports in `_spec-journal.json`.
- Do not persist child workflow execution progress into a workflow-set parent journal; compute child progress by reading child journals when needed.
- Do not infer child scaffolding approval from workflow-set plan approval.
- Do not auto-convert existing feature journals into workflow-set journals.
- Do not create legacy migration logic or a fallback that treats journals without `name` or `kind` as `feature`.
- Do not create legacy migration logic or a fallback that accepts both `feature` and `name` as journal fields.
- Do not treat accepted workflow-set scaffold conflicts as successful child creation.
- Do not modify `LICENSE` unless explicitly asked.

## Repository Content Policy

- This repository is documentation- and skill-oriented.
- Markdown files are allowed for skill instructions, steps, templates, repository documentation, and evaluations.
- JSON schema files are allowed under `skills/sldd/schema/`.
- Shell scripts already present for local skill installation may be maintained, but do not add new runtime scripts without explicit instruction.

## Agent Limits

- Scope is limited to authoring, editing, and reviewing skill instructions, step files, templates, JSON schema files, repository documentation, and existing installation documentation/scripts.
- No external API calls, no CI/CD changes, and no runtime application code.
- All changes must be consistent with the SLDD methodology and the current single-skill architecture.
