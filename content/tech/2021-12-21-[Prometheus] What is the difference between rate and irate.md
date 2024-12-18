---
layout:     post 
title:      "[Prometheus] What is the difference between rate and irate"
subtitle:   ""
date:       2021-12-21 12:00:00
image: "https://img.zhaohuabing.com/post-bg-2015.jpg"
tags:
    - Prometheus
URL: ""
categories: [ Tech ]
---

Here are the definitions from the official document for [rate()](https://prometheus.io/docs/prometheus/latest/querying/functions/#rate) and [irate()](https://prometheus.io/docs/prometheus/latest/querying/functions/#irate). But if you still don’t quite understand, check the examples below.

In this example, I select all the values I have recorded within the last 1 minute for all time series that have the metric name prometheus_http_requests_total and a handler label set to /metrics:
```
prometheus_http_requests_total{handler=”/metrics”}[1m]
```
Output from the Prometheus UI:

```
# Element
prometheus_http_requests_total{code="200",handler="/metrics",instance="localhost:9090",job="prometheus"}
# ValueHere are the definitions from the official document for rate() and irate(). But if you still don’t quite understand, check the examples below.
```

In this example, I select all the values I have recorded within the last 1 minute for all time series that have the metric name prometheus_http_requests_total and a handler label set to /metrics:

```
prometheus_http_requests_total{handler=”/metrics”}[1m]
```
Output from the Prometheus UI:

```
# Element
prometheus_http_requests_total{code="200",handler="/metrics",instance="localhost:9090",job="prometheus"}
# Value
878 @1640020217.631
879 @1640020232.605
880 @1640020247.606
881 @1640020262.605
```

## rate()
Now let’s check what will we get when we apply the rate function.

rate(prometheus_http_requests_total{handler=”/metrics”}[1m])
Output from the Prometheus UI:
```
# Element
{code=”200",handler=”/metrics”,instance=”localhost:9090",job=”prometheus”}
# Value
0.06670520745319518
and here’s the equation taking the first and the last metric point:
```

![](/img/tech/2021-12-21/1.png)

## irate()
irate(prometheus_http_requests_total{handler="/metrics"}[1m])
Output from the Prometheus UI:

```
# Element
{code=”200",handler=”/metrics”,instance=”localhost:9090",job=”prometheus”}
# Value
0.06667111140742715
and here’s the equation and here’s the equation taking the last two metric points:
```

![](/img/tech/2021-12-21/2.png)

# Summary
That why the document points out:

> `irate` should only be used when graphing volatile, fast-moving counters. Use `rate` for alerts and slow-moving counters, as brief changes in the rate can reset the `FOR` clause and graphs consisting entirely of rare spikes are hard to read.