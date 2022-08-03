---
layout:     post 
title:      "[Elasticsearch] Working with disjunction max query - dis_max"
subtitle:   ""
description: ""
date:       2022-05-27 12:00:00
image: "https://img.zhaohuabing.com/post-bg-2015.jpg"
published: true
tags:
    - Elasticsearch
URL: ""
categories: [ Tech ]
---

``` json
GET /_search
{
  "query": {
    "dis_max": {
      "queries": [
        { "term": { "title": "iphone" } },
        { "term": { "body": "iphone" } }
      ],
      // "tie_breaker": 0.7
    }
  }
}
```


This is the official document written about [dis_max](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-dis-max-query.html#query-dsl-dis-max-query):

> Returns documents matching one or more wrapped queries, called query clauses or clauses.
>
> If a returned document matches multiple query clauses, the dis_max query assigns the document the highest relevance score from any matching clause, plus a tie breaking increment for any additional matching subqueries.

<!--more-->

The first part is pretty clear that the highest score of the matching clause will be used instead of the sum when the tie_breaker is not defined. The last part about “plus a tie breaking increment” is more unclear to me.

hmm… Let’s just try playing around with the queries on our machine and see what happens then.

Said we have docs:

```
"Doc 1": {
  "title": "iphone"
}
"Doc 2": {
  "body": "iphone"
}
"Doc 3": {
  "title": "iphone"
  "body": "iphone 13"
}
```

You might get the scores:

Doc 1: 0.54265 (Match “title”)

Doc 2: 0.54265 (Match “body”)

Doc 3: 0.54265 (Match both “title” and “body”, but only the max score will be taken.)

Since Doc 3 is more relevant than the other two, we might want Doc 3 to rank higher with a higher score. That’s why we need to also introduce **tie_breaker** here. If you add **tie_breaker=0.7** in the above query. The scores will become:

Doc 1: 0.54265 + 0*0.7 = 0.54265

Doc 2: 0.54265 + 0*0.7 = 0.54265

Doc 3: 0.54265 + 0.43211*0.7 = 0.84513

Now Doc 3 has a higher score than the other two when it also adds up the other clause(“body”: “iphone 13”) matching score.

We can see where the formula from by peaking at the [Lucene’s source code](https://github.com/apache/lucene/blob/3a80968ddf30293ddf55c62f8f2f8a6915028408/lucene/core/src/java/org/apache/lucene/search/DisjunctionMaxQuery.java#L182-L192)(Line 2):

``` java {linenos=table, hl_lines=2, linenostart=1}
if (match) {
  final float score = (float) (max + otherSum * tieBreakerMultiplier);
  final String desc =
      tieBreakerMultiplier == 0.0f
          ? "max of:"
          : "max plus " + tieBreakerMultiplier + " times others of:";
  return Explanation.match(score, desc, subs);
} else {
  return Explanation.noMatch("No matching clause");
}
```