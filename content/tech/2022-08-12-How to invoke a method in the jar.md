---
layout:     post 
title:      "How to invoke a method in the jar?"
subtitle:   ""
description: ""
keywords: "java, jar, URLClassLoader"
date:       2022-08-12 12:00:00
image: "https://img.zhaohuabing.com/post-bg-2015.jpg"
published: true
tags:
    - Java
URL: ""
categories: [ Tech ]
---

We can use [URLClassLoader](https://docs.oracle.com/javase/8/docs/api/java/net/URLClassLoader.html) to load classes from a given path.

``` java
      URL myJar = new File("jar/LibraryA-1.0-SNAPSHOT.jar").toURI().toURL();
      URLClassLoader clsLoader = new URLClassLoader(
              new URL[] {myJar},
              this.getClass().getClassLoader()
      );
      Class<?> loadedClass = clsLoader.loadClass("com.sean.liba.Main");
      Method method = loadedClass.getDeclaredMethod("print");
      Object instance = loadedClass.newInstance();
      method.invoke(instance);

      // Output: Hello World!
```

Let's look at other use cases. What if you have two jars, and **liba.jar** deppends on another class in the **libb.jar**?

![](/img/tech/2022-08-12/1.png) 

Take the above example, the `print` method has a dependency on the `com.sean.libb.Caculator` class.
If we dont't change the code, and run it again, you will get an error immediately.

```
Caused by: java.lang.NoClassDefFoundError: com/sean/lib/Calculator
```

To fix the issue, we need to include the path of the **libb.jar** for the URLClassLoader.
Following is the example:

``` java
      URL myJar = new File("jar/LibraryA-1.0-SNAPSHOT.jar").toURI().toURL();
      // Decalre the URL for the libb.jar
      URL myJar2 = new File("Application/jar/v1/LibraryB-1.0-SNAPSHOT.jar").toURI().toURL();
      URLClassLoader clsLoader = new URLClassLoader(
              new URL[] {myJar, myJar2},
              this.getClass().getClassLoader()
      );
      Class<?> loadedClass = clsLoader.loadClass("com.sean.liba.Main");
      Method method = loadedClass.getDeclaredMethod("print");
      Object instance = loadedClass.newInstance();
      method.invoke(instance);

      // Output: Hello World! and 1 + 1 = 2!
```

Another interesting question is what if I have another **libc.jar** depends on the **libb.jar**. and both **liba.jar** and **libc.jar** reference to a singleton class `Caculator`. How would the singleton `Caculator` behave? Do they share the same instance?

![](/img/tech/2022-08-12/2.png) 

The answer is it depends on how you use the `URLClassLoader`. If you load all the jar into the same `URLClassLoader`, then yes, both **liba.jar** and **libc.jar** will share the same intance of the singleton `Caculator`. But if you load **liba.jar** and **libc.jar** on the two difference `URLClassLoader`, then they will reference to seperate identical instnace of the singleton `Caculator`.

See the [full example](https://github.com/tsaisean/load-jar-example).
