---
layout:     post 
title:      "[Elasticsearch] Function score query"
subtitle:   ""
description: ""
date:       2022-01-07 12:00:00
image: "https://img.zhaohuabing.com/post-bg-2015.jpg"
published: true
tags:
    - Elasticsearch
URL: ""
categories: [ Tech ]
---

By reading the official document of the [Function score query](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-function-score-query.html#function-weight), I still couldn't get a sense of how to use it correctly. After reading through more articles written by others, here's how I interpret it with the formula of the newly computed score:

```
function_score = min(score_mode(f1_score, f2_score, ...), max_boost)
_score = boost_mode(boost*query_score, function_score)
```

Example 1:
``` json
{
  "query": {
      "function_score": {
        "query": { "match_all": {} },
        "boost": "5",
        "random_score": {}, 
        "boost_mode": "multiply"
      }
   }
}
```

Score:
```
function_score = min(random_score, FLT_MAX)
_score = 5*1 * function_score
_score = 5*1 * [0..1]
```

1. Since we didn't specify the **max_boost** so the default value will be **FLT_MAX**.

Example 2:
``` json
{
  "query": {
    "function_score": 
      "query": {
        "match_all": {}
      },
      "boost": "5",
      "functions": [
        {
          "filter": {
            "match": {
              "test": "bar"
            }
          },
          "random_score": {},
          "weight": 23
        },    
        {
          "filter": {
            "match": {
              "test": "cat"
            }
          },
          "weight": 42
        }
      ],
      "max_boost": 42,
      "score_mode": "sum",
      "boost_mode": "multiply",
      "min_score": 42
    }
  }
}
```

Score:
```
function_score = min(weight1*random_score*ifMatch + weight2*ifMatch, 42)
_score = 5*1 * function_score
_score = 5*1 * (23*random_score*ifMatch + 42*ifMatch)
```

