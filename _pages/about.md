---
permalink: /
title: "About Me"
seo_title: "Jesse Roberts - AI Researcher at Tennessee Tech University"
author_profile: true
redirect_from: 
  - /about/
  - /about.html
description: "Jesse Roberts leads the Language and AI Research (LAIR) group at Tennessee Tech University and studies how neural networks and language models learn and reason."
---
{% comment %}
  Homepage order (reorganized 2026-11-09): intro and research areas, News, Work with me,
  Learn about LLMs, Apps, Goals. News items are plain HTML below, newest or most urgent first.
  Links to other repos served under the domain (/flairs-special-track/, /torch-canvas/, ...)
  are written as bare paths, not relative_url, so they point at the real app from the preview too.
{% endcomment %}

My name is Jesse (Vanderbilt PhD '24). I am an assistant professor at Tennessee Tech University where I lead the language and artificial intelligence research (LAIR) group.

{{ site.data.research.tagline }}

<ul class="home-areas">
{% for a in site.data.research.areas %}  <li><a href="{{ '/research/' | relative_url }}#{{ a.id }}"><i class="{{ a.icon }}" aria-hidden="true"></i> {{ a.title }}{% if a.emerging %} <span class="research-badge">Emerging</span>{% endif %}</a></li>
{% endfor %}</ul>

More on each area, with papers and press, is on the [Research]({{ '/research/' | relative_url }}) page.

News
------
<ul class="home-news">
  <li>
    <span class="home-news__tag">Call for papers</span>
    <p class="home-news__title"><a href="/flairs-special-track/">FLAIRS-40 special track, Deliberative and Generative AI: Hybrids and Foundations</a></p>
    <p class="home-news__text">I'm co-organizing this track with Kyle Moore and Doug Fisher. St. Pete Beach, Florida, May 24–27, 2027. Abstracts are due January 22, 2027.</p>
  </li>
  <li>
    <span class="home-news__tag">New course</span>
    <p class="home-news__title"><a href="{{ '/teaching/plc/' | relative_url }}">Introduction to PLC Automation (Beta)</a></p>
    <p class="home-news__text">A free online course with video lectures, a book and hands-on labs in Ladderbox, a PLC environment that runs in your browser.</p>
  </li>
  <li>
    <span class="home-news__tag">Talk</span>
    <p class="home-news__title"><a href="{{ '/assets/talks/how-generative-ai-really-works.html' | relative_url }}">How Generative AI Really Works</a></p>
    <p class="home-news__text">Given at Chattanooga State Community College in October 2026. More about it below.</p>
  </li>
</ul>

Work with me
------
**Students.** I am currently **accepting applications** for master's and Ph.D. students. If you are a curious person with an interest in solving real problems and exploring untrodden paths through AI then feel free to reach out via email!

**Organizations.** I also run [Cumberland Gradient]({{ '/ai-consulting/' | relative_url }}), my AI consulting practice, helping Tennessee companies put AI to use.

Learn about LLMs
------
New to generative AI? My talk [How Generative AI Really Works]({{ '/assets/talks/how-generative-ai-really-works.html' | relative_url }}) explains what AI is and how large language models write one token at a time. It also introduces Tennessee Tech's new B.S. in Artificial Intelligence. A companion notebook reproduces the numbers on the slides, and you can [open it in Colab](https://colab.research.google.com/github/JesseTNRoberts/JesseTNRoberts.github.io/blob/master/assets/talks/how-generative-ai-really-works.ipynb) or [download it]({{ '/assets/talks/how-generative-ai-really-works.ipynb' | relative_url }}).

For those interested in learning more about LLMs, I have put together a reading list [here](https://www.zotero.org/groups/5650079/llm_foundations_reading/items/PA9EGZCE)! It's the backbone of my graduate seminar on LLMs, [CSC 7970]({{ '/teaching/S2026-CSC7970' | relative_url }}), where you can see the papers week by week.

<!-- Additionally, I have given some lectures on LLMs and research that might be useful:

- [What are LLMs and what research am I doing?](https://docs.google.com/presentation/d/1_Pvp9_k95nxteglsCVeX1XsYURGGrziOQmbJYnbLLoI/edit?usp=share_link)

- [What are LLMs and How Could You Use Them for Research?](https://docs.google.com/presentation/d/1w7bZLiH0T-K22qParP4oqnAfYjXGMY7WF950Nc0aQlQ/edit?usp=sharing)
 -->

Apps
------
I build free browser apps for teaching and learning. There's nothing to install.

<ul class="home-apps">
{% for a in site.data.apps.items %}  <li>
    <img src="{{ a.icon | relative_url }}" alt="" width="40" height="40">
    <div>
      <p class="home-apps__name"><a href="{{ a.url }}">{{ a.name }}</a>{% if a.beta %} <span class="home-apps__beta">Beta</span>{% endif %}</p>
      <p class="home-apps__tagline">{{ a.tagline }}. <a href="{{ a.page | relative_url }}">{{ a.more }}</a></p>
    </div>
  </li>
{% endfor %}</ul>

For example, here is a full LLM in Torch Canvas.

{% include torch-canvas-link.html model="llama2_7b" label="Open Llama 2 7B" %}

My lecture slides and interactive demos are on the [Teaching]({{ '/teaching/' | relative_url }}) page.

Goals
------
I think of goals like completing a thru hike. To reach an objective, you need to minimize _zero days_. To do that I track progress publicly, and the widgets below show where I am. Outside of work I'm usually running, climbing, reading and writing.

<!-- Additionally, I like to keep an ongoing [research journal](/year-archive/). It's where ideas take form and I reflect on my own curiousities, questions, and philosophical musings. Some of these go on to be successful research, many don't.  -->

{% include goals.html %}

<div class="widget-row">
  {% include widgets/strava.html %}
  {% include widgets/goodreads.html %}
</div>
