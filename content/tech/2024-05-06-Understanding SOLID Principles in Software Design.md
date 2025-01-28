---
layout:     post 
title:      "Understanding SOLID Principles in Software Design"
subtitle:   ""
description: ""
date:       2024-05-06 12:00:00
image: "https://img.zhaohuabing.com/post-bg-2015.jpg"
tags:
    - CS Fundamentals
URL: ""
categories: [ "Tech" ]
ShowToc: true
---


In software development, writing maintainable, scalable, and robust code is a constant goal. The SOLID principles, introduced by Robert C. Martin, serve as a foundation for object-oriented design, guiding developers in building systems that are easier to extend and maintain over time. In this blog, we will explore each of the SOLID principles with examples.

## What are SOLID Principles?

SOLID is an acronym representing five design principles:

1. **S** - Single Responsibility Principle (SRP)
2. **O** - Open/Closed Principle (OCP)
3. **L** - Liskov Substitution Principle (LSP)
4. **I** - Interface Segregation Principle (ISP)
5. **D** - Dependency Inversion Principle (DIP)

Each principle addresses a specific aspect of software design to reduce complexity and improve code quality.

### 1. Single Responsibility Principle (SRP)

> "A class should have only one reason to change."

The Single Responsibility Principle focuses on ensuring that a class is responsible for only one functionality. This makes the class easier to understand, test, and maintain.

Example with Python:
``` Python
# Violating SRP
class Report:
    def generate_report(self):
        print("Generating report...")

    def save_to_file(self, filename):
        print(f"Saving report to {filename}")

# Adhering to SRP
class ReportGenerator:
    def generate(self):
        print("Generating report...")

class FileSaver:
    def save(self, filename):
        print(f"Saving report to {filename}")
```
By separating responsibilities, changes in one part (e.g., file-saving logic) won't affect other parts (e.g., report generation).

### 2. Open/Closed Principle (OCP)

> "Software entities should be open for extension but closed for modification."

The Open/Closed Principle ensures that new functionality can be added without altering existing code, reducing the risk of introducing bugs.

Example with Python:
``` Python
# Violating OCP
class DiscountCalculator:
    def calculate(self, customer_type, amount):
        if customer_type == "Regular":
            return amount * 0.9
        elif customer_type == "VIP":
            return amount * 0.8

# Adhering to OCP
class DiscountStrategy:
    def calculate(self, amount):
        return amount

class RegularDiscount(DiscountStrategy):
    def calculate(self, amount):
        return amount * 0.9

class VIPDiscount(DiscountStrategy):
    def calculate(self, amount):
        return amount * 0.8

# Usage
regular_discount = RegularDiscount()
vip_discount = VIPDiscount()
print(regular_discount.calculate(100))  # 90
print(vip_discount.calculate(100))      # 80
```

### 3. Liskov Substitution Principle (LSP)

> "Objects of a superclass should be replaceable with objects of a subclass without altering the correctness of the program."

The Liskov Substitution Principle ensures that subclasses extend the behavior of the base class without breaking its functionality.

Example with Python:
``` Python
# Violating LSP
class Rectangle:
    def __init__(self, width, height):
        self.width = width
        self.height = height

    def area(self):
        return self.width * self.height

class Square(Rectangle):
    def __init__(self, side):
        super().__init__(side, side)

# Adhering to LSP
class Shape:
    def area(self):
        pass

class Rectangle(Shape):
    def __init__(self, width, height):
        self.width = width
        self.height = height

    def area(self):
        return self.width * self.height

class Square(Shape):
    def __init__(self, side):
        self.side = side

    def area(self):
        return self.side * self.side
```
By separating Rectangle and Square as distinct shapes, their behavior aligns with their intended design.

Example with Go:
``` go
package main

import "fmt"

// Define an interface
type Bird interface {
	Fly()
}

// Sparrow satisfies Bird
type Sparrow struct{}

func (s Sparrow) Fly() {
	fmt.Println("Sparrow flying")
}

// Penguin also satisfies Bird syntactically but violates LSP
type Penguin struct{}

func (p Penguin) Fly() {
	fmt.Println("Penguins can't fly")
}

// Function expecting a Bird
func LetBirdFly(b Bird) {
	b.Fly()
}

func main() {
	sparrow := Sparrow{}
	penguin := Penguin{}

	LetBirdFly(sparrow) // Output: Sparrow flying
	LetBirdFly(penguin) // Output: Penguins can't fly
}
```

### Interface Segregation Principle (ISP)

> "Clients should not be forced to depend on interfaces they do not use."

This principle advocates for creating smaller, more focused interfaces rather than one large, general-purpose interface.

Example with Python:
``` python
# Violating ISP
class Printer:
    def print(self):
        pass

    def scan(self):
        pass

    def fax(self):
        pass

class BasicPrinter(Printer):
    def print(self):
        print("Printing...")

    def scan(self):
        raise NotImplementedError("Scan not supported")

    def fax(self):
        raise NotImplementedError("Fax not supported")

# Adhering to ISP
class Printable:
    def print(self):
        pass

class Scannable:
    def scan(self):
        pass

class Faxable:
    def fax(self):
        pass

class BasicPrinter(Printable):
    def print(self):
        print("Printing...")
```

### 5. Dependency Inversion Principle (DIP)

> "High-level modules should not depend on low-level modules. Both should depend on abstractions."

DIP promotes decoupling by relying on abstractions rather than concrete implementations.

Example with Python:
``` python
# Violating DIP
class Engine:
    def start(self):
        print("Engine started")

class Car:
    def __init__(self):
        self.engine = Engine()

    def drive(self):
        self.engine.start()

# Adhering to DIP
class Engine:
    def start(self):
        pass

class PetrolEngine(Engine):
    def start(self):
        print("Petrol engine started")

class Car:
    def __init__(self, engine: Engine):
        self.engine = engine

    def drive(self):
        self.engine.start()

# Usage
engine = PetrolEngine()
car = Car(engine)
car.drive()
```