# SLDD Skill - Spec Loops Driven Development

A runtime skill for implementing **Spec Loops Driven Development (SLDD)**, a specs-driven feedback loop for disciplined AI-assisted development.

SLDD adds engineering control around AI-assisted coding so teams can keep speed without sacrificing quality.

## Based On

This work is based on the article **["Vibe Coding, But Production-Ready: A Specs-Driven Feedback Loop for AI-Assisted Development"](https://loiane.com/2026/03/vibe-coding-with-specs-driven-feedback-loops/)** by [Loiane Groner](https://loiane.com/).

> **The goal is not to stop vibe coding. The goal is to add engineering control around vibe coding so we can keep speed without sacrificing quality.**
>
> - Loiane Groner

## What Problem Does SLDD Solve?

When using AI for code generation, teams often face:

- **Version drift**: AI selects framework versions that do not align with team policy.
- **Missing non-functional requirements**: Security, observability, and maintainability are discovered too late.
- **Diluted product intent**: Implementation starts before design is clear.
- **Architecture confusion**: Plausible code is mistaken for valid architecture.

SLDD provides a structured feedback loop that prevents these issues while maintaining development velocity.

## Installation

### Using Skills CLI

Install the SLDD runtime skill with:

```bash
npx skills add soujava/sldd-skills
```

### Manual Installation

#### Claude Code

```bash
git clone https://github.com/soujava/sldd-skills.git
cp -r sldd-skills/skills/sldd ~/.claude/skills/
```

#### OpenCode

```bash
git clone https://github.com/soujava/sldd-skills.git
cp -r sldd-skills/skills/sldd ~/.agents/skills/
```

### Development Installation

During local development, install the `sldd` skill as a symbolic link:

```bash
./install-sldd-skills.sh
```

To install the symlink into a different skills directory, pass `--target`:

```bash
./install-sldd-skills.sh --target ~/.claude/skills
```

To install a copy instead of a symbolic link, pass `--copy`:

```bash
./install-sldd-skills.sh --copy
```

Copied files do not reflect later repository edits until the script is run again.

The script:

- uses `skills/sldd` as the source skill;
- uses `$HOME/.agents/skills` as the default target;
- accepts `--target <skills-dir>` for a custom target directory;
- accepts `--copy` to copy skill files instead of creating a symbolic link;
- creates the selected target directory if it does not exist;
- removes previous `sldd` and legacy `sldd-*` entries from the selected target directory;
- creates one symbolic link or copied directory at `<target>/sldd`;
- prints a summary of removed entries and created links or copies.

After changing the skill, reload or restart the CLI/tool that consumes skills so it refreshes loaded instructions.

## Skill Architecture

SLDD is distributed as one executable skill:

```text
skills/sldd/
  SKILL.md
  steps/
  templates/
  schema/
```

`SKILL.md` is the workflow router. It resolves the current SLDD workflow, validates gates, interprets natural language or slash-style commands, and loads only the step file needed for the next action.

The skill uses progressive disclosure:

- `SKILL.md` contains global routing, storage, journal, and gate rules.
- `steps/` contains step-specific behavior, gates, approval protocol, save flow, and response format.
- `templates/` contains Markdown artifact formats.
- `schema/` contains the `_spec-journal.json` contract.

## Managed Spec Storage

New SLDD workflows store versioned artifacts under:

```text
.sldd/specs/<feature-name>/
  _spec-journal.json
  00-exploration-summary.md
  01-product-intent-specification.md
  02-high-level-technical-design.md
  03-low-level-design-and-version-policy.md
  06-verification-and-feedback-report.md
  existing-codebase-understanding.md
```

`.sldd/specs` is intended to be committed to Git and reviewed with the code changes it governs.

`_spec-journal.json` is the canonical progress journal for new workflows. It records only workflow state, artifact links, evidence, and rerun notes. It must not contain step body content, command logs, or implementation reports.

Allowed journal statuses:

- `pending`
- `complete`
- `requires_rerun`

Step 04 uses `status: "complete"` with `evidence: "red_confirmed"`.
Step 05 uses `status: "complete"` with `evidence: "green_confirmed"`.
When Step 04 or Step 05 is not complete, `evidence` must be omitted or `null`.
Step 99 uses `status: "complete"` only when `existing-codebase-understanding.md` is approved and saved.

Legacy workflows using `docs/specs/<feature-name>/SPEC.md` remain readable for resume compatibility. When the skill resumes a legacy workflow, it keeps writing in that legacy directory unless the user explicitly asks to migrate.

## The Process Flow

Use `/sldd` to start, inspect, or resume the workflow. The skill routes to the next valid step after checking the journal and prerequisites.

```text
+----------------------------------------------------------------+
| SLDD Process Flow                                              |
+----------------------------------------------------------------+
|                                                                |
| Optional Step 88: Exploration                                  |
| Clarify a rough idea before formal Step 01                     |
|                                                                |
|                              v                                 |
| Step 00: Navigation                                            |
| Resolve journal, validate state, and route                     |
|                                                                |
|                              v                                 |
| Step 01: Product Intent                                        |
| Define problem, users, metrics, risks, and acceptance criteria |
|                                                                |
|                              v                                 |
| Optional Step 99: Existing Codebase Understanding              |
| Required for existing codebases before Step 02                 |
|                                                                |
|                              v                                 |
| Step 02: High-Level Technical Design                           |
| Architecture, system boundaries, and data flow                 |
|                                                                |
|                              v                                 |
| Step 03: Low-Level Design and Version Policy                   |
| API contracts, data models, tests, dependencies, and versions  |
|                                                                |
|                              v                                 |
|                     GATE: Design Review                        |
|                                                                |
|                              v                                 |
| Step 04: Tests-First Red Phase                                 |
| Write tests only and prove expected failure                    |
|                                                                |
|                              v                                 |
| Step 05: Minimal Green Implementation                          |
| Minimal production changes to pass Step 04 tests               |
|                                                                |
|                              v                                 |
| Step 06: Verification                                          |
| Audit implementation and make Go/No-Go decision                |
|                                                                |
|                              v                                 |
| Production Ready                                               |
|                                                                |
+----------------------------------------------------------------+
```

### Gate Rule

**No implementation before intent and design are reviewed and approved.**

Step 04 must stay Red-only. Step 05 must implement only the minimum production changes required to pass Step 04 tests, must not modify Step 04 tests, and must inspect and follow applicable repository or context-provided agent instructions.

If a gap appears at any step, loop back to the earlier step and revise.

## Steps Included

| Step | File | Description |
|---|---|---|
| 88 | `steps/88-exploration.md` | Clarify rough ideas before formal Step 01 |
| 00 | `steps/00-navigation.md` | Resolve journal state and route to the next valid step |
| 01 | `steps/01-product-intent.md` | Define product intent and acceptance criteria |
| 99 | `steps/99-codebase-context.md` | Capture existing-codebase context for brownfield work |
| 02 | `steps/02-high-level-design.md` | Define architecture, responsibilities, data flow, and test map |
| 03 | `steps/03-low-level-design.md` | Define contracts, models, error model, tests, dependencies, and version policy |
| 04 | `steps/04-tests-red.md` | Write tests first and confirm Red |
| 05 | `steps/05-implementation-green.md` | Implement minimal production changes and confirm Green |
| 06 | `steps/06-verification.md` | Audit compliance and produce Go/No-Go decision |

## Commands

When slash-style commands are passed to the skill as text, the `sldd` skill interprets them as workflow commands:

```text
/sldd
/sldd help
/sldd status
/sldd start <feature>
/sldd resume <feature>
/sldd resume
/sldd continue
/sldd run step <NN> <feature>
/sldd run step <NN>
/sldd step <NN>
/sldd explore
```

Slash commands are convenience syntax only. They do not bypass gates. For example, `/sldd run step 05 user-auth`, `/sldd run step 05`, and `/sldd step 05` still require Step 01, Step 02, Step 03, and Step 04 Red confirmation.

`/sldd run step <NN> <feature>` requests a specific step for a specific workflow. `/sldd run step <NN>` is allowed when the workflow can be resolved unambiguously. `/sldd step <NN>` is an alias for the same behavior.

When the requested step is already complete, the skill stops before loading the step and asks whether to run it again only, run it again and mark later completed steps as `requires_rerun`, or do nothing. The run-again-only option is an explicit user override and records a journal-only note if the target step changes without downstream invalidation.

All choices still enforce the target step's gates, approval protocol, save flow, and Red/Green contracts.

`/sldd help` is informational only. It explains the skill, the gated flow, `.sldd/specs` storage, `_spec-journal.json`, legacy `SPEC.md` resume compatibility, and available commands without creating or changing workflow state.

## Usage

### Starting a New Feature

```text
/sldd start user-auth

Feature idea: Build a user authentication system with email/password and OAuth providers.
```

The skill creates or resolves `.sldd/specs/user-auth/_spec-journal.json`, loads the next required step, and asks for the approvals required by that step.

### Getting Help

```text
/sldd help
```

The skill explains the SLDD workflow and command interface without loading a step or mutating any journal.

### Resuming Work

```text
/sldd resume user-auth
```

The skill reads `_spec-journal.json`, verifies referenced artifacts, re-checks Step 04/05 operational state when relevant, and loads only the next valid step file.

### Requesting a Specific Step

```text
/sldd run step 04 user-auth
```

The skill validates all prerequisites before loading Step 04. If prerequisites are missing, it blocks and routes to the required earlier step. `/sldd run step 04` and `/sldd step 04` are accepted when the workflow can be resolved unambiguously.

If Step 04 is already complete, the skill asks whether to run it again only, run it again and invalidate later completed steps, or do nothing.

### Existing Codebases

For brownfield work, Step 99 is required before Step 02. Step 99 may run during exploration when codebase understanding is needed to clarify scope, constraints, risks, or alternatives.

A Step 99 completed during exploration can be reused later only after the skill validates that its saved artifact still reflects the current codebase and remains relevant to the approved Step 01 scope.

Conversational or unsaved codebase context does not satisfy the Step 99 brownfield gate. To proceed to Step 02+, Step 99 must be approved, saved as `existing-codebase-understanding.md`, and marked `complete` in `_spec-journal.json`.

### Greenfield Projects

Skip Step 99 and proceed from Step 01 to Step 02.

## Key Principles

### 1. Vibe Coding + Specs-Driven = Production Ready

- **Vibe coding**: useful for discovery and fast prototypes.
- **Specs-driven**: essential for production decisions.
- **The winning model**: both, in sequence.

### 2. Decision Framework

| Context | Approach |
|---|---|
| Early discovery | Vibe coding first |
| User-facing in production | Specs-driven loop first |
| Migration or platform work | Include explicit version checks |

### 3. The Engineer's Role

The role shifts from writing every line to orchestrating and validating:

- Define intent and constraints.
- Review architecture decisions.
- Verify correctness.
- Own what gets committed.

### 4. TDD Throughout

Tests are written before implementation:

- Unit tests for logic.
- Integration tests for data boundaries.
- E2E tests for user-visible flows.

## Benefits

| Before SLDD | After SLDD |
|---|---|
| Version drift discovered late | Version policy enforced upfront |
| Missing non-functional requirements | Security and observability designed in |
| Scope creep from unclear acceptance criteria | Explicit Given/When/Then criteria |
| Expensive rework after release | Gaps caught during design |
| Unreliable estimates | Structured decomposition enables accurate estimates |

## Team Working Agreement

1. No implementation prompts before intent and design are approved.
2. Every AI-generated project includes a version validation step.
3. Architecture changes during coding require a design delta note.
4. PRs include a spec compliance checklist.
5. Release readiness requires explicit support-lifecycle verification.

## Maintenance Rules

- Keep `skills/sldd/SKILL.md` as the only executable SLDD skill entrypoint.
- Keep step behavior in `skills/sldd/steps/`.
- Keep artifact formats in `skills/sldd/templates/`.
- Keep `_spec-journal.json` structure in `skills/sldd/schema/`.
- If SLDD process behavior, sequencing, gates, approval semantics, commands, journal fields, storage, templates, installer options, or step responsibilities change, update this README in the same change.
- Preserve Step 04 Red-only and Step 05 Green-only contracts.
- Preserve legacy `docs/specs/<feature-name>/SPEC.md` resume compatibility until explicitly removed.

## Further Reading

- [Vibe Coding, But Production-Ready - Original Article by Loiane Groner](https://loiane.com/2026/03/vibe-coding-with-specs-driven-feedback-loops/)

## AI Tools Skills Documentation

- [Claude Code - Custom Instructions](https://docs.anthropic.com/en/docs/claude-code/tutorials#custom-instructions)
- [OpenCode - Skills System](https://opencode.ai/docs/skills)
- [Cursor - Rules for AI](https://docs.cursor.com/context/rules-for-ai)
- [GitHub Copilot - Custom Instructions](https://docs.github.com/en/copilot/customizing-copilot/adding-custom-instructions)

## License

The SLDD methodology and original article content are by Loiane Groner, licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).

This skills implementation is provided for community use.

## Contributing

Contributions are welcome. Please submit issues or pull requests to improve the skill, templates, schema, examples, or documentation.

## Acknowledgments

- Loiane Groner for creating and sharing the SLDD methodology.
- The broader AI-assisted development community for advancing responsible AI coding practices.
