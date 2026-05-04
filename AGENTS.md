# AGENTS.md

## Purpose

This repository contains the SLDD (Spec Loops Driven Development) skills — structured AI agent prompt files that enforce a gate-based, specs-driven workflow for disciplined AI-assisted development.

## Global Agent Behavior

### Do
- Keep all `SKILL.md` files in their designated directories under `skills/`, following the naming pattern `sldd-NN-<kebab-description>/`.
- Preserve YAML frontmatter structure (`name`, `description`, `metadata.step`, `metadata.type`) when editing skills.
- Write skill content in plain, actionable Markdown. Document behavior, not implementation.
- Maintain consistency across all skill files (tone, structure, gate enforcement patterns).
- Ensure every skill has: a clear objective, gate enforcement rules, approval protocol, and output format.
- Preserve the Step 04/Step 05 Red-Green contract: Step 04 writes tests first only; Step 05 makes minimal production changes, does not modify Step 04 tests, and follows applicable repository or context-provided agent instructions.
- Update `README.md` when changing user-visible process behavior, sequencing, gates, approval semantics, or skill responsibilities.
- Use Conventional Commits for commit messages, following the `<type>(optional-scope): <description>` format.

### Don't
- Do not add runtime code, build scripts, or package configuration — this repo is Markdown-only.
- Do not introduce conventions, frameworks, or patterns not already present in the existing skills.
- Do not create new skill files without explicit user instruction.
- Do not modify `README.md` or `LICENSE` unless explicitly asked.

## Agent Limits

- Scope is limited to authoring, editing, and reviewing `SKILL.md` files and repository documentation.
- No code execution, no external API calls, no CI/CD changes.
- All changes must be consistent with the SLDD methodology and the existing skill set.
