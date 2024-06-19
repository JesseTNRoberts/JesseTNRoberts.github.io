---
layout: archive
title: "Publications"
permalink: /publications/
author_profile: true
---

{% if site.author.googlescholar %}
  <div class="wordwrap">You can also find my articles on <a href="{{site.author.googlescholar}}">my Google Scholar profile</a>.</div>
{% endif %}

## Textbook

Jesse Roberts, 2024, Introduction to PLC Automation, [fulltext](https://www.jessetnroberts.com/files/Introduction_to_PLC_Automation.pdf)

## Selected Publication 

{% include base_path %}
{% for post in site.publications reversed %}
  {% include archive-single.html %}
{% endfor %}

## All Publications

{% include publications %}

### Venues 

Conferences: AAAI, IAAI, IJCAI, AISTATS, ICML, ICLR, NeurIPS, KDD, EMNLP, CoNLL, IJCNN, CogSci, ICCC, AIES, IEEE CoG, FLAIRs, NLLP 

Journals: AI Magazine, IEEE Transactions on Neural Networks, Frontiers in Theory of Neural Networks, PLOS Complex Systems
