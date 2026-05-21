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
- For existing codebases, inspect the current codebase when codebase understanding is needed to explore scope, constraints, risks, or alternatives.
- If brownfield exploration depends on reusable codebase context, route to `sldd-99-existing-codebase-understanding-and-context-summary` before formalizing Step 01.
- A Step 99 completed during exploration may satisfy the later brownfield gate only after resume validation confirms it still matches the current codebase and approved Step 01 scope.
- Optional summaries default to `docs/specs/<feature-name>/00-exploration-summary.md` unless the user provides a path.
- `00-exploration-summary.md` is contextual memory only: it does not update `docs/specs/<feature-name>/SPEC.md`, mark progress, or replace numbered artifacts.

## Exploration Stance

- Explore first, formalize later.
- Ask questions that clarify the problem, users, constraints, outcomes, risks, unknowns, and non-goals.
- Keep the conversation grounded in the actual repo and workflow when relevant.
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
8. Proactively offer `00-exploration-summary.md` before Step 01 when technical design ideas, complex alternatives, or refined constraints should be preserved for Step 02/03.

## Ground Rules

- Do not implement features.
- Do not write code.
- Do not jump into numbered SLDD artifacts unless the user explicitly asks to formalize a decision or begin Step 01.
- Downstream Steps 02-05 may follow only exploration details incorporated into the approved numbered artifact for that decision type; approved numbered artifacts override exploration notes.
- If the discussion reveals the work depends on an existing codebase, determine whether codebase understanding is needed now for exploration or later before Step 02.
- For brownfield work, ground exploration in the current codebase when relevant, but treat codebase observations as approved Step 99 context only if Step 99 is explicitly run and approved.
- If the user wants to start the formal workflow, route them to `sldd-01-product-intent-specification`.

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
- Proactively offer `00-exploration-summary.md` whenever exploration produces technical design ideas, architectural choices, complex alternatives, or non-obvious constraints.
- Save `docs/specs/<feature-name>/00-exploration-summary.md` only after explicit approval.
- If the user asks to formalize outcomes, present the proposed formalization and wait for explicit approval before persisting any artifact.
- On rejection, requested changes, hold, or ambiguous approval, do not save or route forward; clarify or wait.
- If writes are unavailable, stop and report the limitation.
- Exploration decisions are not binding requirements until explicitly formalized and approved in Step 01 as product intent, acceptance criteria, scope boundaries, risks, assumptions, or success metrics.
- Technical design ideas are non-binding; carry them forward only as context, candidate options, assumptions to validate, or alternatives for Step 02/03.
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
5. Suggested next step and routing decision, including whether Step 99 is needed now, later, or not applicable
6. **Summary Recommendation**: Explicitly state if an `00-exploration-summary.md` is recommended to preserve technical memory.
