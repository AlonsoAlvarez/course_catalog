import 'package:children_now/models/course.dart';
import 'package:children_now/models/order.dart';
import 'package:children_now/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  User? _currentUser;
  Order? _order;

  User? get currentUser => _currentUser;
  Order? get order => _order;

  set currentUser(User? user) {
    _currentUser = user;
    notifyListeners();
  }

  void setCoursesTosUser(List courses) {
    _currentUser!.refCources = courses;
    _order = null;
    notifyListeners();
  }

  void addCourceToSeen(DocumentReference reference) {
    if (!_currentUser!.refsCourcesSeen!.contains(reference)) {
      _currentUser!.refsCourcesSeen!.add(reference);
      notifyListeners();
    }
  }

  void addCourse(Course course) {
    _order ??= Order();
    _order!.addCourse(course);
    notifyListeners();
  }

  void removeCourse(Course course) {
    _order!.removeCourse(course);
    notifyListeners();
  }

  bool isCourseOnOrder(Course course) {
    if (order == null) {
      return false;
    } else {
      for (var i = 0; i < _order!.courses.length; i++) {
        if (_order!.courses[i].reference == course.reference) {
          return true;
        }
      }
      return false;
    }
  }

  bool isCourseBought(Course course) {
    if (_currentUser!.refCources == null) {
      return false;
    } else {
      for (var i = 0; i < _currentUser!.refCources!.length; i++) {
        if (_currentUser!.refCources![i] == course.reference) {
          return true;
        }
      }
      return false;
    }
  }

  bool get isCompetedRegisterUser {
    return (_currentUser!.phone != null && _currentUser!.name != null);
  }

  set order(Order? order) {
    _order = order;
    notifyListeners();
  }

  void logOut() {
    _currentUser = null;
  }
}
