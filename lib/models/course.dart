import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  final DocumentReference reference;
  final String photo;
  final String name;
  final String description;
  final bool containsCertified;
  final String nameTeacher;
  final num stars;
  final num price;
  final int reviews;
  final DateTime createdAt;

  Course(
      {required this.reviews,
      required this.createdAt,
      required this.reference,
      required this.stars,
      required this.price,
      required this.photo,
      required this.name,
      required this.description,
      required this.containsCertified,
      required this.nameTeacher});

  static Course? _fromSnapshot(DocumentSnapshot snapshot) {
    try {
      return Course(
          reference: snapshot.reference,
          reviews: snapshot.get('reviews'),
          createdAt: DateTime.fromMillisecondsSinceEpoch(
              snapshot.get('createdAt').millisecondsSinceEpoch),
          stars: snapshot.get('stars'),
          price: snapshot.get('price'),
          photo: snapshot.get('photo'),
          name: snapshot.get('name'),
          description: snapshot.get('description'),
          containsCertified: snapshot.get('containsCertified'),
          nameTeacher: snapshot.get('nameTeacher'));
    } catch (e) {
      return null;
    }
  }

  static Future<Course?> getCourse(DocumentReference reference) async {
    return _fromSnapshot(await reference.get());
  }

  static Future<List<Course>> getAllCourses() async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('courses')
        .orderBy('stars', descending: true)
        .get();
    return _queryToList(query);
  }

  static Future<List<Course>> getAllNewCourses() async {
    DateTime time = DateTime.now();
    time.subtract(const Duration(days: 90));
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('courses').where('createdAt', isGreaterThan: time)
        .orderBy('stars', descending: true)
        .get();
    return _queryToList(query);
  }

  static List<Course> _queryToList(QuerySnapshot query) {
    List<Course> res = [];
    for (var element in query.docs) {
      Course? tmp = _fromSnapshot(element);
      if (tmp != null) {
        res.add(tmp);
      }
    }
    return res;
  }
}
