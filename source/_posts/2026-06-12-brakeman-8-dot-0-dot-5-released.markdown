---
layout: blog
title: "Brakeman 8.0.5"
subtitle: "Lots of bug fixes"
date: 2026-06-12
version: "8.0.5"
changelog:
  since: "8.0.4"
  changes:
    - "Add `quote_schema_name` to safe quote method list ([changes](https://github.com/presidentbeef/brakeman/pull/2028) by [Zsolt Kozaroczy](https://github.com/kiskoza))"
    - "Fix SQL injection false positive for `compact_blank`/`compact` on permitted params ([changes](https://github.com/presidentbeef/brakeman/pull/2025) by [Arpit Jain](https://github.com/arpitjain099))"
    - "Fix inline render false positive for local named `text` ([changes](https://github.com/presidentbeef/brakeman/pull/2027) by  [Arpit Jain](https://github.com/arpitjain099))"
    - "Fix HAML crash on `.raw` calls ([changes](https://github.com/presidentbeef/brakeman/pull/2023) by [Federico Franco](https://github.com/FFederi))"
    - "Fix Ruby version parsing - especially for non-CRuby versions ([changes](https://github.com/presidentbeef/brakeman/pull/2021) by [Chris Southerland Jr](https://github.com/ChrisJr404))"
    - "Fix `TemplateAliasProcessor#template_name` arity ([changes](https://github.com/presidentbeef/brakeman/pull/2010) by [viralpraxis](https://github.com/viralpraxis))"
    - "Reduce false positives when using shell escaping ([changes](https://github.com/presidentbeef/brakeman/commit/169a7d4a800ca13188e74e871fb8ade3ab349470))"
checksums:
  - hash: "03735f9690d3fd4b32d66aacbf0a6d15a84266bdd06b32c05c8ecc8f6021d2be"
    file: "brakeman-8.0.5.gem"
  - hash: "287be7e40fbada68008387564aa9a18e22494c3c3bee5eea2b91c0ab74c85f71"
    file: "brakeman-lib-8.0.5.gem"
  - hash: "cc33b87e4ed33cb20ef4fa9bba908e9a6d92c705fbd708685bf59700e58dec1c"
    file: "brakeman-min-8.0.5.gem"
permalink: /blog/:year/:month/:day/:title
---

Breaking with tradition, since these are all bug fixes that are pretty clear from the description I will not be writing up detailed notes.

Nearly all fixes came from the community this round - thank you all for your contributions!

Links to the pull requests are included above.
