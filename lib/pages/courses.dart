import 'package:children_now/components/courses/card_course.dart';
import 'package:children_now/models/course.dart';
import 'package:children_now/pages/shopping_cart.dart';
import 'package:children_now/providers/app_state.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class PageCourses extends StatefulWidget {
  const PageCourses({Key? key}) : super(key: key);

  @override
  State<PageCourses> createState() => _PageCoursesState();
}

class _PageCoursesState extends State<PageCourses> {
  final _ctrlFilter = TextEditingController();

  @override
  void dispose() {
    _ctrlFilter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      backgroundColor: const Color(0xffCAC4C7),
      appBar: AppBar(
        backgroundColor: const Color(0xff666264),
        title: Text(_ctrlFilter.text.isEmpty
            ? 'Cursos y capacitaciones'
            : 'Filtro: ${_ctrlFilter.text}'),
        actions: [
          Stack(
            children: [
              IconButton(
                  onPressed: () {
                    if (appState.order != null) {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const PageShoppingCart(),
                        ),
                      );
                    } else {
                      Fluttertoast.showToast(
                          msg: 'No hay productos en el carrito');
                    }
                  },
                  icon: const Icon(
                    Icons.shopping_cart,
                    size: 30,
                  )),
              if (appState.order != null) ...[
                Positioned(
                    top: 5,
                    right: 5,
                    child: Container(
                      height: 14,
                      width: 14,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                    ))
              ]
            ],
          )
        ],
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
                      .where((element) => (_ctrlFilter.text.isNotEmpty
                          ? (element.name
                                  .toLowerCase()
                                  .contains(_ctrlFilter.text.toLowerCase()) ||
                              element.description
                                  .toLowerCase()
                                  .contains(_ctrlFilter.text.toLowerCase()) ||
                              element.nameTeacher
                                  .toLowerCase()
                                  .contains(_ctrlFilter.text.toLowerCase()))
                          : true))
                      .map((e) => CardCourse(course: e))
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          showDialog(
              context: context,
              builder: (builder) {
                return AlertDialog(
                  title: const Text('Filtrar busqueda'),
                  content: TextField(
                    controller: _ctrlFilter,
                    decoration: const InputDecoration(labelText: 'Todo'),
                  ),
                  actions: <Widget>[
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(primary: Colors.black),
                        onPressed: () async {
                          Navigator.pop(context);
                          setState(() {});
                        },
                        icon: const Icon(Icons.search),
                        label: const Text(
                          'Filtrar',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                );
              });
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
