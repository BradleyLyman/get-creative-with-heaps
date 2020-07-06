---
title: Get Creative With Heaps.io
layout: article
---

{% assign sections = site.pages
 | group_by: 'section'
 | where_exp: "section", 'section.name != ""'
 | sort: 'name'
%}
{% for section in sections %}
## {{section.name}}
<section class="demos">
{% assign sorted = section.items | sort:'order' %}
{% for page in sorted %}
  <article class="demoCard">
    <a href="{{site.url}}{{site.baseurl}}{{page.url}}"
       style="background-image: url('{{site.url}}{{site.baseurl}}{{page.url}}Screenshot.png')" >
      <footer>
        <h4>{{page.title}}</h4>
      </footer>
    </a>
  </article>
{% endfor %}
</section>
{% endfor %}
