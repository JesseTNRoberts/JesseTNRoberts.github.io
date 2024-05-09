---
title: 'Fisher Research Group Meeting'
date: 2024-05-09
permalink: /posts/2024/05/ResearchJournal_3/
tags:
  - Meeting Notes
---

<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>


We discussed potential ideas for how to measure fan effects in language models. I proposed that we vary the number of category members given in the context to a language model and interrogate the presence of the elements. 

## The experiment

At some number of context members, the probability of absence given actual presence will tend toward the probability of absence given actual absence. That is, $$p(absent|present) \approx p(absent|absent)$$. When this occurs, if the probability of correctly evaluating the presence of atypical category members is higher than for typical category members, this would be a language model specific variant of the fan effect. 


