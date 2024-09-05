---
permalink: /
title: "About Me"
seo_title: "Jesse Roberts - Research, Connections, and Updates"
author_profile: true
redirect_from: 
  - /about/
  - /about.html
---



My name is Jesse (Vanderbilt PhD '24). I am an inately curious assistant professor at Tennessee Tech University where I research artificial intelligence, language models, and robotics. 

My research focuses on the development, evaluation, and application of empirical methods for NLP with emphasis on transformer-based LLMs. I prefer applications that contribute to digital humanities, robotics, law, cognitive science, and the preservation of endangered languages - primarily Cherokee (Tsalagi) and Irish (Gaeilge). But I'm also interested in game theory, computational physics, and any idea that can **positively impact people**. 

The **specific aims** of my research are to (1) understand LLM cognition, (2) preserve endangered languages, (3) improve semantically-complex search, and (4) empower researchers with better tools for the analysis of linguistics and semantics.

I am currently **accepting applications** for master's and Phd students. If you are a curious person with an interest in solving real problems and exploring untrodden paths through AI then feel free to reach out via email!

Introduction to LLMs
------
For those interested in learning more about LLMs, I have put together a reading list [here](https://www.zotero.org/groups/5650079/llm_foundations_reading/items/PA9EGZCE)!

This website
------
Here you'll find [papers](/publications/), work in progress, and whatever I'm up to (usually running/climbing, reading, and writing). 

I think of goals like completing a thru hike. To reach an objective, you need to minimize _zero days_. To do that I track daily progress and below there a set of widgets that show my progress. 

Additionally, I like to keep an ongoing [research journal](/year-archive/). It's where ideas take form and I reflect on my own curiousities, questions, and philosophical musings. Some of these go on to be successful research, many don't. 



<div float="left">


<!-- This is the area where writing progress is shown -->

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">


<style>
  .countdown-wrap {
  width: 100%;
  max-width: 650px;
  padding: 30px;
  font-family: 'Inter', sans-serif;
  margin: 20px auto;
  color: #333;
  background-color: #ffffff;
  border-radius: 15px;
  box-shadow: 0 10px 30px rgba(0,0,0,0.1);
}

.countdown-wrap .goal {
  font-size: 24px;
  font-weight: 600;
  margin-bottom: 20px;
}

.countdown-wrap .glass {
  width: 100%;
  height: 10px;
  background: #f0f0f0;
  border-radius: 5px;
  overflow: hidden;
  margin-bottom: 20px;
}

.countdown-wrap .progress {
  height: 10px;
  background: linear-gradient(90deg, #4CAF50, #8BC34A);
  transition: width 0.5s ease-in-out;
}

.countdown-wrap .goal-stats {
  display: flex;
  justify-content: space-between;
}

.countdown-wrap .goal-stat {
  text-align: center;
}

.countdown-wrap .goal-number {
  font-size: 28px;
  font-weight: 700;
  color: #4CAF50;
}

.countdown-wrap .goal-label {
  font-size: 14px;
  color: #666;
}

@media screen and (max-width: 480px) {
  .countdown-wrap {
    padding: 20px;
  }
  
  .countdown-wrap .goal {
    font-size: 20px;
  }
  
  .countdown-wrap .goal-number {
    font-size: 24px;
  }
}
</style>

<div class="countdown-wrap">
  <div class="goal">Research Goal: <span class="goal-value"></span> words</div>
  <div class="glass">
    <div id="progress1" class="progress" data-goal="" data-progress=""></div>
  </div>
  <div class="goal-stats">
    <div class="goal-stat">
      <span class="goal-number progress-value"></span>
      <span class="goal-label">Written</span>
    </div>
    <div class="goal-stat">
      <span class="goal-number daysLeft"></span>
      <span class="goal-label"> </span>
    </div>
  </div>
</div>

<div class="countdown-wrap">
  <div class="goal">Creative Goal: <span class="goal-value"></span> words</div>
  <div class="glass">
    <div id="progress2" class="progress" data-goal="" data-progress=""></div>
  </div>
  <div class="goal-stats">
    <div class="goal-stat">
      <span class="goal-number progress-value"></span>
      <span class="goal-label">Written</span>
    </div>
    <div class="goal-stat">
      <span class="goal-number daysLeft"></span>
      <span class="goal-label"> </span>
    </div>
  </div>
</div>

<script>
  function updateProgress(goalId, goal, progress) {
    const progressElement = document.getElementById(goalId);
    const percentage = (progress / goal) * 100;
    progressElement.style.width = percentage + '%';
    progressElement.dataset.goal = goal;
    progressElement.dataset.progress = progress;

    const wrapperElement = progressElement.closest('.countdown-wrap');
    wrapperElement.querySelector('.goal-value').textContent = goal;
    wrapperElement.querySelector('.progress-value').textContent = progress;

    const targetDate = TARGET_DATES[goalId];
    const daysLeft = getDaysLeft(targetDate);
    const formattedDate = formatDate(targetDate);
    const daysLeftElement = wrapperElement.querySelector('.daysLeft');
    daysLeftElement.textContent = `${daysLeft} till ${formattedDate}`;
  }

  function getDaysLeft(targetDate) {
    const today = new Date();
    const endDate = new Date(targetDate);
    const oneDay = 1000 * 60 * 60 * 24;
    const daysLeft = Math.ceil((endDate.getTime() - today.getTime()) / oneDay);
    return daysLeft > 0 ? daysLeft : 0;
  }

  function formatDate(dateString) {
    const date = new Date(dateString);
    const options = { month: 'short', day: 'numeric' };
    return date.toLocaleDateString('en-US', options);
  }
  
  // Set goals and progress
  const TARGET_DATES = {
    'progress1': "{{ site.research_date }}",
    'progress2': "{{ site.creative_date }}"
  };
  updateProgress('progress1', {{ site.research_goal }}, {{ site.research_words }}); // Research goal
  updateProgress('progress2', {{ site.creative_goal }}, {{ site.creative_words }});  // Creative goal
</script>

<!-- This is the end of writing progress -->



<iframe height='454' width='300' frameborder='0' allowtransparency='true' scrolling='no' src='https://www.strava.com/athletes/100752705/latest-rides/274d85ff1858403cdb3ff73155d333f9acb777f8'></iframe>

<!-- Show static HTML/CSS as a placeholder in case js is not enabled - javascript include will override this if things work -->
<style type="text/css" media="screen">
.gr_custom_widget_ {
/* customize your Goodreads widget  here*/
width: 300px
}
.gr_custom_container_ {
/* customize your Goodreads widget container here*/
border: 1px solid #f0f0f5;
border-radius:3px;
padding: 10px 5px 10px 5px;
background-color: #FFF;
color: #000;
width: 300px
}
.gr_custom_header_ {
/* customize your Goodreads header here*/
border-bottom: 1px solid gray;
width: 100%;
margin-bottom: 5px;
text-align: center;
font-size: 120%
}
.gr_custom_each_container_ {
/* customize each individual book container here */
width: 100%;
clear: both;
margin-bottom: 10px;
overflow: auto;
padding-bottom: 4px;
border-bottom: 1px solid #aaa;
}
.gr_custom_book_container_ {
/* customize your book covers here */
overflow: hidden;
height: 60px;
float: left;
margin-right: 4px;
width: 39px;
}
.gr_custom_author_ {
/* customize your author names here */
font-size: 10px;
}
.gr_custom_tags_ {
/* customize your tags here */
font-size: 10px;
color: gray;
}
.gr_custom_rating_ {
/* customize your rating stars here */
float: right;
}
</style>
<div style="width: 300px; float: left">
<div id="gr_custom_widget_">
    <div class="gr_custom_container_">

<center>
<a rel="nofollow" href="https://www.goodreads.com/"><img alt="goodreads.com" style="border:0" src="https://s.gr-assets.com/images/widget/widget_logo.gif" /></a>
  
<div class="gr_custom_header_">
<a style="text-decoration: none;" rel="nofollow" href="https://www.goodreads.com/review/list/178001093-jesse-roberts?shelf=read&amp;utm_medium=api&amp;utm_source=custom_widget">Jesse&#39;s books</a>
</div>

</center>


<div class="gr_custom_each_container_">
    <div class="gr_custom_book_container_">
      <a title="The Signalman" rel="nofollow" href="https://www.goodreads.com/review/show/6485616200?utm_medium=api&amp;utm_source=custom_widget"><img alt="The Signalman" border="0" src="https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1338150001l/9968921._SY75_.jpg" /></a>
    </div>
    <div class="gr_custom_rating_">
      <span class=" staticStars notranslate" title="it was amazing"><img alt="it was amazing" src="https://s.gr-assets.com/images/layout/gr_red_star_active.png" /><img alt="" src="https://s.gr-assets.com/images/layout/gr_red_star_active.png" /><img alt="" src="https://s.gr-assets.com/images/layout/gr_red_star_active.png" /><img alt="" src="https://s.gr-assets.com/images/layout/gr_red_star_active.png" /><img alt="" src="https://s.gr-assets.com/images/layout/gr_red_star_active.png" /></span>
    </div>
    <div class="gr_custom_title_">
      <a rel="nofollow" href="https://www.goodreads.com/review/show/6485616200?utm_medium=api&amp;utm_source=custom_widget">The Signalman</a>
    </div>
    <div class="gr_custom_author_">
      by <a rel="nofollow" href="https://www.goodreads.com/author/show/239579.Charles_Dickens">Charles Dickens</a>
    </div>
</div>
<div class="gr_custom_each_container_">
    <div class="gr_custom_book_container_">
      <a title="Absolution by Murder (Sister Fidelma, #1)" rel="nofollow" href="https://www.goodreads.com/review/show/6485615630?utm_medium=api&amp;utm_source=custom_widget"><img alt="Absolution by Murder" border="0" src="https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1399951107l/706476._SY75_.jpg" /></a>
    </div>
    <div class="gr_custom_rating_">
      <span class=" staticStars notranslate" title="really liked it"><img alt="really liked it" src="https://s.gr-assets.com/images/layout/gr_red_star_active.png" /><img alt="" src="https://s.gr-assets.com/images/layout/gr_red_star_active.png" /><img alt="" src="https://s.gr-assets.com/images/layout/gr_red_star_active.png" /><img alt="" src="https://s.gr-assets.com/images/layout/gr_red_star_active.png" /><img alt="" src="https://s.gr-assets.com/images/layout/gr_red_star_inactive.png" /></span>
    </div>
    <div class="gr_custom_title_">
      <a rel="nofollow" href="https://www.goodreads.com/review/show/6485615630?utm_medium=api&amp;utm_source=custom_widget">Absolution by Murder</a>
    </div>
    <div class="gr_custom_author_">
      by <a rel="nofollow" href="https://www.goodreads.com/author/show/16291.Peter_Tremayne">Peter Tremayne</a>
    </div>
</div>
<div class="gr_custom_each_container_">
    <div class="gr_custom_book_container_">
      <a title="Parallel Lives" rel="nofollow" href="https://www.goodreads.com/review/show/6485614975?utm_medium=api&amp;utm_source=custom_widget"><img alt="Parallel Lives" border="0" src="https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1365654635l/3679100._SY75_.jpg" /></a>
    </div>
    <div class="gr_custom_rating_">
      <span class=" staticStars notranslate" title="really liked it"><img alt="really liked it" src="https://s.gr-assets.com/images/layout/gr_red_star_active.png" /><img alt="" src="https://s.gr-assets.com/images/layout/gr_red_star_active.png" /><img alt="" src="https://s.gr-assets.com/images/layout/gr_red_star_active.png" /><img alt="" src="https://s.gr-assets.com/images/layout/gr_red_star_active.png" /><img alt="" src="https://s.gr-assets.com/images/layout/gr_red_star_inactive.png" /></span>
    </div>
    <div class="gr_custom_title_">
      <a rel="nofollow" href="https://www.goodreads.com/review/show/6485614975?utm_medium=api&amp;utm_source=custom_widget">Parallel Lives</a>
    </div>
    <div class="gr_custom_author_">
      by <a rel="nofollow" href="https://www.goodreads.com/author/show/31015.Plutarch">Plutarch</a>
    </div>
</div>
<div class="gr_custom_each_container_">
    <div class="gr_custom_book_container_">
      <a title="Micromegas" rel="nofollow" href="https://www.goodreads.com/review/show/6485614197?utm_medium=api&amp;utm_source=custom_widget"><img alt="Micromegas" border="0" src="https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1181459579l/1156110._SX50_.jpg" /></a>
    </div>
    <div class="gr_custom_rating_">
      <span class=" staticStars notranslate" title="liked it"><img alt="liked it" src="https://s.gr-assets.com/images/layout/gr_red_star_active.png" /><img alt="" src="https://s.gr-assets.com/images/layout/gr_red_star_active.png" /><img alt="" src="https://s.gr-assets.com/images/layout/gr_red_star_active.png" /><img alt="" src="https://s.gr-assets.com/images/layout/gr_red_star_inactive.png" /><img alt="" src="https://s.gr-assets.com/images/layout/gr_red_star_inactive.png" /></span>
    </div>
    <div class="gr_custom_title_">
      <a rel="nofollow" href="https://www.goodreads.com/review/show/6485614197?utm_medium=api&amp;utm_source=custom_widget">Micromegas</a>
    </div>
    <div class="gr_custom_author_">
      by <a rel="nofollow" href="https://www.goodreads.com/author/show/5754446.Voltaire">Voltaire</a>
    </div>
</div>
<div class="gr_custom_each_container_">
    <div class="gr_custom_book_container_">
      <a title="Candide" rel="nofollow" href="https://www.goodreads.com/review/show/6485613748?utm_medium=api&amp;utm_source=custom_widget"><img alt="Candide" border="0" src="https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1345060082l/19380._SY75_.jpg" /></a>
    </div>
    <div class="gr_custom_rating_">
      <span class=" staticStars notranslate" title="it was amazing"><img alt="it was amazing" src="https://s.gr-assets.com/images/layout/gr_red_star_active.png" /><img alt="" src="https://s.gr-assets.com/images/layout/gr_red_star_active.png" /><img alt="" src="https://s.gr-assets.com/images/layout/gr_red_star_active.png" /><img alt="" src="https://s.gr-assets.com/images/layout/gr_red_star_active.png" /><img alt="" src="https://s.gr-assets.com/images/layout/gr_red_star_active.png" /></span>
    </div>
    <div class="gr_custom_title_">
      <a rel="nofollow" href="https://www.goodreads.com/review/show/6485613748?utm_medium=api&amp;utm_source=custom_widget">Candide</a>
    </div>
    <div class="gr_custom_author_">
      by <a rel="nofollow" href="https://www.goodreads.com/author/show/5754446.Voltaire">Voltaire</a>
    </div>
</div>
<br style="clear: both"/>

<noscript>
Share <a rel="nofollow" href="https://www.goodreads.com/">book reviews</a> and ratings with Jesse, and even join a <a rel="nofollow" href="https://www.goodreads.com/group">book club</a> on Goodreads.
</noscript>
</div>

</div>

<script src="https://www.goodreads.com/review/custom_widget/178001093.Jesse's%20bookshelf:%20read?cover_position=left&cover_size=small&num_books=5&order=d&shelf=read&show_author=1&show_cover=1&show_rating=1&show_review=0&show_tags=0&show_title=1&sort=date_read" type="text/javascript" charset="utf-8"></script>


</div>
</div>




