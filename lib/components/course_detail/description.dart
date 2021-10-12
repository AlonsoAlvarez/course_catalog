import 'package:children_now/models/course.dart';
import 'package:children_now/utils/time.dart';
import 'package:flutter/material.dart';

import '../row_stars.dart';

class ColumnDescription extends StatelessWidget {
  final Course course;
  const ColumnDescription({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          course.name,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          course.description,
          style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
        ),
        const SizedBox(
          height: 5,
        ),
        const Divider(),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Instructor',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(course.nameTeacher,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w300)),
                ],
              ),
            ),
            RowStars(count: course.stars),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        const Divider(),
        const SizedBox(
          height: 5,
        ),
        const Text(
          'Cuando termines este curso',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(course.containsCertified? 'Recibirás un certificado oficial' : 'No recibirás certificado',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
        const SizedBox(
          height: 5,
        ),
        const Divider(),
        const SizedBox(
          height: 5,
        ),
        Text('Lanzado: ${Time.date(course.createdAt)}',
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
      ],
    );
  }
}
