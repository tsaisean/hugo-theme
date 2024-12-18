---
layout:     post 
title:      "How To Get A List Of Sheet Names In Google Sheets With Script?"
subtitle:   ""
description: ""
date:       2022-01-28 12:00:00
image: "https://img.zhaohuabing.com/post-bg-2015.jpg"
tags: ["Google Sheets", "App Script"]
URL: ""
categories: [ Tech ]
---

There's no built-in formula to do this, and we have to write our own script with Google's Apps Script to achieve the function.

1. First, go to the Extensions → Apps Script.
![](/img/tech/2022-05-26/1.png)

2. Second, write our own method getSheetsName in the Apps Script console, and save.


![](/img/tech/2022-05-26/2.png)

Code snippets:
``` js
function getSheetsName() {
var sheetNames = new Array()
var sheets = SpreadsheetApp.getActiveSpreadsheet().getSheets();
for (var i=0 ; i<sheets.length ; i++) {
sheetNames.push( [ sheets[i].getName() ] )
}
return sheetNames
}
```
Then go back to your sheet, and type the formula with the function name we just created in the Apps Script.

![](/img/tech/2022-05-26/3.png)

Finally, you can see the result shown below. 🎉
![](/img/tech/2022-05-26/4.png)