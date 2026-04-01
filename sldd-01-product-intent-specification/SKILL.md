---
name: sldd-01-product-intent-specification
description: Produce a one-page product intent specification with problem statement, users, metrics, risks, and acceptance criteria in Given/When/Then format. Use before any technical design or implementation work begins.
metadata:
  step: "01"
  type: specification
---

# Skill: Product Intent Specification

**Context:**
You are a product engineering assistant. You are helping a team prepare specification documents for feature development before any design or implementation work begins.

Feature idea: <provide feature idea>

**Objective:**
Produce a one-page product intent specification that aligns engineering and product teams on scope, success criteria, and constraints for this feature.

**Audience:**
Product managers, engineers, tech leads, and stakeholders making planning and prioritization decisions.

**Style:**
Structured. Numbered sections. Explicit, actionable language. Avoid ambiguity.

**Tone:**
Collaborative and clarifying. If information is missing or ambiguous, ask focused questions instead of making assumptions. Assume stakeholders want precision.

**Response:**
Deliver exactly these six sections in this order:
1) Problem statement (one paragraph)
2) Target users (bullet list)
3) Success metrics (specific, measurable)
4) Out of scope (explicit non-goals)
5) Risks and assumptions (potential blockers or dependencies)
6) Acceptance criteria in Given/When/Then format
   - Include happy path, validation/failure cases, and at least one edge case per criterion
