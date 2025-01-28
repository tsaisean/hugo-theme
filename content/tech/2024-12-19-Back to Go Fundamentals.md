---
layout:     post 
title:      "Back to Go Fundamentals"
subtitle:   ""
description: ""
date:       2024-12-19 12:00:00
image: "https://img.zhaohuabing.com/post-bg-2015.jpg"
tags:
    - Go
URL: ""
categories: [ Tech ]
ShowToc: true
---

# 1. Built-in Types

Go has a set of built-in types that include:
1. Boolean Type:
    - bool
2. Numeric Types:
    - Integer types: int, int8, int16, int32, int64
    - Unsigned integer types: uint, uint8 (alias byte), uint16, uint32, uint64, uintptr
3. Floating-point types: float32, float64
4. Complex numbers: complex64, complex128
5. String Type: string
6. Alias Types:
    - byte (alias for uint8)
    - rune (alias for int32, used for Unicode code points)

These types are often compared to primitive types in other languages (like Java or Python), as they form the foundation of data types in Go.

## int 
- On 32-bit systems: int is equivalent to int32.
- On 64-bit systems: int is equivalent to int64.
On modern computers, using int is typically sufficient for most applications.

There are two useful constant `math.MaxInt` and `math.MinInt` in the `math` package.

### Integer arrays - Fixed Size, Default Values
**Declaring and Initializing Integer Arrays**
**1. Fixed Size, Default Values**
``` go
var arr [5]int // An array of 5 integers
fmt.Println(arr) // Output: [0 0 0 0 0]
```
**2. With Initial Values**
``` go
arr := [5]int{1, 2, 3, 4, 5}
fmt.Println(arr) // Output: [1 2 3 4 5]
```
**3. Letting Go Infer the Size**
``` go
arr := [...]int{1, 2, 3}
fmt.Println(arr) // Output: [1 2 3]
```
**Multidimensional Arrays**
``` go
var matrix [2][3]int
matrix[0][1] = 5
matrix[1][2] = 10

fmt.Println(matrix) // Output: [[0 5 0] [0 0 10]]
```

Or initialize with values:

``` go
matrix := [2][3]int{
    {1, 2, 3},
    {4, 5, 6},
}
fmt.Println(matrix)
```

## Arithmetic operators
In Go, arithmetic operators (+, -, *, /) only work on operands of the same type. This is unlike some other programming languages, such as Java, which allow implicit type conversion (widening) for certain arithmetic operations. In Go, you need to explicitly convert types to match before performing arithmetic.

**Error When Mixing Types:**
``` go
var a int = 5
var b int32 = 10
// fmt.Println(a + b) // Compilation error: mismatched types int and int32
 ```
 **Fix by Explicit Type Conversion**
``` go
var a int = 5
var b int32 = 10

// Convert int to int32 or int32 to int
fmt.Println(a + int(b))  // Output: 15
fmt.Println(int32(a) + b) // Output: 15
```

## string 
### How to update a string?
**1. Replace a Character or Substring**
``` go
str := "hello world"

// Replace 'world' with 'Go'
newStr := strings.Replace(str, "world", "Go", 1)
fmt.Println(newStr) // Output: hello Go

```

**2. Modify a String by Converting to a Slice of Runes**
``` go
str := "hello world"

// Convert string to a slice of runes
runes := []rune(str)

// Modify the first character
runes[0] = 'H'

// Convert back to string
newStr := string(runes)
fmt.Println(newStr) // Output: Hello world

```

**Why Use []rune?**
- Strings in Go are sequences of bytes, but some characters (e.g., Unicode characters) may occupy multiple bytes.
- Using []rune ensures you correctly handle multi-byte characters.

**3. Concatenate Strings**
``` go
str := "hello"
newStr := str[:3] + "p!" // Take the first 3 characters and append "p!"
fmt.Println(newStr)      // Output: help!

```

**4. Use strings.Builder for Efficient String Updates**
If you need to perform multiple updates to a string (e.g., in a loop), use `strings.Builder` for better performance.
``` go
var builder strings.Builder

// Append parts of the string
builder.WriteString("hello")
builder.WriteString(" ")
builder.WriteString("Go")

fmt.Println(builder.String()) // Output: hello Go
```

**5. Replace Multiple Characters**
To replace multiple characters or substrings, use a loop or the `strings.ReplaceAll` function.
``` go
str := "hello world world"
newStr := strings.ReplaceAll(str, "world", "Go")
fmt.Println(newStr) // Output: hello Go Go
```

**6. Add or Remove Parts of a String**
Use slicing to extract parts of the string and create a new one.
``` go
str := "hello world"

// Insert "beautiful " after "hello "
newStr := str[:6] + "beautiful " + str[6:]
fmt.Println(newStr) // Output: hello beautiful world
```

### How to iterate through string?
**1. Iterate by Bytes**
You can iterate over the **bytes** of a string using a simple for loop.
 ``` go
str := "hello"

for i := 0; i < len(str); i++ {
    fmt.Printf("Byte at index %d: %d (char: %c)\n", i, str[i], str[i])
}
```
or 
``` go
str := "hello 世界"
bytes := []byte(str)

for i, b := range bytes {
    fmt.Printf("Byte index: %d, Byte value: %d (char: %c)\n", i, b, b)
}
```

**2. Iterate by Runes** 
To properly handle Unicode characters (e.g., multi-byte characters like π, 你好), you should iterate over the string as **runes** using the for range loop.
 ``` go
str := "hello 世界"

for i, r := range str {
    fmt.Printf("Index: %d, Rune: %c, Unicode: %U\n", i, r, r)
}
```

or 

``` go
str := "hello 世界"
runes := []rune(str)

for i, r := range runes {
    fmt.Printf("Rune index: %d, Rune value: %c, Unicode: %U\n", i, r, r)
}
```

### How to convert byte to int?
``` go
var b byte = '5' // ASCII value for '5' is 53
digit := int(b - '0') // Convert to its numeric value
fmt.Println("Digit:", digit) // Output: Digit: 5
```

## map
A map is a built-in data type that represents a collection of key-value pairs. Maps are highly flexible and efficient for fast lookups, inserts, and deletions.

**1. Declaring and Initializing a Map**
**Using make**
``` go
m := make(map[string]int) // Map with string keys and int values
```

**Using a Map Literal**
``` go
m := map[string]int{
    "Alice": 25,
    "Bob":   30,
}
```

**2. Adding or Updating Key-Value Pairs**
``` go
m := make(map[string]int)

// Adding key-value pairs
m["Alice"] = 25
m["Bob"] = 30

fmt.Println(m) // Output: map[Alice:25 Bob:30]

// Updating a value
m["Alice"] = 26
fmt.Println(m["Alice"]) // Output: 26
```

**3. Check if a Key Exists**
``` go
value, ok := m["Charlie"]
if ok {
    fmt.Println("Value:", value)
} else {
    fmt.Println("Key does not exist")
}
```

**4. Deleting a Key**
``` go
delete(m, "Alice") // Deletes the key "Alice"
fmt.Println(m) // Output: map[Bob:30]
```

**5. Iterating Over a Map**
``` go
m := map[string]int{
    "Alice": 25,
    "Bob":   30,
    "Eve":   35,
}

for key, value := range m {
    fmt.Printf("Key: %s, Value: %d\n", key, value)
}
```

**6. Nested Map (2D Map)**
``` go
nestedMap := make(map[string]map[string]int)

nestedMap["group1"] = make(map[string]int) // If assign before allocating the memory will cause run-time panic!
nestedMap["group1"]["Alice"] = 25

fmt.Println(nestedMap) // Output: map[group1:map[Alice:25]]
```

**7. set**
Go does not have a built-in set type like Python or Java, but you can implement a set using a map with struct{} or bool as the value. The map keys represent the unique elements of the set.
``` go
set := make(map[string]bool)
```

# 2. slice - Dynamic alternative to arrays
**slice** is a more powerful, flexible, and dynamic alternative to arrays. While an array has a fixed size, a slice can grow or shrink as needed. Slices are built on top of arrays and provide more convenient and dynamic functionality.
**1. Using make**
``` go
slice := make([]int, 5) // Creates a slice of length 5 with zero values
fmt.Println(slice)      // Output: [0 0 0 0 0]
```

**2. Using a Slice Literal**
``` go
slice := []int{1, 2, 3, 4, 5} // To note that it's a slice if no size declared
fmt.Println(slice) // Output: [1 2 3 4 5]
```

**3. Creating a Slice from an Array**
``` go
arr := [5]int{1, 2, 3, 4, 5}
slice := arr[1:4] // Creates a slice from index 1 to 3 (excluding 4)
fmt.Println(slice) // Output: [2 3 4]
```

**4. Adding Elements to a Slice**
``` go
slice := []int{1, 2, 3}
slice = append(slice, 4, 5) // Append elements to the slice
fmt.Println(slice)          // Output: [1 2 3 4 5]
```

**5. Appending Another Slice**
You can use **...** to append all elements from another slice.
``` go
a := []int{1, 2, 3}
b := []int{4, 5, 6}
a = append(a, b...) // Append all elements from b
fmt.Println(a)      // Output: [1 2 3 4 5 6]
```

**6. Multi-Dimensional Slices**
``` go
matrix := [][]int{
    {1, 2, 3},
    {4, 5, 6},
    {7, 8, 9},
}
fmt.Println(matrix[1][2]) // Output: 6 (Second row, third column)
```

# 3. Switch
**switch** statement is a powerful and flexible control structure used for conditional branching. It’s more concise and readable than multiple if-else statements and offers several unique features compared to other programming languages.

``` go
day := 3

switch day {
case 1:
    fmt.Println("Monday")
case 2:
    fmt.Println("Tuesday")
case 3:
    fmt.Println("Wednesday")
default:
    fmt.Println("Unknown day")
}
```

- In Go, each case is **automatically terminated** after its block is executed.
- Unlike other languages like C or Java, you don’t need a break to prevent fallthrough.

**1. Multiple Values in a Case**
You can match multiple values in a single case by separating them with commas.
``` go
letter := "A"

switch letter {
case "A", "E", "I", "O", "U":
    fmt.Println("It's a vowel")
default:
    fmt.Println("It's a consonant")
}
```

**2. Switch Without an Expression**
``` go
num := 15

switch {
case num < 10:
    fmt.Println("Less than 10")
case num < 20:
    fmt.Println("Less than 20")
default:
    fmt.Println("20 or more")
}
```

**3. Type Switch**
A type switch is used to branch based on the type of an interface value.
```go
var i interface{} = "hello"

switch v := i.(type) {
case int:
    fmt.Printf("Integer: %d\n", v)
case string:
    fmt.Printf("String: %s\n", v)
default:
    fmt.Println("Unknown type")
}
```

**4. Switch with Functions**
``` go
num := 6

switch square(num) {
case 1:
    fmt.Println("Square is 1")
case 36:
    fmt.Println("Square is 36")
default:
    fmt.Println("Square is something else")
}
```

**5. Fallthrough (Not very useful IMO)**
Use the **fallthrough** keyword to explicitly allow execution to “fall through” to the next case.
``` go
num := 2

switch num {
case 1:
    fmt.Println("One")
case 2:
    fmt.Println("Two")
    fallthrough
case 3:
    fmt.Println("Three")
default:
    fmt.Println("Default case")
}
```

# 4. Function 
**1. Function with Mutilple Return Values**
Functions can return multiple values. **( )** is required for returning multiple values.

``` go
func divide(a int, b int) (int, int) {
    quotient := a / b
    remainder := a % b
    return quotient, remainder
}

func main() {
    q, r := divide(10, 3)
    fmt.Printf("Quotient: %d, Remainder: %d\n", q, r)
}
```

Or you can name the return values and omit them in the return statement.

``` go
func divide(a int, b int) (quotient int, remainder int) {
...
}
```

**2. Variadic Functions**

``` go
func sum(nums ...int) int {
    total := 0
    for _, num := range nums {
        total += num
    }
    return total
}

func main() {
    result := sum(1, 2, 3, 4, 5)
    fmt.Println("Sum:", result) // Output: Sum: 15
}
```

**3. Anonymous Functions**
Assign to Variable:
``` go
func main() {
    greet := func(name string) {
        fmt.Printf("Hello, %s!\n", name)
    }

    greet("Bob") // Output: Hello, Bob!
}
```
Immediately Invoked:
``` go
func main() {
    func(name string) {
        fmt.Printf("Welcome, %s!\n", name)
    }("Alice") // Output: Welcome, Alice!
}
```

**4. Higher-Order Functions**
Functions can take other functions as arguments or return functions.
**Function as Argument:**
``` go
func applyOperation(a, b int, operation func(int, int) int) int {
    return operation(a, b)
}

func add(x, y int) int {
    return x + y
}

func main() {
    result := applyOperation(5, 3, add)
    fmt.Println("Result:", result) // Output: Result: 8
}
```
**Returning a Function**
``` go
func multiplier(factor int) func(int) int {
    return func(value int) int {
        return factor * value
    }
}

func main() {
    double := multiplier(2)
    fmt.Println(double(5)) // Output: 10
}
```

# 5. Pointers
Pointers in Go are used to store the memory address of a value. They are a powerful feature that allows you to work with memory directly, pass references to functions, and modify values without copying.

**1. Declaring and Using Pointers**
``` go
var p *int // A pointer to an int
```

**2. Assigning a Pointer**
``` go
var x int = 10
var p *int = &x // Pointer to x

fmt.Println("Value of x:", x)       // Output: 10
fmt.Println("Address of x:", &x)   // Memory address
fmt.Println("Value of p:", p)      // Memory address stored in p
fmt.Println("Value at p:", *p)     // Output: 10 (dereferencing)
```

**3. Pointers with Functions**
You can pass a pointer(**Passing by Reference**) to a function to allow it to modify the original variable.
``` go

// Function that modifies the value of x through a pointer
func updateValue(p *int) {
    *p = 50
}

func main() {
    x := 10
    fmt.Println("Before:", x)

    updateValue(&x) // Pass the address of x
    fmt.Println("After:", x) // Output: 50
}
```

**4. Common Use Cases for Pointers**
Avoid Copying Large Data Structures: Use pointers to pass large structs or arrays to functions efficiently.
``` go
func modifyStruct(p *LargeStruct) {
    p.Field = "Updated"
}
```

**5. Automatic Dereferencing**
Go automatically dereferences the pointer for you when you access a field or method of a struct or slice through a pointer. This is called automatic dereferencing.
``` go
type Point struct {
    X, Y int
}

func (p *Point) Update() {
    p.X = 10 // Simplified syntax
    (*p).Y = 20 // Explicit dereferencing, but unnecessary
}
```
Pointer to a Slice:

``` go
slice := []int{1, 2, 3}  // A slice
ptr := &slice            // Pointer to the slice

// Access elements directly via pointer (automatic dereferencing)
fmt.Println((*ptr)[0]) // Output: 1
fmt.Println(ptr[0])    // This works the same way in Go (automatic dereferencing)

// Modify elements via pointer
(*ptr)[0] = 42
fmt.Println(slice) // Output: [42 2 3]
```

**6. No Automatic Dereferencing for Arrays**
In Go, a pointer to an array (*[N]T) does not support automatic dereferencing when accessing elements. You need to explicitly dereference the array pointer to access or modify its elements.
``` go
arr := [3]int{1, 2, 3}  // Array of size 3
ptr := &arr             // Pointer to the array

// Accessing elements via pointer requires explicit dereferencing
fmt.Println((*ptr)[0]) // Output: 1

// Modifying elements via pointer
(*ptr)[0] = 42
fmt.Println(arr) // Output: [42 2 3]

// This won't work: ptr[0] // Compile error: invalid operation
```

# 6. Goruntine
A goroutine in Go is a lightweight, concurrent thread of execution. Goroutines make it easy to write programs that perform multiple tasks simultaneously without the complexity of traditional thread management.
- Goroutines are managed by the Go runtime, not the operating system.
- They are extremely lightweight compared to traditional threads, with minimal memory overhead (~2KB).
- Goroutines share the same address space and communicate via channels or shared variables.

**1. How to Start a Goroutine**
``` go
func sayHello() {
    fmt.Println("Hello from goroutine!")
}

func main() {
    go sayHello() // Start the goroutine
    fmt.Println("Hello from main!")

    // Allow time for the goroutine to finish
    time.Sleep(1 * time.Second)
}
```

**2. Anonymous Function Goroutines:**
``` go
func main() {
    go func() {
        fmt.Println("Hello from anonymous goroutine!")
    }()

    time.Sleep(1 * time.Second) // Allow goroutine to finish
}
```

**3. Synchronizing Goroutines**
Using **sync.WaitGroup**. The sync.WaitGroup is used to wait for multiple goroutines to finish.

``` go
func sayHello(id int, wg *sync.WaitGroup) {
    defer wg.Done() // Mark goroutine as done
    fmt.Printf("Hello from goroutine %d!\n", id)
}

func main() {
    var wg sync.WaitGroup

    for i := 1; i <= 3; i++ {
        wg.Add(1) // Increment WaitGroup counter
        go sayHello(i, &wg)
    }

    wg.Wait() // Wait for all goroutines to finish
    fmt.Println("All goroutines are done!")
}
```

**4. Communication Between Goroutines - Channels**
Goroutines communicate using **channels**, which are safe for concurrent access.
``` go 
func sendMessage(ch chan string) {
    ch <- "Hello from goroutine!" // Send message to the channel
}

func main() {
    ch := make(chan string) // Create a channel

    go sendMessage(ch)       // Start the goroutine
    msg := <-ch              // Receive message from the channel

    fmt.Println(msg) // Output: Hello from goroutine!

}
```

**5. Buffered Channels**
Channels can be buffered, allowing goroutines to send multiple messages without waiting for immediate reception.
``` go
func main() {
    ch := make(chan int, 2) // Buffered channel with capacity 2

    ch <- 1
    ch <- 2

    fmt.Println(<-ch) // Output: 1
    fmt.Println(<-ch) // Output: 2
}
```

**6. Read-Only  and write-only channels**

``` go
func receiveMessages(ch <-chan string) {
    for msg := range ch {
        fmt.Println("Received:", msg)
    }

    // ch <- "Message" // Compile error: cannot send to read-only channel
}
```

``` go
func sendMessages(ch chan<- string) {
    ch <- "Hello"
    ch <- "World"

    // msg := <-ch // Compile error: cannot receive from write-only channel
}
```