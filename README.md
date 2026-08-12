# Apertus 2 Chat Template Spec Proposal

Proposal for the Apertus 2 chat template: the token-level format for
conversations, tool use, and multimodal input.

Current draft: [spec.md](spec.md)

## How to work with this repo

Versioning follows a gitflow-style model. Each major revision of the spec lives
on its own branch (`v1`, `v2`, `v3`, ...) and is merged into `main` via a pull
request, so every full version change is visible and can be discussed and
commented on line by line in the PR. Changes within a revision get their own branch off
the revision branch (e.g. `v1/fix-pretrain-section` based on `v1`) and are
merged back into that revision branch via a PR.
