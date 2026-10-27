---
# Course template. Copy this file to e.g. _teaching/S2027-AI4200.md and fill it in.
# Files starting with "_" are not published, so this template never appears on the site.
#
# Adding a lecture: put the slide file in assets/lectures/<COURSE>/ and add an entry under
# `lectures:`. It appears on the course page and in the lecture library on /teaching/.

layout: course
title: "Course Title"
code: "AI 4200"                 # shown on the page
course_id: AI4200               # no spaces; matches `courses:` in _data/demos.yml / torch_canvas.yml
term: "Spring 2027"
date: 2027-01-11                # term start (for sorting)
status: current                 # current | past
level: "Undergraduate / Graduate"
institution: "Tennessee Tech · Computer Science"
permalink: /teaching/S2027-AI4200
summary: >-
  One or two sentences about the course.
website:                        # optional: separate course site or LMS link
syllabus:                       # optional: link to syllabus (e.g. /files/AI4200-syllabus.pdf)
reading_list:                   # optional: link to a reading list (e.g. Zotero)
schedule_label:                 # optional: heading for the list below (default "Schedule")
dates_are_weeks:                # optional: true if lecture dates are week-start dates ("Week of Aug 18")

lectures:
  - week: 1
    session: 1                  # optional: lecture number within the week
    date: 2027-01-12            # optional
    title: "Lecture title"
    topics: [topic one, topic two]
    slides: /assets/lectures/AI4200/week1.1-slides.html
    pdf:                        # optional: PDF version of the slides
    video:                      # optional: recording link
    notebook:                   # optional: Jupyter notebook (.ipynb) in assets/lectures/<COURSE>/; adds Notebook and Colab links
    demos: [neuron-2d]          # optional: ids from _data/demos.yml
    models: [llama2_7b]         # optional: Torch Canvas preset ids from _data/torch_canvas.yml
    readings:                   # optional: papers for this session
      - title: "Attention Is All You Need"
        authors: "Vaswani et al."
        year: 2017
        venue: NeurIPS
        url: https://arxiv.org/abs/1706.03762
    note: ""                    # optional: one line (e.g. "Project 1 released")
---

Optional free-form course notes (Markdown): overview, prerequisites, grading, office hours.
These appear above the schedule.
