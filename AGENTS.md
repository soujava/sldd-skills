# AGENTS.md

## Purpose

This repository contains the SLDD (Spec Loops Driven Development) skill: structured AI agent prompt files that enforce a gate-based, specs-driven workflow for disciplined AI-assisted development.

## Global Agent Behavior

### Do

- Keep `skills/sldd/SKILL.md` as the only executable SLDD skill entrypoint.
- Keep step behavior under `skills/sldd/steps/`.
- Keep artifact formats under `skills/sldd/templates/`.
- Keep journal schema files under `skills/sldd/schema/`.
- Preserve YAML frontmatter structure in `skills/sldd/SKILL.md` (`name`, `description`, `metadata.type`).
- Write skill and step content in plain, actionable Markdown. Document behavior, not implementation.
- Maintain consistency across all step files: tone, structure, gate enforcement patterns, approval protocol, and output format.
- Ensure every step has a clear objective, gate enforcement rules, approval protocol when applicable, save/progress behavior, and response format.
- Preserve progressive disclosure: `SKILL.md` routes and loads exactly the step file needed; templates are loaded only for produced Markdown artifacts.
- Preserve `.sldd/specs/<feature-name>/_spec-journal.json` as the canonical journal for new workflows.
- Preserve legacy resume compatibility for `docs/specs/<feature-name>/SPEC.md` unless explicitly removed.
- Preserve `/sldd help` as an informational command that explains the skill and does not mutate journals, artifacts, or workflow state.
- Preserve the Step 04/Step 05 Red-Green contract: Step 04 writes tests first only; Step 05 makes minimal production changes, does not modify Step 04 tests, and follows applicable repository or context-provided agent instructions.
- Update `README.md` when changing user-visible process behavior, sequencing, gates, approval semantics, commands, journal fields, storage, templates, installer options, or step responsibilities.
- Use Conventional Commits for commit messages, following the `<type>(optional-scope): <description>` format.

### Don't

- Do not add runtime application code, build scripts, package configuration, or CI/CD changes.
- Do not introduce conventions, frameworks, or patterns not already present in the SLDD skill architecture.
- Do not create additional executable SLDD skill entrypoints without explicit user instruction.
- Do not store numbered artifact body content, command logs, or implementation reports in `_spec-journal.json`.
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
