import 'package:children_now/components/courses/card_course.dart';
import 'package:children_now/models/course.dart';
import 'package:children_now/providers/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageHistory extends StatelessWidget {
  const PageHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      backgroundColor: const Color(0xffCAC4C7),
      appBar: AppBar(
        backgroundColor: const Color(0xff666264),
        title: const Text('Cursos vistos'),
      ),
      body: appState.currentUser!.refsCourcesSeen!.isEmpty
          ? const Center(
              child: Text(
                'Aún no has visto cursos',
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              children: [
                ...appState.currentUser!.refsCourcesSeen!
                    .map((e) => FutureBuilder<Course?>(
                        future: Course.getCourse(e),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const CupertinoActivityIndicator();
                          }
                          return CardCourse(course: snapshot.data!);
                        }))
              ],
            ),
    );
  }
}
