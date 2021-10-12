import 'package:children_now/models/profile.dart';
import 'package:children_now/pages/contact.dart';
import 'package:children_now/pages/courses.dart';
import 'package:children_now/pages/help.dart';
import 'package:children_now/pages/history.dart';
import 'package:children_now/pages/my_courses.dart';
import 'package:children_now/pages/notifications.dart';
import 'package:children_now/providers/app_state.dart';
import 'package:children_now/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../alert_confirm.dart';

class DrawerHome extends StatelessWidget {
  const DrawerHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: appState.currentUser!.name != null
                ? Text('${appState.currentUser!.name}')
                : null,
            accountEmail: Text(appState.currentUser!.email),
            currentAccountPicture: Hero(
              tag: 'image',
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: appState.currentUser!.photo == null
                    ? Text(
                        appState.currentUser!.email[0].toUpperCase(),
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: FadeInImage(
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                            placeholder: const AssetImage('assets/lab.png'),
                            image: NetworkImage(appState.currentUser!.photo!))),
              ),
            ),
            decoration: const BoxDecoration(color: Color(0xff666264)
                /*
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment(
                    0.1, 0.0), // 10% of the width, so there are ten blinds.
                colors: <Color>[
                  Color(0xff666264),
                  Color(0xffCAC4C7)
                ], // red to yellow
                tileMode:
                    TileMode.mirror, // repeats the gradient over the canvas
              ),*/
                ),
          ),
          ListTile(
            title: const Text("Información personal"),
            leading: const Icon(Icons.people),
            onTap: () async {
              Navigator.of(context).pop();
              Navigator.push<void>(
                context,
                CupertinoPageRoute<void>(
                  builder: (BuildContext context) => PageProfile(
                    user: appState.currentUser!,
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Mis cursos"),
            leading: const Icon(Icons.read_more),
            onTap: () async {
              Navigator.of(context).pop();
              Navigator.push<void>(
                context,
                CupertinoPageRoute<void>(
                  builder: (BuildContext context) => const PageMyCourses(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Cursos y capacitaciones"),
            leading: const Icon(Icons.leaderboard),
            onTap: () async {
              Navigator.of(context).pop();
              Navigator.push<void>(
                context,
                CupertinoPageRoute<void>(
                  builder: (BuildContext context) => const PageCourses(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Notificaciones"),
            leading: const Icon(Icons.notifications),
            onTap: () async {
              Navigator.of(context).pop();
              Navigator.push<void>(
                context,
                CupertinoPageRoute<void>(
                  builder: (BuildContext context) => const PageNotifications(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Historial"),
            leading: const Icon(Icons.collections_bookmark),
            onTap: () async {
              Navigator.of(context).pop();
              Navigator.push<void>(
                context,
                CupertinoPageRoute<void>(
                  builder: (BuildContext context) => const PageHistory(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Contacto"),
            leading: const Icon(Icons.contact_mail),
            onTap: () async {
              Navigator.of(context).pop();
              Navigator.push<void>(
                context,
                CupertinoPageRoute<void>(
                  builder: (BuildContext context) => const PageContact(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Ayuda"),
            leading: const Icon(Icons.help),
            onTap: () async {
              Navigator.of(context).pop();
              Navigator.push<void>(
                context,
                CupertinoPageRoute<void>(
                  builder: (BuildContext context) => const PageHelp(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Cerrar sesión"),
            leading: const Icon(Icons.exit_to_app),
            onTap: () async {
              Navigator.of(context).pop();
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertConfirm(
                        title: '¿Salir?',
                        acept: () async {
                          await AuthService.logOut();
                          appState.currentUser = null;
                        },
                        cancel: () {});
                  });
            },
          ),
        ],
      ),
    );
  }
}
