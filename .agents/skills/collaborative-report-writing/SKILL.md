---
name: collaborative-report-writing
description: Use whenever the user asks for a report. Also use for substantial proposals, design documents, RFCs, or analyses requiring holistic drafting, conversational section-by-section review, approval before revisions, and a final consistency audit.
---

# Collaborative Report Writing

Create a coherent full draft first, then refine it with the user through focused conversation. Treat the document as a whole during research and drafting, but expose only one manageable section at a time during review.

## When to use this workflow

Use this workflow whenever the user asks for a **report**. Also use it for substantial proposals, design documents, RFCs, or analyses that explicitly require collaborative review, especially when:

- The subject requires research or codebase exploration before writing.
- Conclusions in one section affect recommendations elsewhere.
- The user wants to shape tone, scope, or decisions through discussion.
- A one-shot answer would be useful as a starting point but insufficient as the final document.

Do not use the full workflow for a short note, a mechanical documentation edit, or a document the user explicitly wants written without iterative review.

## Phase 1: Understand and research the whole problem

Before drafting, inspect enough source material to understand the document's full scope. For codebase reports, identify concrete examples, callers, constraints, existing conventions, and relevant tests rather than reasoning from one example.

Keep research broad enough to discover relationships among sections. Do not begin section-by-section drafting before understanding the overall argument.

Ask clarifying questions early whenever scope, intent, audience, terminology, or desired outcomes are uncertain. Prefer a brief question over pursuing an assumption that could lead to irrelevant research or a dead end. Continue independently when ambiguity is minor and unlikely to affect the document's direction.

## Phase 2: Write a complete first draft

Write the entire report to its target file before beginning collaborative section review. The first draft should be coherent enough that later sections account for earlier findings and recommendations.

The first draft is a working artifact, not a sequence of disconnected notes. It should include:

- A clear scope.
- The central question, findings, recommendation, or thesis, as appropriate.
- Concrete evidence and examples.
- Alternatives or tradeoffs where they help make a decision.
- Compatibility, verification, or follow-up considerations when relevant.

Prefer the smallest useful structure. Do not add generic sections merely because reports often contain them. Every section should advance the document's purpose.

## Phase 3: Review one section at a time

Present a small section or coherent subsection to the user. Include enough surrounding context to make the section understandable, but do not paste the entire report repeatedly. When practical, keep each presented section under 50 lines to minimize scrolling. Split longer sections at a natural boundary without losing necessary context.

For each section:

1. Show the current text or a concise faithful excerpt.
2. Invite feedback conversationally.
3. Stay on that section until the user is satisfied.
4. Move to the next section only after the current one is accepted or deliberately deferred.

Use ordinary conversation by default. Use a structured question tool when a small, well-defined set of choices will genuinely help, not for every interaction.

## Discuss before editing

Almost always discuss changes before modifying the file. Draft proposed text in the conversation and obtain explicit approval before applying it, especially when feedback requires judgment, interpretation, or brainstorming.

Good sequence:

1. Explore the user's concern.
2. Compare the relevant options honestly.
3. Present proposed replacement text.
4. Ask whether to apply it.
5. Edit only after approval.

Direct, unambiguous approval such as "remove this section," "apply this version," or "yes" is sufficient.

Batch related edits after a discussion rather than changing the file after every conversational turn. This keeps the document stable while ideas are still moving.

## Preserve conversational momentum

After applying an approved edit, present the next section without making the user restate the workflow.

Keep progress updates brief. Do not narrate routine file operations. Focus updates on the section under review, the decision being made, and any consequence for the larger document.

When the user wants to brainstorm, remain in discussion mode. Do not prematurely convert every idea into document text.

## Keep scope disciplined

Distinguish among:

- Changes the report recommends.
- Existing behavior the report intentionally preserves.
- Ideas deferred for later consideration.

Do not create full sections for areas where the report recommends no action unless they establish an important scope boundary. Prefer removing irrelevant inventories over documenting every unchanged case.

Keep implementation details beside the specific recommendation they support. Avoid generic placement, naming, migration, or risk sections when those details are clearer in the relevant code-specific section.

As decisions become settled, remove stale alternatives and tentative language. Do not leave the report sounding undecided after the user has made a decision.

## Adapt tone and level of detail

Match each section's purpose:

- Keep executive summaries concise.
- Put examples and supporting detail in relevant sections.
- Use concrete before-and-after examples when they clarify a change.
- Explain tradeoffs honestly without preserving rejected alternatives indefinitely.

Match the report's intent, whether informational, analytical, decision-oriented, or persuasive.

## Phase 4: Audit the completed document

After every section has been reviewed, read the entire document again as one artifact. This audit is required even if each section was individually approved.

Check for:

- Terminology or type names that changed during discussion.
- Earlier statements contradicted by later decisions.
- Options presented as open after they were resolved.
- Sections that became redundant or out of scope.
- Recommendations that no longer match the agreed convention.
- Repeated explanations that can be consolidated.
- Tone changes between early and late sections.
- References to removed sections, phases, or examples.

Propose final cleanup edits to the user and obtain approval before applying them, unless the user has already authorized a final consistency pass.

## Completion

Conclude only after:

- The full first draft exists in the requested file.
- Every retained section has been reviewed or explicitly skipped by the user.
- Approved edits have been applied.
- The full-document consistency audit is complete.

Summarize the resulting artifact briefly. Do not reopen settled content or introduce new recommendations in the final message.
