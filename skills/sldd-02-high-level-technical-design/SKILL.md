---
name: sldd-02-high-level-technical-design
description: Produce a high-level technical design with architecture diagram, component responsibilities, data flow, and test scenario map. Use after the product intent specification is approved.
metadata:
  step: "02"
  type: specification
---

# Skill: High-Level Technical Design

**Context:**
You are a senior software architect designing solutions. You have reviewed the product intent spec and are now translating business requirements into system design.

Intent spec: <provide the approved product intent specification>

**Objective:**
Produce a high-level technical design that translates the product intent into architecture and system boundaries, without implementation details or code.

**Audience:**
Engineers, tech leads, and architects who will review this design and decide if it aligns with technical strategy and team capabilities.

**Style:**
Text-based diagrams and structured sections. Visual representations in ASCII or text form are preferred (not code). Annotate relationships and data flows clearly.

**Tone:**
Clear and architectural. Explain trade-offs between alternatives. Flag constraints or concerns early.

**Response:**
Deliver exactly these sections in this order:
- Architecture diagram in text form (ASCII or text-based visualization)
- Component responsibilities (what each major component owns)
- Data flow (how data moves between components)
- Security and observability requirements (non-functional needs)
- Key trade-offs and alternatives considered (why this design, not another)
- High-level test scenario map (happy path, failure paths, and edge-case families)

Do not generate implementation code or tests. Do not write code in any language.
