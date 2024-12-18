---
layout:     post 
title:      "How to cherry-pick a commit from another git repository?"
subtitle:   ""
description: ""
date:       "2021-09-02 12:00:00"
image: "https://img.zhaohuabing.com/post-bg-2015.jpg"
tags:
    - Git
URL: ""
categories: [ Tech ]
---

``` bash
# Adding (as "other") the repo from we want to cherry-pick
$ git remote add other git://github.com/username/repo.git

# Fetch the "other" branch
$ git fetch other

# Cherry-pick the commit we need
$ git cherry-pick 0549522
```