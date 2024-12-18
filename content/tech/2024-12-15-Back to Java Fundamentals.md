---
layout:     post 
title:      "Back to Java Fundamentals"
subtitle:   ""
description: ""
date:       2024-12-01 12:00:00
image: "https://img.zhaohuabing.com/post-bg-2015.jpg"
tags:
    - Java
URL: ""
categories: [ Tech ]
ShowToc: true
---

# 1. Types
| **Type**   | **Size (Bits)** | **Default Value** | **Range**                        | **Example**              |
|------------|-----------------|-------------------|----------------------------------|--------------------------|
| `byte`     | 8               | 0                 | -128 to 127                     | `byte b = 10;`           |
| `short`    | 16              | 0                 | -32,768 to 32,767               | `short s = 100;`         |
| `int`      | 32              | 0                 | -2,147,483,648 to 2,147,483,647 | `int i = 12345;`         |
| `long`     | 64              | 0L                | -2^63 to (2^63)-1               | `long l = 123456L;`      |
| `float`    | 32              | 0.0f              | ~7 decimal digits               | `float f = 3.14f;`       |
| `double`   | 64              | 0.0d              | ~16 decimal digits              | `double d = 3.14;`       |
| `char`     | 16              | '\u0000'          | 0 to 65,535 (Unicode)           | `char c = 'A';`          |
| `boolean`  | 1 bit (logical) | `false`           | `true` or `false`               | `boolean b = true;`      |
## 1.1 Common Errors and Pitfalls
### Numeric Overflow
- Cause: Exceeding the range of a numeric type.
- Example:
   ``` Java
   byte b = 127;
   b++; // Wraps to -128
   ```
### Uninitialized Variables
- Cause: Using a local variable without initializing it.
- Example:
   ``` Java
   int x;
   System.out.println(x); // Compilation Error
   ```
### Missing Type Parameters
- Cause: Not specifying type parameters in generics, leading to runtime issues.
- Example:
   ``` Java
   List list = new ArrayList(); // Raw type, can cause ClassCastException
   list.add(123);
   String str = (String) list.get(0); // Fails at runtime
   ```
### 1.2 String

``` Java
public class Test {
    public static void main(String[] args) {
        String s1 = "Hello";
        String s2 = "Hello";
        String s3 = new String("Hello");

        System.out.println(s1 == s2); // true
        System.out.println(s1 == s3); // false
    }
}
```

1. s1 == s2:
   - Both s1 and s2 reference the same string literal "Hello", which is stored in the string pool.
   - Since both variables point to the same object in memory, s1 == s2 evaluates to true.
2. s1 == s3:
   - s3 is created with the new keyword, which creates a new object in memory, even though it has the same content as s1. 
   - Since s1 and s3 refer to different objects, s1 == s3 evaluates to false.

### 1.3 Order of Operations
- Java follows operator precedence:
  - Pre/Post-Increment and Decrement (x++, --y) are evaluated first.
  - Multiplication Divide (* /) is evaluated next.
  - Addition Deduction (+ -) is evaluated last.

**Example:**
``` Java
class Test {
    public static void main(String[] args) {
        int x = 5;
        int y = 10;
        int z = x++ + --y * x;
        System.out.println(z); // Output: 46
    }
}
```


# 2. Class
## 2.1 Inheritance
- Java does **not** support multiple inheritance with classes. A class can only extend **one superclass** at a time.
- This restriction avoids ambiguity problems caused by multiple inheritance, such as the **Diamond Problem**.
- In Java, when a class constructor is invoked, the constructor of its superclass is automatically called **before** the subclass constructor.


## 2.2 Access Modifiers (public/protected/private)
| **Modifier**   | **Class** | **Package** | **Subclass** | **World** |
|----------------|-----------|-------------|--------------|-----------|
| `public`       | ✔️        | ✔️          | ✔️           | ✔️        |
| `protected`    | ✔️        | ✔️          | ✔️           | ❌        |
| **(Default)**  | ✔️        | ✔️          | ❌           | ❌        |
| `private`      | ✔️        | ❌          | ❌           | ❌        |

- In Java, **default** visibility also called package-private.

## 2.3 Abstract Class
Abstract classes in Java **can have constructors**. However, you cannot directly instantiate an abstract class using the `new` keyword.

## 2.4 Inner Class
There are four main types of inner classes:
1. Non-Static Nested Classes (Regular Inner Classes)
   - To create an instance, an instance of the outer class is required:
     ``` Java
     Outer.Inner inner = outer.new Inner();
     ```

2. Static Nested Classes
    - Static nested classes can access only static members of the enclosing class.
    - No instance of the outer class is required to create an instance:
      ``` Java
      Outer.StaticNested nested = new Outer.StaticNested();
      ```
3. Local Inner Classes
    - Local inner classes are defined inside a method or block and are scoped to that block.
    - Can access final or effectively final variables of the enclosing method.
4. Anonymous Inner Classes
    - Anonymous inner classes are declared and instantiated simultaneously. 
    - Typically used for creating one-time implementations, especially with interfaces or abstract classes.
    - **Example:**
      ``` Java
      interface Greeting {
          void sayHello();
      }
      
      public class Main {
        public static void main(String[] args) {
            Greeting greeting = new Greeting() { // Anonymous Inner Class
                @Override
                public void sayHello() {
                    System.out.println("Hello from Anonymous Inner Class");
                }
            };
            greeting.sayHello(); // Output: Hello from Anonymous Inner Class
        }
      }
      ```
## 2.5 Static Methods
- Static methods are **not overridden**; they are instead **hidden** when redefined in a subclass.
- The method called is determined by the **type of the reference variable**, not the actual object type.
- This is because static methods are resolved at **compile-time**, not runtime.

``` Java
class Parent {
    public static void display() {
        System.out.println("Parent static method");
    }
}

class Child extends Parent {
    public static void display() {
        System.out.println("Child static method");
    }
}

public class Test {
    public static void main(String[] args) {
        Parent obj = new Child();
        obj.display(); // Output: Parent static method
    }
}

```

# 3. Interface & Method References
- Since **Java 8**, interfaces can define **static methods**.

## 3.1 Default Methods
Introduced in Java 8, default methods allow interfaces to have method implementations without breaking existing implementations of those interfaces.
``` Java
interface MyInterface {
    default void printMessage() {
        System.out.println("This is a default method.");
    }
}

class MyClass implements MyInterface {}

public class Main {
    public static void main(String[] args) {
        MyClass obj = new MyClass();
        obj.printMessage(); // Output: This is a default method.
    }
}

```

## 3.2 `@FunctionalInterface` Annotation
The `@FunctionalInterface` annotation is used in Java to mark an interface as a `functional interface`. A functional interface is an interface with exactly `one abstract method`, making it suitable for use with `lambda expressions`.
- The interface must have exactly one abstract method.
- It can have:
  - Default methods (introduced in Java 8).
  - Static methods.
  - Methods inherited from Object (like toString(), equals(), etc.).

**Examples:**
```Java
@FunctionalInterface
interface Greeting {
    void sayHello(String name); // Single abstract method
}

public class Main {
    public static void main(String[] args) {
        Greeting greeting = (name) -> System.out.println("Hello, " + name);
        greeting.sayHello("Alice"); // Output: Hello, Alice
    }
}
```

## 3.3 Method References
Method references were introduced in Java 8 as a shorthand for writing lambda expressions.

``` Java
import java.util.Arrays;

public class Main {
    public static void main(String[] args) {
        String[] names = {"Bob", "Alice", "John"};

        // Using a lambda expression
        Arrays.sort(names, (a, b) -> a.compareToIgnoreCase(b));

        // Using a method reference
        Arrays.sort(names, String::compareToIgnoreCase);

        System.out.println(Arrays.toString(names)); // Output: [Alice, Bob, John]
    }
}
```

# 4. Lambdas
Lambdas were also introduced in Java 8, enabling functional programming. A lambda expression is a concise way to represent a method in code.
```Java
List<String> names = Arrays.asList("Java", "Python", "C++");
names.forEach(name -> System.out.println(name));
```
Lambdas are commonly used in streams and functional interfaces.

# 5. Streams
Streams provide a functional approach to processing collections of data in Java 8 and later. 

Features:
- Operate on data declaratively (e.g., filter, map).
- Can be parallelized for performance.

```Java
List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5);
List<Integer> squared = numbers.stream()
                               .map(n -> n * n)
                               .collect(Collectors.toList());

System.out.println(squared); // Output: [1, 4, 9, 16, 25]
```

# 6. `transient` Keyword
The transient keyword is used in the context of serialization. When an object is serialized (converted to a byte stream), the transient keyword prevents certain fields from being included in the serialized data.

**Example:**
```Java
import java.io.*;

class User implements Serializable {
    private String username;
    private transient String password; // Excluded from serialization

    public User(String username, String password) {
        this.username = username;
        this.password = password;
    }

    @Override
    public String toString() {
        return "User{username='" + username + "', password='" + password + "'}";
    }
}

public class Main {
    public static void main(String[] args) throws Exception {
        User user = new User("Alice", "secret123");

        // Serialize the object
        ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream("user.ser"));
        oos.writeObject(user);
        oos.close();

        // Deserialize the object
        ObjectInputStream ois = new ObjectInputStream(new FileInputStream("user.ser"));
        User deserializedUser = (User) ois.readObject();
        ois.close();

        // Password is not serialized
        System.out.println(deserializedUser); // Output: User{username='Alice', password='null'}
    }
}

```

# 7. `volatile` Keyword
The volatile keyword is used in the context of multithreading. It ensures that a variable’s value is always read directly from main memory, making it visible to all threads. 

- Volatile Does Not Ensure Atomicity:
  - For operations like count++ (read-modify-write), use `synchronized` or `AtomicInteger`.


# 8. Other Noteworthy Java Features

## 8.1 var Keywords
Introduced in Java 10, var allows the compiler to infer the type of variables. For long or nested types, var reduces verbosity.
#### Rules and Characteristics of `var`
1. The type is determined by the compiler at compile time, not at runtime.
2. Works only with local variables (inside methods, constructors, etc.).
3. `var x = null`; is not allowed because the type cannot be inferred.
4. The variable must be initialized during declaration.

```Java
Map<String, List<Integer>> map = new HashMap<>();
// With var
var map = new HashMap<String, List<Integer>>();
```

## 8.2 Records
A Record is a special kind of class in Java used to store immutable data.
It automatically generates:
- Constructor for all fields.
- Getters for each field.
- `toString()`, `equals()`, and `hashCode()` implementations.

- Immutability is crucial for functional programming and thread safety. 
- With Records, all fields are final by default, ensuring immutability.
- Ideal for POJOs and Data Transfer Objects (DTOs).
- 

```Java
public record Point(int x, int y) {}
```
