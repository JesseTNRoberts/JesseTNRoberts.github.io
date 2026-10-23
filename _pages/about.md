---
permalink: /
title: "About Me"
seo_title: "Jesse Roberts - Research, Connections, and Updates"
author_profile: true
redirect_from: 
  - /about/
  - /about.html
---



My name is Jesse (Vanderbilt PhD '24). I am an assistant professor at Tennessee Tech University where I lead the language and artificial intelligence research (LAIR) group. 

{{ site.data.research.tagline }} My work is supported by two [NSF grants]({{ '/research/#funding' | relative_url }}), and I've been selected as a **CORE Institute Fellow for Indigenous Language Revitalization** for 2027.

<ul class="home-areas">
{% for a in site.data.research.areas %}  <li><a href="{{ '/research/' | relative_url }}#{{ a.id }}"><i class="{{ a.icon }}" aria-hidden="true"></i> {{ a.title }}{% if a.emerging %} <span class="research-badge">Emerging</span>{% endif %}</a></li>
{% endfor %}</ul>

The Cherokee work draws on what worked for Irish (Gaeilge): the hope is a living resource that supports future generations of Tsalagi speakers. More on each area, with papers and press, is on the [Research]({{ '/research/' | relative_url }}) page.

I am currently **accepting applications** for master's and Ph.D. students. If you are a curious person with an interest in solving real problems and exploring untrodden paths through AI then feel free to reach out via email!

Introduction to LLMs
------
For those interested in learning more about LLMs, I have put together a reading list [here](https://www.zotero.org/groups/5650079/llm_foundations_reading/items/PA9EGZCE)! It's the backbone of my graduate seminar, [CSC 7970: Special Topics on LLMs]({{ '/teaching/S2026-CSC7970' | relative_url }}), where you can see the papers week by week.

<!-- Additionally, I have given some lectures on LLMs and research that might be useful:

- [What are LLMs and what research am I doing?](https://docs.google.com/presentation/d/1_Pvp9_k95nxteglsCVeX1XsYURGGrziOQmbJYnbLLoI/edit?usp=share_link)

- [What are LLMs and How Could You Use Them for Research?](https://docs.google.com/presentation/d/1w7bZLiH0T-K22qParP4oqnAfYjXGMY7WF950Nc0aQlQ/edit?usp=sharing)
 -->

Interactive Tools
------
I build browser-based tools for teaching machine learning. The main one is [Torch Canvas](/torch-canvas/), where you draw a neural network as a diagram and get the PyTorch code (and can go the other way, from code to diagram). For example, here is a full LLM:

{% include torch-canvas-link.html model="llama2_7b" label="Open Llama 2 7B" %}

See [everything it can open]({{ '/tools/torch-canvas/' | relative_url }}), from a 10-layer MLP to Qwen2.5-VL, or browse more tools and demos on the [Learn]({{ '/learn/' | relative_url }}) page.

Goals
------
Here you'll find [papers]({{ '/publications/' | relative_url }}), work in progress, and whatever I'm up to (usually running/climbing, reading, and writing). 

I think of goals like completing a thru hike. To reach an objective, you need to minimize _zero days_. To do that I track progress publicly and below there a set of widgets that show my progress. 

<!-- Additionally, I like to keep an ongoing [research journal](/year-archive/). It's where ideas take form and I reflect on my own curiousities, questions, and philosophical musings. Some of these go on to be successful research, many don't.  -->

{% include goals.html %}

<div class="widget-row">
  {% include widgets/strava.html %}
  {% include widgets/goodreads.html %}
</div>
