import 'package:children_now/components/courses/card_course.dart';
import 'package:children_now/models/course.dart';
import 'package:flutter/material.dart';

class PageNotifications extends StatelessWidget {
  const PageNotifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffCAC4C7),
      appBar: AppBar(
        backgroundColor: const Color(0xff666264),
        title: const Text('Cursos con menos de 3 meses'),
      ),
      body: FutureBuilder<List<Course>>(
          future: Course.getAllCourses(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                  child: Text(
                'Ha ocurrido un error',
                style: TextStyle(fontSize: 20),
              ));
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data!.isEmpty) {
              return const Center(
                  child: Text('No hay cursos aún',
                      style: TextStyle(fontSize: 20)));
            }
            return Scrollbar(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                children: [
                  ...snapshot.data!
                      .where((element) =>
                          element.createdAt.isAfter((DateTime.now().subtract(const Duration(days: 90)))))
                      .map((e) => CardCourse(course: e))
                ],
              ),
            );
          }),
    );
  }
}
