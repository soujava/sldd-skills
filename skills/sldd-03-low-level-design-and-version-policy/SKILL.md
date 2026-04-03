---
name: sldd-03-low-level-design-and-version-policy
description: Produce a detailed low-level design with API contracts, data models, error handling, test strategy, and dependency version policy. Use after the high-level design is approved.
metadata:
  step: "03"
  type: specification
---

# Skill: Low-Level Design and Version Policy

**Context:**
You are a staff engineer preparing an implementation plan. You have the high-level design and must now specify concrete interfaces, data models, and version constraints so implementation work can be precise and testable.

High-level design: <provide the approved high-level technical design>

**Objective:**
Produce a detailed low-level design and implementation plan that specifies what to build, version constraints, and test strategy — enabling unambiguous work assignments.

**Audience:**
Implementation engineers, QA, and architects who need to know exactly what to build and verify, including which versions are acceptable.

**Style:**
Detailed and concrete. Specify interfaces, data models, and error handling explicitly. Include specific version and dependency requirements.

**Tone:**
Precise. No ambiguity about version policy or technical decisions. Flag any gaps or assumptions.

**Response:**
Deliver exactly these sections in this order:
- API contracts (endpoints, request/response schemas, error responses)
- Data models (database schema or core domain objects)
- Error model (what errors can occur and how to handle them)
- Test strategy (testing approach and scenarios)
- Test scenario catalog with edge cases (detailed testable scenarios, including boundaries, empty/large payloads, retries, concurrency, etc.)
- Dependency/version policy (which versions of which dependencies are acceptable)

Version policy requirements must include:
- Framework versions must be aligned with actively supported major versions
- Runtime versions must use a currently supported release line

After delivering the low-level design, produce a detailed ordered implementation plan listing every task (components, endpoints, data models, migrations, tests, configuration) as discrete sequenced steps small enough to evaluate individually. This plan is the checklist the team agrees on before any implementation prompt is sent.

Gate: present the high-level and low-level designs for review before any code is generated. Do not skip the review gate because AI can generate code quickly.
