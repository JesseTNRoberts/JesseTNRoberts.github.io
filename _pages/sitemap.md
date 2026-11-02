---
layout: single
title: "Sitemap"
permalink: /sitemap/
author_profile: true
description: "Every page on Jesse Roberts's website, from research and teaching to the Torch Canvas and Slidewright tools."
---

{% comment %}
  Lists real pages only. Redirect stubs (redirect_to), pages kept out of search (sitemap: false)
  and non-HTML files are skipped. Search engines use the XML sitemap at /sitemap.xml.
{% endcomment %}

Every page on this site is listed below. Search engines can use the [XML version]({{ '/sitemap.xml' | relative_url }}).

## Pages

<ul>
{% assign pages = site.pages | sort: "title" %}
<li><a href="{{ '/' | relative_url }}">Home</a></li>
{% for p in pages %}{% if p.title and p.sitemap != false and p.redirect_to == nil and p.url != "/" and p.url != page.url %}{% assign ext = p.url | split: "." | last %}{% unless p.url contains "." and ext != "html" %}
<li><a href="{{ p.url | relative_url }}">{{ p.title }}</a></li>
{% endunless %}{% endif %}{% endfor %}
</ul>

## Courses

<ul>
{% assign courses = site.teaching | sort: "date" | reverse %}
{% for c in courses %}{% if c.sitemap != false and c.published != false %}
<li><a href="{{ c.url | relative_url }}">{{ c.code }} {{ c.title }}</a>, {{ c.term }}</li>
{% endif %}{% endfor %}
</ul>
