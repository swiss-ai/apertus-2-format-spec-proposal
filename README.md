# Apertus Format and Apertus Profiles

This repository contains the specification of the Apertus Format: a message format we use to train the apertus models from Apertus 2 onwards.
Together with this general format, this repo also presents specific profiles that denote the specific implementation of the format for a model
and fully specifies how the model geenrates and receives messages and behaves in their context.

Most importantly this repo currently contains the Apertus 2 Profile: the profile our team uses to train Apertus 2.

<p style="border: 1px solid #B8860B; border-left: 4px solid #B8860B; background-color: #FFF4CC; color: #2E2F31; padding: 10px 14px; border-radius: 6px;"><strong>⚠ WARNING:</strong> The <a style="color: inherit; text-decoration: underline;" href="profile/apertus_2/apertus_2.md">Apertus 2 Profile</a> remains under development throughout the early post-training phases. For concerns, questions, or ideas, <a style="color: inherit; text-decoration: underline;" href="https://github.com/swiss-ai/apertus-2-format-spec-proposal/issues/new/choose">open a GitHub issue</a> or reach out to the authors directly via Slack or email.</p>

## Format and profiles

- [spec.md](spec.md) defines the shared message format and includes a
  reference profile.
- Each `profile/<profile_name>/` directory contains a model-specific profile
  in `<profile_name>.md`, a companion `qa.md`, and graphics in `images/`.
- The [Apertus 2 profile](profile/apertus_2/apertus_2.md) defines its message
  types, headers, content, trust ranks, and interaction rules. Its
  [questions and answers](profile/apertus_2/qa.md) explain common questions.

### Profile questions and answers

For questions, concerns, or ideas,
[open a GitHub issue](https://github.com/swiss-ai/apertus-2-format-spec-proposal/issues/new/choose)
or contact the authors directly via Slack or email. Include the profile and
relevant section when possible.

Each profile's `qa.md` is a living collection of answers to recurring questions
sourced from the team and GitHub issues.

For authors maintaining these files:

- Keep answers concise and link to the relevant profile or format section,
  plus the source issue or discussion when available.
- Use a question as each heading and maintain a table of contents.
- Update affected answers alongside profile changes and add questions as
  they are resolved.
- Mark unresolved points as open questions rather than presenting proposals
  as settled answers.

## How to work with this repo

Versioning follows a gitflow-style model. Each major revision of the spec lives
on its own branch (`v1`, `v2`, `v3`, ...) and is merged into `main` via a pull
request, so every full version change is visible and can be discussed and
commented on line by line in the PR. Changes within a revision get their own branch off
the revision branch (e.g. `v1/fix-pretrain-section` based on `v1`) and are
merged back into that revision branch via a PR.
