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

Jesse Roberts, 2024, Introduction to PLC Automation, [PDF Version](/files/Introduction_to_PLC_Automation.pdf)

## Selected Publication 

{% include base_path %}
{% for post in site.publications reversed %}
  {% include archive-single.html %}
{% endfor %}

## All Publications

{% include publications %}

