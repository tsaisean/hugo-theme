---
layout:     post 
title:      "[Elasticsearch] How to use minimum_should_match and operator with match query?"
subtitle:   ""
description: ""
date:       2022-05-26 12:00:00
image: "https://img.zhaohuabing.com/post-bg-2015.jpg"
tags:
    - Elasticsearch
URL: ""
categories: [ Tech ]
---

``` json
GET /_search
{
  "query": {
    "match": {
      "message": {
        "query": "this is a test yo",
        // "operator": "or"
      }
    }
  }
}
```

This is the Match query we see quite often when using ES. However, if you did specify an analyzer during mapping, the query “this is a test yo" will likely be tokenized into five terms ”**this**”, “**is**”, “**a**”, “**test**”, and “**yo**” in the search phases. And there is an implicit parameter **operator**, and its default value is “**or**”. This means, this query will look up the documents in the index, and whenever there is any term match in the message of a doc, then that it’s a match!

<!--more-->

Here comes the problems. What if I want a match when all the terms can be found in the message? or if I want a match when there are at least 75% of terms can be found in the message?


The first problem can be easily resolved by setting the operator value to “and”. As for the second problem, here comes another parameter minimum_should_match that we can use to solve it.

minimum_should_match supports a few types:

1. Integer: 3
2. Negative Integer: -2
3. Percentage: 75%
4. Negative Percentage: -25%

You can read the official document for the detailed description. Here I’m going to share the examples with you directly. I believe you can already guess what Integer is so I’ll just talk about the Percentage.

``` json
GET /_search
{
  "query": {
    "match": {
      "message": {
        "query": "this is a test yo",
        "minimum_should_match": "75%"
      }
    }
  }
}
```

- Percentage: 75%

floor(5 terms x 0.75) = 3 terms ← At least three terms should match!

- Negative Percentage: -25%

5 - floor(5 terms x 0.25) = 4 terms ← At least four terms should match!

This is it. Hope you got it. 👋

