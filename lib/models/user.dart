import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final DocumentReference reference;
  final String? name;
  final String email;
  final String? phone;
  final String? photo;
  List? refCources;
  List? refsCourcesSeen;

  User(
      {this.refsCourcesSeen,
      required this.refCources,
      required this.photo,
      required this.reference,
      required this.name,
      required this.email,
      required this.phone});

  Map<String, dynamic> get toMap {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'photo': photo
    };
  }

  static User? _fromSnapshot(DocumentSnapshot snapshot) {
    try {
      return User(
          reference: snapshot.reference,
          email: snapshot.get('email'),
          name: snapshot.get('name'),
          phone: snapshot.get('phone'),
          photo: snapshot.get('photo'),
          refCources: snapshot.get('refCources'),
          refsCourcesSeen: snapshot.get('refsCourcesSeen'));
    } catch (e) {
      return null;
    }
  }

  static Future<List> addCourse(
      User user, List<DocumentReference> references) async {
    List tmp = [];
    if (user.refCources != null) {
      tmp.addAll(user.refCources!);
    }
    tmp.addAll(references);
    await user.reference.update({'refCources': tmp});
    return tmp;
  }

  static Future<List> addSeenCourse(
      User user, DocumentReference reference) async {
    List tmp = [];
    if (user.refCources != null) {
      tmp.addAll(user.refCources!);
    }
    if (!tmp.contains(reference)) {
      tmp.add(reference);
      await user.reference.update({'refsCourcesSeen': tmp});
    }
    return tmp;
  }

  static Future<User?> createUser(String uid, String email, String? name,
      String? photo, String? phone) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'email': email,
      'name': name,
      'phone': phone,
      'photo': photo,
      'refCources': [],
      'refsCourcesSeen': []
    });
    return await getUser(uid);
  }

  static Future<void> updateUser(User user) async {
    await user.reference.update(user.toMap);
  }

  static Future<User?> getUser(String uidUser) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uidUser)
          .get();
      return _fromSnapshot(snapshot);
    } catch (e) {
      return null;
    }
  }
}
