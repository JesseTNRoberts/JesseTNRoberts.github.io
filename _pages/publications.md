---
layout: archive
title: "Publications"
permalink: /publications/
author_profile: true
---

{% if site.author.googlescholar %}
  <div class="wordwrap">You can also find my articles on <a href="{{site.author.googlescholar}}">my Google Scholar profile</a>.</div>
{% endif %}

<div id="orcid-profiles-widget-js" data-orcids="0000-0002-6210-0678">
      <!-- Container for ORCID profile widget -- Add ORCIDs delimited by commas to -- the data-orcids attribute. -->
    </div>
<script type='text/javascript' src='http://code.jquery.com/jquery-1.9.1.js'></script>
<script type='text/javascript' src="{{ base.url | prepend: site.url }}/_pages/jQuery.orcidProfilesWidget.js"></script>
<link rel="stylesheet" type="text/css" href="{{ base.url | prepend: site.url }}/_pages/orcid-profiles-jquery-widget.css">
{% include base_path %}

{% for post in site.publications reversed %}
  {% include archive-single.html %}
{% endfor %}
