import 'package:children_now/components/button_loading.dart';
import 'package:children_now/components/courses/card_course.dart';
import 'package:children_now/models/profile.dart';
import 'package:children_now/models/user.dart';
import 'package:children_now/providers/app_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class PageShoppingCart extends StatelessWidget {
  const PageShoppingCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      backgroundColor: const Color(0xffCAC4C7),
      appBar: AppBar(
        backgroundColor: const Color(0xff666264),
        title: const Text('Carrito'),
      ),
      body: (appState.order == null || appState.order!.courses.isEmpty)
          ? const Center(
              child: Text('No hay coursos en el carrito'),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              children: [
                ...appState.order!.courses.map((e) => CardCourse(
                      course: e,
                    ))
              ],
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8),
        child: ButtonLoading(
          title: appState.isCompetedRegisterUser
              ? 'Adquirir (${appState.order!.courses.length}) por: \$${appState.order!.price}'
              : 'Completa tu información',
          function: () async {
            if (appState.isCompetedRegisterUser) {
              List tmp = await User.addCourse(appState.currentUser!,
                  appState.order!.courses.map((e) => e.reference).toList());
              Fluttertoast.showToast(
                  msg: 'Curso adquirido, gracias por su compra.');
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              appState.setCoursesTosUser(tmp);
            } else {
              Navigator.of(context).pop();
              Navigator.push<void>(
                context,
                CupertinoPageRoute<void>(
                  builder: (BuildContext context) => PageProfile(
                    user: appState.currentUser!,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
