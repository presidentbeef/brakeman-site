---
layout: docs
title: "Documentation"
subtitle: "Comprehensive guides and references for using Brakeman to secure your Ruby on Rails applications."
quickstart_alert:
  title: "New to Brakeman?"
  content: "See our [quickstart guide](/docs/quickstart/) to get up and running in minutes!"
---

## Getting Started
{: .fade-in .stagger-1}

<div class="docs-grid">
  {% for item in site.data.documentation.getting_started %}
    <div class="docs-card">
      <h3><a href="{{ item.url | relative_url }}">{{ item.title }}</a></h3>
      <p>{{ item.description }}</p>
    </div>
  {% endfor %}
</div>

## Next Steps
{: .fade-in .stagger-2}

<div class="docs-grid">
  {% for item in site.data.documentation.next_steps %}
    <div class="docs-card">
      <h3><a href="{{ item.url | relative_url }}">{{ item.title }}</a></h3>
      <p>{{ item.description }}</p>
    </div>
  {% endfor %}
</div>
