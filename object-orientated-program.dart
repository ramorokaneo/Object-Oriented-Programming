import 'dart:io';

// Interface to calculate area
abstract class HasArea {
  double calculateArea(); // Add semicolon to terminate method signature
}

// Base class representing a shape
class Shape {
  String name;

  Shape(this.name);

  void printName() {
    print('Shape: $name');
  }
}

// Subclass representing a rectangle
class Rectangle extends Shape implements HasArea {
  double width;
  double height;

  Rectangle(String name, this.width, this.height) : super(name);

  @override
  double calculateArea() {
    return width * height;
  }
}

// Subclass representing a circle
class Circle extends Shape implements HasArea {
  double radius;

  Circle(String name, this.radius) : super(name);

  @override
  double calculateArea() {
    return 3.14 * radius * radius;
  }
}

void main() {
  // Initialize Rectangle and Circle objects with data from a file
  List<Shape> shapes = [];
  File file = File('shapes_data.txt');

  file.readAsLines().then((List<String> lines) {
    for (String line in lines) {
      List<String> parts = line.split(',');
      if (parts[0] == 'Rectangle') {
        shapes.add(Rectangle(parts[1], double.parse(parts[2]), double.parse(parts[3])));
      } else if (parts[0] == 'Circle') {
        shapes.add(Circle(parts[1], double.parse(parts[2])));
      }
    }

    // Print the names of shapes and their areas
    for (Shape shape in shapes) {
      shape.printName();
      if (shape is HasArea) {
        print('Area: ${shape.calculateArea()}');
      }
    }
  }).catchError((e) {
    print('Error reading file: $e');
  });
}
