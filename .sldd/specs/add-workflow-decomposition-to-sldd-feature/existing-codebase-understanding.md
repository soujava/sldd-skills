# Repository Structure Overview

This repository is a documentation- and skill-oriented project for the SLDD runtime skill.

Primary structure:

- `skills/sldd/SKILL.md`: the only executable SLDD skill entrypoint and workflow router.
- `skills/sldd/steps/`: step-specific behavior, gates, approval protocols, and save flows.
- `skills/sldd/templates/`: Markdown artifact formats produced by steps.
- `skills/sldd/schema/_spec-journal.schema.json`: canonical journal schema for new workflows.
- `README.md`: user-facing project and workflow documentation.
- `install-sldd-skills.sh`: local development installer for symlink or copy installation.
- `AGENTS.md`: repository-local contributor and agent instructions.
- `.sldd/specs/`: managed workflow artifacts for current SLDD changes.

# Architecture Summary

The SLDD skill uses a progressive-disclosure architecture:

- `SKILL.md` routes commands, validates gates, resolves journals, and maps steps to files and templates.
- Each step file under `steps/` owns one stage's objective, gate checks, output expectations, approval protocol, save behavior, and response format.
- Templates under `templates/` define artifact headings only; step files define behavior.
- `_spec-journal.json` is journal-only state and must not contain artifact bodies, command logs, or implementation reports.

The current workflow model is feature-oriented. It has a single gate order:

```text
Exploration -> Step 01 + Step 99 when needed -> Step 02 -> Step 03 -> Step 04 -> Step 05 -> Step 06
```

Step 99 is required for existing codebases before Step 02. Step 04 and Step 05 enforce the Red/Green contract through journal evidence values.

# Conventions to Preserve

- Keep `skills/sldd/SKILL.md` as the only executable SLDD skill entrypoint.
- Keep step behavior under `skills/sldd/steps/`.
- Keep artifact formats under `skills/sldd/templates/`.
- Keep journal schema files under `skills/sldd/schema/`.
- Preserve YAML frontmatter in `skills/sldd/SKILL.md`.
- Write instructions in plain, actionable Markdown.
- Preserve progressive disclosure: load only the relevant step and template when needed.
- Preserve `.sldd/specs/<feature-name>/_spec-journal.json` as canonical journal storage.
- Preserve legacy `docs/specs/<feature-name>/SPEC.md` resume compatibility.
- Preserve `/sldd help` as informational and non-mutating.
- Preserve the Step 88/Step 99 boundary.
- Preserve the Step 04/Step 05 Red-Green contract.
- Update `README.md` for user-visible workflow, command, journal, template, or gate changes.
- Do not add runtime application code, build scripts, package configuration, or CI/CD changes.
- Do not modify `LICENSE`.

# Integration Points

Files likely affected by this feature:

- `skills/sldd/SKILL.md`: route by workflow kind, document workflow-set behavior, update command/help behavior, and extend step/template maps.
- `skills/sldd/steps/00-navigation.md`: navigation/status/resume routing by `kind`, compatibility for missing `kind`, and workflow-set status behavior.
- `skills/sldd/steps/88-exploration.md`: large-idea recommendation before transition to workflow-set planning.
- `skills/sldd/steps/01-product-intent.md`: pre-Step 01 large-idea heuristic and child predecessor gate behavior for scaffolded children if implemented there.
- New workflow-set step files under `skills/sldd/steps/`:
  - `01-workflow-set-plan.md`
  - `02-scaffold-children.md`
  - `03-verify-workflow-set.md`
- New templates under `skills/sldd/templates/`:
  - `01-workflow-set-plan.md`
  - `01-product-intent-from-workflow-set.md`
- `skills/sldd/schema/_spec-journal.schema.json`: optional/additive fields for `kind`, workflow-set data, relationships, and scaffold origin metadata.
- `README.md`: user-facing explanation of workflow decomposition, storage, commands, and guardrails.

# Risks and Unknowns

- The current schema is strict and does not include `kind`, `title`, `workflowSet`, `relationships`, or step `origin`; schema evolution must be additive without breaking existing journals.
- Existing journal examples use numeric step keys, while refinement examples use semantic keys for workflow-set and child journals; Step 03 must settle the exact first-version representation.
- Workflow-set step routing must not break existing feature routing.
- Missing `kind` must be inferred as `feature` without rewriting old journals solely for migration.
- Child scaffolding can create many files, so approval and conflict handling must be explicit.
- Parent workflow-set state must not become a cached execution dashboard for child workflows.
- Documentation must stay concise even though the behavior is broader than the current linear workflow.

# Context to Carry Into Steps 02-06

- This change modifies SLDD skill instructions, templates, schema, and documentation only.
- The approved Step 01 scope is general workflow decomposition for SLDD, not OpenAPI-specific generation.
- First-version scope includes recommendation, workflow-set parent support, plan creation, all-or-nothing child scaffolding, child predecessor gates, and basic resume/status behavior.
- Out-of-scope items include partial scaffold selection, aliases, advanced readiness policies, parent orchestration, persisted child progress, automatic migration/rename, and dedicated workflow-set verification artifacts.
- The implementation should follow repository instructions and preserve the existing single-skill architecture.
