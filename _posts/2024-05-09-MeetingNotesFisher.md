---
title: 'Fisher Research Group Meeting'
date: 2024-05-09
permalink: /posts/2024/05/09/MeetingNotesFisher
tags:
  - Meeting Notes
---


We discussed potential ideas for how to measure fan effects in language models. I proposed that we vary the number of category members given in the context to a language model and interrogate the presence of the elements. 

## The experiment

At some number of context members, the probability of absence given actual presence will tend toward the probability of absence given actual absence. That is... 

$$\begin{aligned}
p(absent|present) \approx p(absent|absent)
\end{aligned}$$

When this occurs, if the probability of correctly evaluating the presence of atypical category members is higher than for typical category members, this would be a language model specific variant of the fan effect. 


So, GPT-2 can be used with a population and a number of category items that are understood in terms of their typicality. The context can be filled to varying degrees (experimental variable 1). When the above probabilitic scenario occurs for the cohort of present typical items, the probability of presence of the atypical within context cohor should be measured. If the accuracy is higher for atypical than for typical when the context has reached the described probabilistic scenario, then GPT-2 is more readily able to retrieve atypical items within the context than typical items. Thus, a form of fan effects are present. 
