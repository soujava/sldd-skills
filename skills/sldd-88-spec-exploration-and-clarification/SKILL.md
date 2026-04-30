---
name: sldd-88-spec-exploration-and-clarification
description: Explore and clarify a new SLDD spec with the user before Step 01. Use when the user has a fresh idea, wants to shape requirements, scope, risks, success criteria, or wants to think through a new SLDD workflow before writing the product intent spec.
metadata:
  step: "88"
  type: navigation
---

# Skill: Spec Exploration and Clarification

Use `sldd-88-shared-templates-and-protocols` for shared SLDD gate rules and artifact conventions.

## Objective

Help the user turn a rough idea into a clear, testable spec direction before formal SLDD Step 01 starts.

## Gate/Route Rules

- Keep exploration pre-Step-01 unless the user explicitly asks to formalize.
- Route to Step 01 when the idea is sufficiently clear.
- For existing codebases, remind that Step 99 is required before Step 02 design work.

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
- Downstream Steps 02-05 must only follow exploration details that were incorporated into an approved Step 01 artifact.
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
- If the user asks to formalize outcomes, present the proposed formalization and wait for explicit approval before persisting any artifact.
- Exploration decisions are not binding requirements until they are explicitly formalized and approved in Step 01.
- When the user asks to formalize exploration outcomes, convert the relevant decisions into Step 01 content:
  - product intent,
  - acceptance criteria,
  - out-of-scope boundaries,
  - risks and assumptions,
  - success metrics.
- Do not treat unresolved exploration notes, rejected alternatives, or open questions as downstream requirements.

## Output Format

1. Current understanding
2. Open questions
3. Candidate directions
4. Key risks
5. Suggested next step and routing decision
