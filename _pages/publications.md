---
layout: archive
title: "Publications"
permalink: /publications/
author_profile: true
---

{% if site.author.googlescholar %}
  <div class="wordwrap">You can also find my articles on <a href="{{site.author.googlescholar}}">my Google Scholar profile</a>.</div>
{% endif %}

<div id="orcidbib">[Bibliography loads here (JavaScript required)]</div>
<script src="{{ base.url | prepend: site.url }}/pages/orcidbib.js" type="text/javascript" id="orcid:0000-0002-7970-7855"></script>

{% include base_path %}

{% for post in site.publications reversed %}
  {% include archive-single.html %}
{% endfor %}
