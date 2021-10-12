import 'package:children_now/models/course.dart';
import 'package:children_now/models/user.dart';
import 'package:children_now/pages/course_detail.dart';
import 'package:children_now/providers/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../row_stars.dart';

class CardCourse extends StatelessWidget {
  final Course course;
  const CardCourse({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return InkWell(
      onTap: () {
        appState.addCourceToSeen(course.reference);
        User.addSeenCourse(appState.currentUser!, course.reference);
        Navigator.push<void>(
          context,
          CupertinoPageRoute<void>(
            builder: (BuildContext context) => PageCourseDetail(
              course: course,
            ),
          ),
        );
      },
      child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: Color(0xff666264))),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(course.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${course.description.substring(0, course.description.length < 56 ? course.description.length : 56)}${course.description.length < 56 ? '' : '...'}',
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                  width: 75,
                                  child: RowStars(count: course.stars)),
                              Text('${course.reviews} reviews',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400))
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                                course.containsCertified
                                    ? 'Certificado'
                                    : 'Sin Certificado',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: course.containsCertified
                                        ? Colors.green[900]
                                        : Colors.red[900])),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Hero(
                    tag: course.reference.id,
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/lab.png'),
                      image: NetworkImage(course.photo),
                      fit: BoxFit.cover,
                      height: 120,
                      width: 120,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
