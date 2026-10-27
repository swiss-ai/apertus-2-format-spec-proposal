# Apertus 2 Profile: Questions and Answers

This living Q&A explains the [Apertus 2 profile](apertus_2.md), drawing on
team questions and GitHub issues. The initial answers summarise the profile
discussions; add source issue links as further questions are resolved.
The profile remains the source of requirements. See the
[maintenance convention](../../README.md#profile-questions-and-answers).

## Table of Contents

- [What is the difference between the format and a profile?](#what-is-the-difference-between-the-format-and-a-profile)
- [Does the model have to wait for another user turn?](#does-the-model-have-to-wait-for-another-user-turn)
- [Does the model see its earlier reasoning?](#does-the-model-see-its-earlier-reasoning)

## What is the difference between the format and a profile?

The [format](../../spec.md#part-i-the-format) defines message envelopes,
control tokens, and generation mechanics. A profile selects message types,
headers, payload conventions, trust ranks, and interaction rules for a model.
See [what a profile defines](../../spec.md#6-what-a-profile-defines).

## Does the model have to wait for another user turn?

No. Inputs can arrive between model messages within a generation burst.
Queued messages enter at the next complete message boundary in first-in,
first-out (FIFO) order. Only `<|wait|>` normally ends the burst; any delivered
input can resume the model, including a tool result or harness notice.
See [Bursts and Delivery Order](apertus_2.md#bursts-and-delivery-order).

## Does the model see its earlier reasoning?

Yes. Apertus 2 keeps every think message in context, including those from
earlier turns. The post-training team decided this on 2026-10-21: keeping
each conversation as one sample simplifies supervised fine-tuning (SFT) and
reinforcement learning (RL), and the model can reuse options it already
explored. Deployments that need to reclaim context compact it instead. See
[Context and Memory Policy](apertus_2.md#context-and-memory-policy).
