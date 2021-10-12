import 'package:children_now/components/button_loading.dart';
import 'package:children_now/components/course_detail/description.dart';
import 'package:children_now/components/course_detail/header.dart';
import 'package:children_now/models/course.dart';
import 'package:children_now/providers/app_state.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class PageCourseDetail extends StatelessWidget {
  final Course course;
  const PageCourseDetail({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      backgroundColor: const Color(0xffCAC4C7),
      body: SafeArea(
        child: Scrollbar(
          child: ListView(
            children: [
              HeaderProduct(course: course),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ColumnDescription(
                      course: course,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8),
        child: ButtonLoading(
          title: appState.isCourseBought(course)
              ? 'Curso adquirido'
              : appState.isCourseOnOrder(course)
                  ? 'Eliminar de carrito'
                  : 'Agregar a carrito: ${course.price == 0 ? 'Gratis' : '\$${course.price}'}',
          function: () async {
            if (appState.isCourseBought(course)) {
              Fluttertoast.showToast(
                  msg: 'Curso adquirido, gracias por su compra.');
            } else {
              if (!appState.isCourseOnOrder(course)) {
                appState.addCourse(course);
                Fluttertoast.showToast(msg: 'Agregado a carrito');
              } else {
                appState.removeCourse(course);
                Fluttertoast.showToast(msg: 'Eliminado de carrito');
              }
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }
}
