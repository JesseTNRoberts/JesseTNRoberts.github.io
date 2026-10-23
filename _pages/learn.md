---
layout: single
title: "Learn"
permalink: /learn/
author_profile: true
excerpt: "Interactive tools and demos for learning machine learning and deep learning."
---

Hands-on tools I've built for my courses. Everything runs in the browser, with nothing to install.

{% assign tc = site.data.torch_canvas %}
{% assign tcl = site.data.torch_canvas_library %}
<section class="learn-feature">
  <p class="learn-feature__eyebrow">Tool · {{ tc.tool.tagline }}</p>
  <h2 class="learn-feature__title"><a href="{{ tc.tool.page | relative_url }}">{{ tc.tool.title }}</a></h2>
  <p>{{ tc.tool.description }}</p>
  <p>
    <a class="btn btn--primary" href="{{ tc.tool.url }}">Open {{ tc.tool.title }}</a>
    <a class="btn btn--inverse" href="{{ tc.tool.page | relative_url }}">All {{ tcl.networks.size }} example models →</a>
  </p>
  {% if tcl %}
  <div class="tc-grid tc-grid--featured">
    {% for id in tc.featured limit: 4 %}{% assign m = tcl.networks | where: "id", id | first %}{% if m %}{% include tc-model-card.html model=m compact=true %}{% endif %}{% endfor %}
  </div>
  {% endif %}
</section>

## Interactive demos

<ul class="learn-list">
  {% for d in site.data.demos %}
  <li class="learn-card">
    <a class="learn-card__title" href="{{ d.url | relative_url }}">{{ d.title }}</a>
    {% if d.description %}<p class="learn-card__desc">{{ d.description }}</p>{% endif %}
    {% include learn-tags.html item=d %}
  </li>
  {% endfor %}
</ul>

Course pages, with slides, are under [Teaching]({{ '/teaching/' | relative_url }}).
