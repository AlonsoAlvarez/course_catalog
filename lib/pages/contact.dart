import 'package:children_now/my_flutter_app_icons.dart';
import 'package:children_now/utils/launcher.dart';
import 'package:flutter/material.dart';

class PageContact extends StatelessWidget {
  const PageContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffCAC4C7),
      appBar: AppBar(
        backgroundColor: const Color(0xff666264),
        title: const Text('Contacto'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              const Expanded(
                  child: Text(
                'Telefono: 4941016698',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              )),
              IconButton(
                  onPressed: () {
                    Launcher.launchCall('4941016698');
                  },
                  icon: const Icon(
                    Icons.call,
                    color: Colors.blue,
                  )),
              IconButton(
                  onPressed: () {
                    Launcher.launchWP('4941016698');
                  },
                  icon: const Icon(
                    MyFlutterApp.whatsapp,
                    color: Colors.green,
                  )),
              const SizedBox(
                width: 30,
              )
            ],
          ),
          const Divider(),
          const Text(
            'alvarez.alonso.mario@gmail.com',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }
}
