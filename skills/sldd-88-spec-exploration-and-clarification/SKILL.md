---
name: sldd-88-spec-exploration-and-clarification
description: Explore and clarify a new SLDD spec with the user before Step 01. Use when the user has a fresh idea, wants to shape requirements, scope, risks, success criteria, or wants to think through a new SLDD workflow before writing the product intent spec.
metadata:
  step: "88"
  type: navigation
---

# Skill: Spec Exploration and Clarification

## Objective

Help the user turn a rough idea into a clear, testable spec direction before formal SLDD Step 01 starts.

## Gate/Route Rules

- Keep exploration pre-Step-01 unless the user explicitly asks to formalize.
- Route to Step 01 when the idea is sufficiently clear.
- For existing codebases, remind that Step 99 is required before Step 02 design work.
- Use user-provided paths when available; otherwise default optional summaries to `docs/specs/<feature-name>/00-exploration-summary.md`.
- Do not update `SPEC.md` progress for exploration summaries.
- Treat `00-exploration-summary.md` as contextual memory only, not a numbered progress artifact.

## Stance

- Explore first, formalize later.
- Ask questions that clarify the problem, not just the solution.
- Keep the conversation grounded in the actual repo and workflow when relevant.
- Surface trade-offs, risks, and unknowns instead of forcing a premature decision.
- Use ASCII diagrams, comparison tables, and simple flow sketches when they make the shape of the problem easier to see.

## When to Use

Use this skill when the user:

- Has a new feature idea and is not ready to write Step 01 yet.
- Wants help clarifying requirements, boundaries, constraints, or success criteria.
- Wants to compare possible spec directions before committing.
- Wants to explore how a new SLDD workflow should begin.
- Wants to reason about a spec in relation to an existing codebase and may need Step 99 later.

## Exploration Flow

1. Restate the idea in your own words.
2. Identify what is known, what is assumed, and what is missing.
3. Ask a small number of high-value questions.
4. Map the important constraints, users, and outcomes.
5. Compare candidate directions if more than one exists.
6. Call out risks, edge cases, and likely follow-up questions.
7. Decide whether the idea is ready for `sldd-01-product-intent-specification` or needs more exploration.

## Ground Rules

- Do not implement features.
- Do not write code.
- Do not jump into numbered SLDD artifacts unless the user explicitly asks to formalize a decision or begin Step 01.
- Downstream Steps 02-05 must only follow exploration details that were incorporated into the approved numbered artifact for that decision type.
- If exploration notes conflict with approved Step 01, Step 02, Step 03, or Step 04 artifacts, the approved numbered artifact wins.
- If the discussion reveals the work depends on an existing codebase, note that `sldd-99-existing-codebase-understanding-and-context-summary` may be needed before Step 02.
- For brownfield work, keep exploration open but make the routing explicit: clarify the idea first, then run Step 99 before any Step 02 design work.
- If the user wants to start the formal workflow, route them to `sldd-01-product-intent-specification`.

## What to Surface

- The problem statement in plain language.
- Primary users and their goals.
- Non-goals and boundaries.
- Constraints from the repo, process, or environment.
- Success criteria.
- Risks, unknowns, and dependencies.
- Whether the idea is ready for formal SLDD entry.

## Conversation Shape

Prefer concise but meaningful turns:

- Current understanding
- Open questions
- Candidate directions
- Key risks
- Suggested next step

If the shape of the problem is still unclear, keep exploring. If it is clear enough, say so and hand off to Step 01.

## Approval Protocol

- Exploration outputs are conversational and are not saved as numbered SLDD artifacts by default.
- Exploration is volatile by default; offer an optional `00-exploration-summary.md` when the discussion is long, has many alternatives, may be resumed later, or the user wants to pause before Step 01.
- `00-exploration-summary.md` is contextual only: it does not mark progress, replace Step 01, update `SPEC.md` checklist state, or create binding requirements/design decisions.
- Save `docs/specs/<feature-name>/00-exploration-summary.md` only after explicit approval.
- If the user asks to formalize outcomes, present the proposed formalization and wait for explicit approval before persisting any artifact.
- If approval is rejected, requested changes are given, or the user asks to hold, leave files and progress unchanged.
- If approval intent is ambiguous, ask for clarification instead of saving or routing forward.
- If writes are unavailable, stop and report the limitation.
- Exploration decisions are not binding requirements until they are explicitly formalized and approved in Step 01.
- When the user asks to formalize exploration outcomes, convert the relevant decisions into Step 01 content:
  - product intent,
  - acceptance criteria,
  - out-of-scope boundaries,
  - risks and assumptions,
  - success metrics.
- Technical design ideas discussed during exploration are non-binding. Carry them forward only as context, candidate options, assumptions to validate, or alternatives to compare in Step 02 or Step 03.
- Do not treat unresolved exploration notes, rejected alternatives, or open questions as downstream requirements.

## Optional Exploration Summary

When useful for resume continuity, offer a concise `00-exploration-summary.md` with:
- Current understanding
- Candidate product decisions
- Candidate technical ideas (non-binding)
- Alternatives discussed
- Open questions
- Risks and assumptions
- Suggested next SLDD step

Use the summary only as contextual memory. Approved numbered artifacts define binding decisions:
- Step 01 defines product intent, accepted behavior, scope, risks, and success metrics.
- Step 02 defines high-level technical design.
- Step 03 defines low-level design, contracts, dependencies, and version policy.
- Step 04 defines tests derived from approved acceptance criteria and Step 03 scenarios.

## Output Format

1. Current understanding
2. Open questions
3. Candidate directions
4. Key risks
5. Suggested next step and routing decision
