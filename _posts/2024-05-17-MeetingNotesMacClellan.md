---
title: 'Meeting with GaTech Colab'
date: 2024-05-17
permalink: /posts/2024/05/17/MeetingNotes/
tags:
  - Meeting notes
  - Idea
---


## 2024-05-17

Targeting BabyLM 2024 with a cobweb based implementation. The interface definition for the implementation is housed [here](https://github.com/EleutherAI/lm-evaluation-harness/blob/big-refactor/docs/model_guide.md).

## 2024-05-10

I was thinking about a previous discussion on forgetting and hit upon a notion. Infinite memory with limited retrieval ability should be indistinguishable from limited memory. So, instance based systems with limited retrieval should exhibit something indistinguishable from forgetting. This would seem to apply both to cobweb and to in-context-learning. 

The papers title will be: Forgetting Beyond Neural Networks

Show memory-based forgetting and retrieval based forgetting in both the neural and non-neural cases.


### Idea

Good knowledge with appropriate retrieval algorithm with unexpected/non-optimal stopping (possibly from limited resources). Leads to _catastrophic retrieval_ which may be indistinguishable from forgetting. Gives an account of the link between ADHD and risk taking behavior.  

