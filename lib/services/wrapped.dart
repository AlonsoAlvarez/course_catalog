import 'package:children_now/models/user.dart';
import 'package:children_now/pages/home.dart';
import 'package:children_now/pages/login.dart';
import 'package:children_now/providers/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth.dart';

class Wrapped extends StatelessWidget {
  const Wrapped({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    if (appState.currentUser == null) {
      if (AuthService.currentUser != null) {
        User.getUser(AuthService.currentUser!.uid).then((value) {
          if (value != null) {
            appState.currentUser = value;
          }
        });
      }
      return const PageLogin();
    }
    return const PageHome();
  }
}
