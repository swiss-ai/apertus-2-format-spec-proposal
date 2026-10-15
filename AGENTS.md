# Repository writing and style rules

This repository specifies how post-trained large language models (LLMs)
process and understand messages and communicate with the harness that serves
them. See the
[README](README.md) for an overview and [spec.md](spec.md) for the shared
format and reference profile. These rules apply to all repository documentation,
for humans and coding agents. `AGENTS.md` is canonical; `CLAUDE.md` is a relative
symlink to it. Edit this file to keep both entry points in sync.

## Development setup and checks

This is a documentation repository; no build step is required. Local checks
need Node.js/npm, `lychee` (version 0.24.2 in CI), and `xmllint` (provided by
`libxml2-utils` on Ubuntu). Run from the repository root:

```sh
npx markdownlint-cli2
lychee --offline --include-fragments --no-progress --root-dir "$PWD" "**/*.md"
bash scripts/check-diagrams.sh
git diff --check
```

Markdown rules and file selection live in [.markdownlint.yml](.markdownlint.yml)
and [.markdownlint-cli2.yaml](.markdownlint-cli2.yaml). On every pull request,
[Documentation checks](.github/workflows/docs.yml) runs Markdown linting,
offline local-link and anchor checks, SVG validation and a Mermaid-block check,
and whitespace checks against the PR base. External URLs are not checked.

## Writing rules

- Use British English.
- Write in the present tense.
- Do not use em dashes; use commas, colons, semicolons, or separate sentences.
- Preserve literal protocol names, code, and quoted source text even when
  their spelling or tense differs from the prose rules.
- Write concise, precise prose. State the purpose first, then the rules and
  examples needed to understand it. Use consistent names for protocol concepts.
- Prefer active voice and name the actor: the model generates, the harness
  dispatches, and the tool returns.
- Use the Oxford comma in lists of three or more. Spell out contractions
  and use "and" rather than an ampersand in prose.
- Define domain-specific acronyms on first use in each document, then reuse
  them consistently.
- Spell out zero to nine in prose. Use numerals for protocol values, ranks,
  measurements, dates, versions, and table data; preserve literal model names.
- Support factual claims with the relevant source or definition. Read the
  substantive discussion before treating a proposal as settled; mark unresolved
  evidence or decisions with a TODO or open question.
- Use bullets for parallel requirements, tables for comparisons, and diagrams
  for flows. Keep headings descriptive and update the table of contents when
  sections change.
- When a rule changes, update affected examples, diagrams, tables, and cross-
  references together. Preserve unrelated edits and profile-specific choices.
- Verify Markdown links, literal message syntax, and table alignment after
  editing. Run `git diff --check` for whitespace errors.
- When reviewing, check all applicable writing and graphics rules. Report
  unresolved violations with their location and proposed fix.

### Change logs

Keep a `Change Log` near the top of each profile, after its introduction and
before its main chapters. Use an aligned table with `Date` and `Change introduced`
columns, ISO dates (`YYYY-MM-DD`), and newest entries first. Record only major,
summarised changes, for example after a pull request merges or a draft reaches
a milestone. Group related changes into one entry; omit small edits and
individual working updates. Do not invent dates for earlier work.

## Documentation building blocks

Humans and coding agents should use these conventions when adding or editing
documentation. Keep examples consistent with the profile they describe;
formatting choices must not change literal token sequences.

### Warnings, TODOs, and questions

Put a warning immediately below the example or diagram it qualifies.
State shared constraints in their defining section; link back where needed
instead of repeating the same warning after every example or graphic.
Always include a visible label so the meaning survives plain-text viewing
or rendering without colour. Inline colours require support for HTML styles;
the label remains the fallback when a renderer strips them.

Info notes and warnings use one paragraph with an inline icon, label, and
text, without a separate heading. Allow natural line wrapping. Use anthracite
text on an explicit pale-blue background for notes or pale amber for warnings
so both remain readable against light and dark page backgrounds. Inside these
boxes, links inherit the text colour and stay underlined; inline code inherits
the text colour with a transparent background.

Copy these blocks and replace their text:

```html
<p style="border: 1px solid #B8860B; border-left: 4px solid #B8860B; background-color: #FFF4CC; color: #2E2F31; padding: 10px 14px; border-radius: 6px;"><strong>⚠ WARNING:</strong> A requirement or pitfall the reader must notice.</p>

<p style="color: #C2410C;"><strong>TODO (from: AUTHOR; for: OWNER):</strong> A concrete task still to complete.</p>

<p style="color: #C2410C;"><strong>OPEN QUESTION (from: AUTHOR; for: RESPONDENT):</strong> A decision still to resolve.</p>

<p style="border: 1px solid #7BBBD5; border-left: 4px solid #7BBBD5; background-color: #BFD8E1; color: #2E2F31; padding: 10px 14px; border-radius: 6px;"><strong>ℹ NOTE:</strong> Helpful context or an explanation.</p>
```

Every TODO and open question includes `from` (who raises it) and `for`
(who acts on it or answers it). Use a name, handle, or team; use `unknown`
when the author is not recorded and `unassigned` when no recipient is set.
Mark unfinished draft sections as TODOs. Replace the uppercase placeholders
before publishing a block. Do not invent an author or assign a person
without context.

Use `<code>...</code>` for inline code inside these HTML blocks. Escape
literal `<`, `>`, and `&` as `&lt;`, `&gt;`, and `&amp;`. Once a question
or TODO is resolved, replace it with ordinary specification text.

### Training Impact boxes

Place a Training Impact box immediately after a rule that needs explicit
training coverage. State the required model behaviour and the examples or
evaluations that establish it. Every message definition must explain its
intended learned use; these boxes flag areas needing particular attention,
not the only behaviour that requires training. Use the graduation-cap icon and visible label,
a red left border (`#FF0000` from the Apertus palette), a pale-blue background,
and anthracite text. The blockquote,
icon, and label remain meaningful when a renderer strips inline styles.

```html
<blockquote style="border-left: 4px solid #FF0000; background-color: #BFD8E1; color: #2E2F31; padding: 12px 16px;">
<p><strong>🎓 Training Impact</strong></p>
<p>Train the model to [required behaviour]. Include [training examples] and evaluate [observable outcome].</p>
</blockquote>
```

Replace the bracketed placeholders. Use plain HTML inside the box, with
`<code>` for protocol names and escaped characters as in the blocks above.

### Graphics palette

Use the Apertus 1.5 report palette for all authored graphics, including
protocol diagrams, vector images, and raster illustrations. These values match
`main.tex` in `swiss-ai/apertus-1.5-report`; this table is the local reference.

| Colour                  | Hex       | Role                                      |
| ----------------------- | --------- | ----------------------------------------- |
| Apertus sky blue        | `#7BBBD5` | Primary series or process                 |
| Light sky blue          | `#AACFDC` | Secondary groups and fills                |
| Pale sky blue           | `#BFD8E1` | Background bands and subtle fills         |
| Anthracite              | `#2E2F31` | Text, axes, outlines, and comparison      |
| EPFL red                | `#FF0000` | Important highlight, error, or warning    |
| White                   | `#FFFFFF` | Backgrounds and text on anthracite        |

- Build graphics on white. Use anthracite text on the blues; reserve white
  text for anthracite backgrounds. Use red sparingly for emphasis.
- Keep semantic colour roles consistent across figures. Introduce extra
  colours only when this palette cannot express a necessary distinction.
- Keep figures understandable in greyscale and with colour vision deficiencies.
  Pair colour with labels, line styles, shapes, hatching, or distinct outlines.
- Prefer direct labels to legends. Use sentence case inside figures, readable
  type at the displayed size, aligned elements, and whitespace for grouping.
- Use flat styling without gradients, shadows, three-dimensional effects,
  decorative backgrounds, or heavy grid lines.

The amber warning border (`#B8860B`), pale-amber warning background (`#FFF4CC`),
and orange TODOs/questions (`#C2410C`) are annotation conventions, not additional
graphics colours. Photographs and screenshots retain their original colours.

### Protocol diagrams

Keep diagrams as simple as possible and as complex as necessary. Use
self-contained SVG images for now; do not add Mermaid blocks. The SVG is
both the editable source and the displayed graphic, so no preview extension
or separate export is needed.

- Use the [tool-call graphic](profile/apertus_2/images/tool-call-outcomes.svg)
  and [output-validation graphic](profile/apertus_2/images/output-validation.svg)
  as layout examples. Keep labels concise, text readable, and paths distinct.
- Label each outcome and use arrows for sequence. Group shared recovery steps
  rather than repeating them or drawing unnecessary loops.
- Use sky blue for actions, light blue for success, pale blue for decisions
  and recovery, and red outlines for errors. Use anthracite text and arrows
  on white backgrounds; labels and symbols must also convey each outcome.
- Include a `viewBox`, a descriptive `<title>` and `<desc>`, and meaningful
  Markdown alt text. Use ordinary SVG text and shapes without scripts,
  external fonts, or embedded HTML.
- Inspect the rendered graphic at a typical Markdown preview width and
  check that labels fit inside their boxes before reporting completion.

### External graphics

- Give each profile its own directory:
  `profile/<profile_name>/<profile_name>.md`, with graphics in the adjacent
  `images/` folder. Use `.gitkeep` while that folder is empty.
- Embed graphics with standard Markdown image syntax and a
  relative path from the Markdown file. For example, after creating the
  referenced image:

  ```markdown
  ![Message flow between the model and harness](images/message-flow.svg)
  ```

- Prefer SVG for vector diagrams, PNG for screenshots and raster diagrams,
  and JPEG for photographs. Use descriptive lowercase filenames with hyphens.
- Keep editable source files alongside exported images when a separate tool
  creates the graphic, for example `message-flow.drawio` and
  `message-flow.svg`. Embed the exported image, not the editor source.
- Supply meaningful alt text and add a short caption below the image when
  it helps explain the figure. Follow the [graphics palette](#graphics-palette)
  for authored diagrams, and keep essential meaning readable without colour.
- Commit images with the Markdown that uses them. Avoid local absolute paths
  and branch-specific remote image URLs for repository-owned assets.
- After moving a profile, update incoming links and its relative links to
  other files; a profile in its own folder links to `../../spec.md`.
- Check that image paths exist with the exact filename case, and inspect
  the rendered image in Markdown preview when a graphic is added.

### Examples and tables

- Use fenced `text` blocks for literal message sequences and `json` for
  standalone JSON. Preserve exact header syntax; explain placeholders.
- Keep Markdown table columns padded and aligned for text-editor viewing.
- Left-align text and right-align numeric columns. Keep units, precision,
  and number formatting consistent within each column; explain missing values
  and any emphasis in a caption or short introduction. Shorten or split wide
  tables rather than shrinking the text until it is unreadable.
- Link related definitions instead of repeating long requirements. Use
  headings and table-of-contents anchors consistently.
