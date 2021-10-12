import 'package:children_now/models/course.dart';

class Order {
  List<Course> courses = [];

  num get price {
    num tmp = 0;
    for (var element in courses) {
      tmp += element.price;
    }
    return tmp;
  }

  void addCourse(Course course) {
    courses.add(course);
  }

  void removeCourse(Course course) {
    int index = 0;
    for (int i = 0; i < courses.length; i++) {
      index = i;
      break;
    }
    courses.removeAt(index);
  }

}